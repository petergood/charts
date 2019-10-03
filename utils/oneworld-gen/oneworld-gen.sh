#!/usr/bin/env bash

cities=(
  # city long lat
  "Krakow 50.0647 19.9450 krk"
  "Paris 48.8566 2.3522 par"
  "Lisbon 38.7223 -9.1393 lis"
  "Kabul 34.51666667 69.183333 kab"
  "Yerevan 40.16666667 44.5 yer"
  "Tokyo 35.6895 139.6917 tyo"
  "Minsk 53.9 27.566667 mnk"
  "Ottawa 45.41666667 -75.7 otw"
  "NDjamena 12.1 15.033333 ndj"
  "Berlin 52.51666667 13.4 ber"
  "Zagreb 45.8 16.1 zag" # fix 16.0
  "Nicosia 35.16666667 33.366667 nic"
  "Cairo 30.05 31.25 cai"
  "Beijing 39.91666667 116.383333 bjn"
  "SanFrancisco 37.7749 -122.4194 snf"
  "NewYork 40.7128 -74.0060 ny"
  "Austin 30.2672 -97.7431 aust"
  "Chicago 41.8781 -87.6298 chic"
  "Mexico 19.4326 -99.1332 mxc"
  "Panama 8.5380 -80.7821 pan"
  "Lima -12.0464 -77.0428 lim"
  "Brasilia -15.7942 -47.8822 brs"
  "Santiago -33.4489 -70.6693 snt"
  "Melbourne -37.8136 144.9631 mlb"
  "Juneau 58.3019 -134.4197 jun"
)
N=25

deployment_template="onedata-template"
template_name=$deployment_template

deployment_dir="onedata-${N}p"
name=$deployment_dir 
rm -rf $deployment_dir
mkdir $deployment_dir

cp $deployment_template/Chart.yaml $deployment_dir/Chart.yaml 
sed -i "s/name: $template_name/version: $name/" $deployment_dir/Chart.yaml

cp $deployment_template/.helmignore $deployment_dir/.helmignore

cp $deployment_template/Chart.yaml $deployment_dir/Chart.yaml 
sed -i "s/name: $template_name/name: $name/" $deployment_dir/Chart.yaml

cp $deployment_template/requirements.yaml $deployment_dir/requirements.yaml
cp $deployment_template/values.yaml $deployment_dir/values.yaml

for (( i=0; i < $N; i++ ))
do
   IFS=' ' read city longitude latitude short  <<<"${cities[$i]}"
   echo "$i: $city $longitude $latitude $short" 
   city_lcase=$(echo "$city" | tr '[:upper:]' '[:lower:]' )

cat <<EOF >>$deployment_dir/requirements.yaml

- name: oneprovider
  alias: oneprovider-${city_lcase}
  version: 0.2.9
  repository: file://../../oneprovider

EOF

cat <<EOF >>$deployment_dir/values.yaml

oneprovider-${city_lcase}:
  suffix: &op${i}s ${city_lcase}
  geoLatitude: $longitude
  geoLongitude: $latitude

  image: *op_image
  onepanel_batch_mode_enabled: *onepanel_batch_mode_enabled
  onedata_anti_affinity_enabled: *onedata_anti_affinity_enabled
  log_level: *log_level
  nameOverride: oneprovider

  oneprovider_nodes_count: *oneproviders_nodes_count
  cluster_config: *oneprovider_cluster_configs

  onezone_service_url:
    type: auto-generate
    disableSuffix: true

  generate-certificates: 
    enabled: *oneproviders_generate_certificates

  luma:
    suffix: *op${i}s
    << : *luma_global

  oneclient:
    image: *oc_image
    debug_mode: *oneclients_debug_mode_enabled
    enabled: *oneclients_enabled
    suffix: *op${i}s
    onedata_cli:
      image: *cli_image
  onedata-cli:
    image: *cli_image
    enabled: *onedata_cli_enabled
    suffix: *op${i}s
  posix:
    enabled: *posix_enabled
    luma-enabled: *luma_enabled_posix
  volume-s3:
    enabled: *s3_enabled
    suffix: *op${i}s
    luma-enabled: *luma_enabled_s3
  volume-ceph:
    enabled: *ceph_enabled
    suffix: *op${i}s
    luma-enabled: *luma_enabled_ceph
  volume-nfs:
    enabled: *nfs_enabled
    suffix: *op${i}s
    luma-enabled: *luma_enabled_nfs
  volume-gluster:
    enabled: *gluster_enabled
    suffix: *op${i}s
    luma-enabled: *luma_enabled_gluster
  volume-swift:
    enabled: *swift_enabled
    suffix: *op${i}s
    luma-enabled: *luma_enabled_swift

EOF

done

## Init job
deployment_template="cross-support-job-template"
template_name=$deployment_template

deployment_dir="cross-support-job-${N}p"
name=$deployment_dir 
rm -rf $deployment_dir
mkdir $deployment_dir

cp $deployment_template/Chart.yaml $deployment_dir/Chart.yaml 
sed -i "s/name: $template_name/name: $name/" $deployment_dir/Chart.yaml

cp $deployment_template/.helmignore $deployment_dir/.helmignore

cp $deployment_template/Chart.yaml $deployment_dir/Chart.yaml 
sed -i "s/name: $template_name/name: $name/" $deployment_dir/Chart.yaml

cp $deployment_template/requirements.yaml $deployment_dir/requirements.yaml
cat <<EOF >>$deployment_dir/requirements.yaml

- name: onedata-${N}p
  version: 0.2.5
  repository: file://../onedata-${N}p
  condition: onedata-${N}p.enabled

EOF

cp $deployment_template/values.yaml $deployment_dir/values.yaml
cp -r $deployment_template/templates $deployment_dir/




sed -i "s/onedata-template:/onedata-${N}p:/" $deployment_dir/values.yaml
cat <<EOF >>$deployment_dir/values.yaml

oneprovider:
EOF

for (( i=0; i < $N; i++ ))
do
   IFS=' ' read city longitude latitude short  <<<"${cities[$i]}"
   echo "$i: $city $longitude $latitude $short" 
   city_lcase=$(echo "$city" | tr '[:upper:]' '[:lower:]' )

cat <<EOF >>$deployment_dir/values.yaml
  - oneprovider-$city_lcase
EOF
done
ls $deployment_dir ;


cat <<EOF >>$deployment_dir/values.yaml

spaces:
EOF

for (( i=0; i < $N; i++ ))
do
   IFS=' ' read city longitude latitude short  <<<"${cities[$i]}"
   echo "$i: $city $longitude $latitude $short" 
   city_lcase=$(echo "$city" | tr '[:upper:]' '[:lower:]' )

cat <<EOF >>$deployment_dir/values.yaml
  - name: "${short}-c"
    supports:
      - provider: "$city"
        storage_name: "ceph"
        size: '1000000000'
EOF
done

helm dependency update onedata-${N}p
helm dependency update cross-support-job-${N}p
echo helm install --debug --timeout 480 --namespace p$N -n p$N -f ../values-otc.yml cross-support-job-${N}p