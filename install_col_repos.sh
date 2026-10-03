# Run in code/ansible

mkdir -p ~/github/ansible/collections/ansible_collections/eingram23
ansible-galaxy collection install -r requirements.yml -p ~/github/ansible/collections --force
cd ~/github/ansible/collections/ansible_collections/eingram23

git clone git@github.com:eingram-homelab/ansible-col-homelab.git ~/github/ansible/collections/ansible_collections/eingram23/homelab
git clone git@github.com:eingram-homelab/ansible-col-containers.git ~/github/ansible/collections/ansible_collections/eingram23/containers
git clone git@github.com:eingram-homelab/ansible-col-tf_build.git ~/github/ansible/collections/ansible_collections/eingram23/tf_build
git clone git@github.com:eingram-homelab/ansible-col-database.git ~/github/ansible/collections/ansible_collections/eingram23/database
git clone git@github.com:eingram-homelab/ansible-col-kubernetes.git ~/github/ansible/collections/ansible_collections/eingram23/kubernetes
git clone git@github.com:eingram-homelab/ansible-col-pihole.git ~/github/ansible/collections/ansible_collections/eingram23/pihole
git clone git@github.com:eingram-homelab/ansible-col-vsphere.git ~/github/ansible/collections/ansible_collections/eingram23/vsphere
git clone git@github.com:eingram-homelab/ansible-col-gcp.git ~/github/ansible/collections/ansible_collections/eingram23/gcp

