# sak.sh
#
# Add ssh rsa id to ssh agent
#
# Usage: ./sak.sh

eval $(ssh-agent)
ssh-add -K ~/.ssh/id_rsa
