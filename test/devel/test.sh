set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** testing docker run - bash *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Test docker run of Bash: $ANSI_RESET"
docker run -i --rm --name version-bash quay.io/ibm/bash:devel bash --version

# expecting
# Hello World!
docker run -i --rm --name hello-bash quay.io/ibm/bash:devel echo 'Hello World!'

echo -e "\n $ANSI_GREEN *** TEST COMPLETED SUCESSFULLY *** $ANSI_RESET \n"
