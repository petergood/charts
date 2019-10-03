

oz_rest_cli="/usr/local/bin/onezone-rest-cli"

define_addChildGroup() {
  _addChildGroupCurl=$(${oz_rest_cli} --dry-run \$CURL_ARGS addChildGroup id=\$id cid=\$cid | sed -r 's/-H "(X-Auth-Token.*)" /-H '\''\1'\''/')
  _addChildGroup(){
    while (( $# )); do first=$1 ; eval "$1" ; shift ; done ; 
    eval $debug ${_addChildGroupCurl}
  }
}
define_addChildGroup

#| sed "/-d '{.*}'/{s/\"/\\\"/g;s/'/\"/g}"
define_createGroup() {
  _createGroupCurl=$(${oz_rest_cli} -v --dry-run \${CURL_ARGS[*]} createGroup name==\$name | sed -r 's/-H "(X-Auth-Token.*)" /-H '\''\1'\''/' | sed -e "s/\"/\\\\\"/g" -e "s/-d '\({.*}\)'/-d \"\1\"/" | rev | sed -e 's/\"\\/\"/' -e 's/\"\\/\"/' | rev)
  _createGroup(){
    while (( $# )); do eval "${1//==/=}" ; shift ; done ;
    echo "name=<$name>";
    echo ${CURL_ARGS[*]}
    echo ${_createGroupCurl}
    eval $debug ${_createGroupCurl}
  }
}
define_createGroup

define_addGroupUser() {
  _addGroupUserCurl=$(${oz_rest_cli} --dry-run \$CURL_ARGS addGroupUser id=\$id uid=\$uid | sed -r 's/-H "(X-Auth-Token.*)" /-H '\''\1'\''/')
  _addGroupUser(){
    while (( $# )); do eval "$1" ; shift ; done ; 
    eval $debug ${_addGroupUserCurl}
  }
}
define_addGroupUser


define_getSpace() {
  _getSpaceCurl=$(${oz_rest_cli} --dry-run \$CURL_ARGS getSpace id=\$id | sed -r 's/-H "(X-Auth-Token.*)" /-H '\''\1'\''/')
  _getSpace(){
    while (( $# )); do eval "$1" ; shift ; done ; 
    eval $debug ${_getSpaceCurl}
  }
}
define_getSpace

define_getGroup() {
  _getGroupCurl=$(${oz_rest_cli} -v --dry-run \$CURL_ARGS getGroup id=\$id | sed -r 's/-H "(X-Auth-Token.*)" /-H '\''\1'\''/')
  _getGroup(){  
    while (( $# )); do eval "$1" ; shift ; done ;
    eval $debug ${_getGroupCurl}
  }
}
define_getGroup

onezone-rest-cli() {
  CURL_ARGS=()
  while (( $# )); do
      case $1 in
          -*)
              CURL_ARGS+=($1 $2)
              shift
              ;;
          getGroup)
              shift
              _getGroup "$@"
              return
              ;;
          getSpace)
              shift
              _getSpace "$@"
              return
              ;;
          createGroup)
              shift
              _createGroup "$@"
              return
              ;;
          addGroupUser)
              shift
              _addGroupUser "$@"
              return
              ;;
          addChildGroup)
              shift
              _addChildGroup "$@"
              return
              ;;
          *)
              printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
              ;;
      esac
      shift
  done
}


test() {
#getGroup
_onezone-rest-cli -u admin:password getGroup
#getGroup id=
_onezone-rest-cli -u admin:password getGroup id=791a8348bd45f3b452ae2018a77a63e3
#addChildGroup
_onezone-rest-cli -u admin:password -w "'%{http_code}'" -d "'{ \"privileges\": [ \"group_create_space\", \"group_delete\", \"group_invite_group\", \"group_invite_user\", \"group_join_group\", \"group_join_space\", \"group_leave_space\", \"group_remove_group\", \"group_remove_user\", \"group_set_privileges\", \"group_update\", \"group_view\" ]}'" -H "'Content-type: application/json'" addChildGroup id=parent_group_id cid=child_group_id ;
#createGroup
_onezone-rest-cli -w "'%{http_code}'" -u admin:password createGroup name=='alphax'
#addGroupUser
_onezone-rest-cli -u admin:password -w "'%{http_code}'" -d "'{ \"privileges\": [ \"group_create_space\", \"group_delete\", \"group_invite_group\", \"group_invite_user\", \"group_join_group\", \"group_join_space\", \"group_leave_space\", \"group_remove_group\", \"group_remove_user\", \"group_set_privileges\", \"group_update\", \"group_view\" ]}'" -H "'Content-type: application/json'" addGroupUser id=groupId uid=userId
}