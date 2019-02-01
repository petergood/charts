{{/*
Prefix onedata-chart-utils is used for templates here, as it is not
intuitive that functions for keycloak are included in onedata-chart-utils.
Thus in order to give user explicit information where to find definitions of
this templates we provide this prefix.
*/}}

{{- define "onedata-chart-utils.createGroupFun" -}}
  {{ indent 10 "" }}createGroup() {
  {{ indent 10 "" }}  group=$1 ;
  {{ indent 10 "" }}  parentId=$2 ;
  {{ indent 10 "" }}  keycloak_create_group=$(cat <<EEOF
  {{ indent 10 "" }}  {
  {{ indent 10 "" }}    "name": "$group"
  {{ indent 10 "" }}  }
  {{ indent 10 "" }}EEOF
  {{ indent 10 "" }}
  {{ indent 10 "" }}  );
  {{ indent 10 "" }}  if [ "$parentId" = "root" ]; then
  {{ indent 10 "" }}    groupId=$(echo "$keycloak_create_group" | curl -v -X POST "$keycloak_url/auth/admin/realms/$realmId/groups" -H 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAK_TOKEN" -d @- 2>&1 | grep 'Location:' | sed -ne 's#^.*/\(.*\)$#\1#p' | tr -d $'\r');
  {{ indent 10 "" }}  else
  {{ indent 10 "" }}    groupId=$(echo "$keycloak_create_group" | curl -v -X POST "$keycloak_url/auth/admin/realms/$realmId/groups/$parentId/children" -H 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAK_TOKEN" -d @- 2>&1 | grep 'Location:' | sed -ne 's#^.*/\(.*\)$#\1#p' | tr -d $'\r')
  {{ indent 10 "" }}  fi
  {{ indent 10 "" }}  echo "$groupId" ;
  {{ indent 10 "" }}} ;
{{- end }}

{{/*
Probably the most complex piece of template I've written.
This template traverses recursively a tree of groups, invoking on each node,
a bash function 'createGroup'. It generates a bash code that unfolds the recursion of this template,
saving groupIds in bash variables which names are randomly generated.
*/}}
{{- define "onedata-chart-utils.createKeycloakGroup" -}}
  {{ $groupIdVariableName := (printf "%s_%s_%s_%s" "groupId" .root.name (now | date "20060102030405") (randAlphaNum 10) ) }}
  {{ indent 10 "" }}{{ $groupIdVariableName }}=$(createGroup "{{ .root.name }}" "{{ .parentId }}" );
  {{ indent 10 "" }}echo "Created a group={{ .root.name }} groupId={{ printf "$%s" $groupIdVariableName }} with parentId={{ .parentId }}";
  {{ range $user := .root.idps.keycloak.users -}}
  {{ indent 10 "" }}groupUserId=$(curl --silent -X GET "$keycloak_url/auth/admin/realms/$realmId/users?username={{ $user.name }}" -H 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAK_TOKEN"  | jq -r '.[0].id') ;
  {{ indent 10 "" }}echo -n "Adding user={{ $user.name }} userId=$groupUserId to a group={{ $.root.name }} groupId={{ printf "$%s" $groupIdVariableName }} [response: " ;
  {{ indent 10 "" }}curl --silent -w "'%{http_code}'" -X PUT "$keycloak_url/auth/admin/realms/$realmId/users/$groupUserId/groups/{{ printf "$%s" $groupIdVariableName }}" -H 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAK_TOKEN" ;
  {{ indent 10 "" }}echo "] . Success." ;
  {{- end }}
  {{- if .root.idps.keycloak.children -}}
    {{- range $child := .root.idps.keycloak.children -}}
      {{ template "onedata-chart-utils.createKeycloakGroup" dict "root" $child "parentId" (printf "$%s" $groupIdVariableName) }}
    {{- end }}
  {{- end }}
{{- end }}

{{- define "onedata-chart-utils.createKeycloakUser" -}}
  {{ indent 10 "" }}keycloak_create_user=$(cat <<EEOF
  {{ indent 10 "" }}
  {{ indent 10 "" }}{
  {{ indent 10 "" }}  "enabled": true,
  {{ indent 10 "" }}  "firstName": "{{ .user.firstName }}",
  {{ indent 10 "" }}  "lastName": "{{ .user.lastName }}",
  {{ indent 10 "" }}  "email": "{{ .user.email }}",
  {{ indent 10 "" }}  "username": "{{ .user.name }}"
  {{ indent 10 "" }}}
  {{ indent 10 "" }}
  {{ indent 10 "" }}EEOF
  {{ indent 10 "" }}
  {{ indent 10 "" }});
  {{ indent 10 "" }}userId=$(echo "$keycloak_create_user" | curl -v -X POST "$keycloak_url/auth/admin/realms/$realmId/users" -H 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAK_TOKEN" -d @- 2>&1 | grep 'Location:' | sed -ne 's#^.*/\(.*\)$#\1#p' | tr -d $'\r');
  {{ indent 10 "" }}echo "Created a user={{ .user.name }} userId=$userId." ;
  {{ indent 10 "" }}
  {{ indent 10 "" }}keycloak_set_user_password=$(cat <<EEOF
  {{ indent 10 "" }}
  {{ indent 10 "" }}{
  {{ indent 10 "" }}  "temporary": false,
  {{ indent 10 "" }}  "type": "password",
  {{ indent 10 "" }}  "value": "{{ .user.password }}"
  {{ indent 10 "" }}}
  {{ indent 10 "" }}
  {{ indent 10 "" }}EEOF
  {{ indent 10 "" }}
  {{ indent 10 "" }});
  {{ indent 10 "" }}echo -n "Setting password={{ .user.password }} for a user={{ .user.name }} [response: " ;
  {{ indent 10 "" }}echo "$keycloak_set_user_password" | curl  --silent -w "'%{http_code}'" -X PUT "$keycloak_url/auth/admin/realms/$realmId/users/$userId/reset-password" -H 'Content-Type: application/json' -H "Authorization: Bearer $KEYCLOAK_TOKEN" -d @- 2>&1;
  {{ indent 10 "" }}echo "]. Success." ;
{{- end }}

{{- define "onedata-chart-utils.createKeycloakToken" -}}
$(curl --silent --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 32 -X POST "$keycloak_url/auth/realms/master/protocol/openid-connect/token" -H "Content-Type: application/x-www-form-urlencoded" -d "username={{ template "admin_username_template" . }}" -d "password={{ template "admin_password_template" . }}" -d 'grant_type=password' -d 'client_id=admin-cli' | jq -r '.access_token')
{{- end }}