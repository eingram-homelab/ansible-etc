# Run in code/ansible

mkdir ~/code/ansible/collections/ansible_collections/eingram23
ansible-galaxy collection install -r requirements.yml -p ~/code/ansible/collections
cd ~/code/ansible/collections/ansible_collections/eingram23

git clone git@github.com:eingram23/ansible-col-homelab.git ./homelab
git clone git@github.com:eingram23/ansible-col-containers.git ./containers
git clone git@github.com:eingram23/ansible-col-tf_build.git ./tf_build
git clone git@github.com:eingram23/ansible-col-database.git ./database
git clone git@github.com:eingram23/ansible-col-kubernetes.git ./kubernetes
git clone git@github.com:eingram23/ansible-col-pihole.git ./pihole
git clone git@github.com:eingram23/ansible-col-vsphere.git ./vsphere
git clone git@github.com:eingram23/ansible-col-splunk.git ./splunk
git clone git@github.com:eingram23/ansible-col-gcp.git ./gcp
git clone git@github.com:eingram23/ansible-col-monitoring.git ./monitoring
