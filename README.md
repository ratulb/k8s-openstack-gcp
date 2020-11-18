# Kubernetes cluster in openstack deployed inside a google compute engine.

Here we deploy openstack(https://docs.openstack.org/) in a google cloud compute instance using devstack(https://github.com/openstack/devstack). We follow this with deploying a kubernetes cluster inside two VMs provisioned inside openstack setup.

This is a push button deployment - all we need is a GCP(https://console.cloud.google.com/) compute engine with min 4 vCPUs and 16 GB RAM. More is better for smooth experience. 

There is one caveat though - the compute engine should support nested virtualization which is not available by default in google compute engines. 

We need to create a boot disk tagged for virtualization support and launch the VM based off of it in region selecting N1 series of CPUs. That's all. How to do that is available in http://rbsomeg.blogspot.com/.

How to execute:
Check out this repository to your google compute engine and fire the following command from within the repository:
sudo ./launch.sh

The execute the next 3 commands namely:
 cd devstack
./stack.sh
./dev-tenant-setup.sh

And you are all set!
