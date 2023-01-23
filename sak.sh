# sak.sh
#
# Add ssh rsa id to ssh agent
# 
# usage ./sak.sh

eval $(ssh-agent)
ssh-add -K ~/.ssh/id_rsa
