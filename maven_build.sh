#!/bin/bash

source_path="$1"
cmd="$2"

function usage() {
   echo "$0 <source_path> \"<command>\""
   echo "$0 ~/src/myproject/UI \"/usr/local/maven/bin/mvn -DskipTests -P buildrpm -U package -f /myproject/UI/pom.xml\""

   echo -e "\nsource_path is relative to /myproject because it will be mounted to /myproject"
}

if [ -z "${source_path}" ]; then
   echo "Need to supply the host source path like ~/src/myproject/UI"
   usage
   exit 1
fi

if [ -z "${cmd}" ]; then
   echo 'Need to supply the command to run on the box like "/usr/local/maven/bin/mvn -DskipTests -P buildrpm -U package -f /myproject/UI/pom.xml" '
   usage
   exit 1
fi

echo "Source path is ${source_path}"
echo "Command is ${cmd}"

docker run -v ${source_path}:/myproject -a stdin -a stdout -i -t maven ${cmd}
