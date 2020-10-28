set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** testing docker run - bash *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Test docker run of Bash: $ANSI_RESET"
docker run -i --name some-bash quay.io/ibmz/bash:4.4 bash --version
docker inspect some-bash | grep 'Running'

# expecting
# Hello World!
docker exec -i some-bash echo 'Hello World!'

docker rm some-bash

echo -e "\n $ANSI_GREEN *** TEST COMPLETED SUCESSFULLY *** $ANSI_RESET \n"
