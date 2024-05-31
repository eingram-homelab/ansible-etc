# Run in code/ansible

mkdir -p ~/code/ansible/collections/ansible_collections/eingram23
ansible-galaxy collection install -r requirements.yml -p ~/code/ansible/collections --force
cd ~/code/ansible/collections/ansible_collections/eingram23

git clone git@github.com:eingram23/ansible-col-homelab.git ~/code/ansible/collections/ansible_collections/eingram23/homelab
git clone git@github.com:eingram23/ansible-col-containers.git ~/code/ansible/collections/ansible_collections/eingram23/containers
git clone git@github.com:eingram23/ansible-col-tf_build.git ~/code/ansible/collections/ansible_collections/eingram23/tf_build
git clone git@github.com:eingram23/ansible-col-database.git ~/code/ansible/collections/ansible_collections/eingram23/database
git clone git@github.com:eingram23/ansible-col-kubernetes.git ~/code/ansible/collections/ansible_collections/eingram23/kubernetes
git clone git@github.com:eingram23/ansible-col-pihole.git ~/code/ansible/collections/ansible_collections/eingram23/pihole
git clone git@github.com:eingram23/ansible-col-vsphere.git ~/code/ansible/collections/ansible_collections/eingram23/vsphere
git clone git@github.com:eingram23/ansible-col-splunk.git ~/code/ansible/collections/ansible_collections/eingram23/splunk
git clone git@github.com:eingram23/ansible-col-gcp.git ~/code/ansible/collections/ansible_collections/eingram23/gcp
git clone git@github.com:eingram23/ansible-col-monitoring.git ~/code/ansible/collections/ansible_collections/eingram23/monitoring
