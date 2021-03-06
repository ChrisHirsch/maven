#!/bin/bash

source_path="$1"
cmd="$2"
maven_options="$3"

function usage() {
   echo "$0 <source_path> \"<command>\""
   echo "$0 ~/src/myproject/UI \"/usr/local/maven/bin/mvn -DskipTests -P buildrpm -U package -f /myproject/UI/pom.xml\""
   echo "$0 ~/src/myproject/UI \"-DskipTests -P buildrpm -U package UI/pom.xml\""

   echo -e "\nsource_path is relative to /myproject because it will be mounted to /myproject"
}

if [ -z "${source_path}" ]; then
   echo "Need to supply the host source path like ~/src/myproject/UI"
   usage
   exit 1
fi

if [ -z "${maven_options}" ]; then
   maven_options="-DskipTests -P buildrpm -U package"
fi

if [ -z "${cmd}" ]; then
   cmd="/bin/bash"
else
   cmd="/usr/local/maven/bin/mvn ${maven_options} -f /myproject/${cmd}"
fi

echo "Source path is ${source_path}"
echo "Command is ${cmd}"

docker run -v ${source_path}:/myproject -a stdin -a stdout -i -t maven ${cmd}
