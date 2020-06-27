# #TerraformOnAzure Challenge - episode 5

The fifth challenge of the [Terraform On Azure](https://github.com/Terraform-On-Azure-Workshop/terraform-azure-hashiconf2020) asks you to provision a one-node consul cluster on the AKS cluster deployed in [Challenge 4](https://github.com/OmegaMadLab/TerraformOnAzure-Challenge4), and to use it to federate with an existing primary datacenter, to create a network between all the webapps deployed by other participants.

We have to deploy Consul via a Helm chart, using the appropriate Terraform provider. Then, we have to create a Public IP and a service to expose our environment, again via Terraform.
You can read more about the challenge [here](https://github.com/Terraform-On-Azure-Workshop/terraform-azure-hashiconf2020/blob/main/challenges/challenge5/Readme.md).

I used **init.sh** to retrieve the default Helm chart for Consul, to check default values.
I managed the remaining part of the configuration with Terraform.

I executed all the steps above on Ubuntu 18.04 WSL2.

The ouput of *consul members -wan* was:  
>/ # consul members -wan  
>Node                  Address           Status  Type    Build       Protocol  DC     Segment  
>consul-server-0.dc1   10.244.0.12:8302  alive   server  1.8.0beta2  2         dc1    <all>  
>consul-server-0.eveld 10.244.0.15:8302  alive   server  1.8.0beta2  2         eveld  <all>  

My other repos, on for each challenge:
+ [Challenge 1](https://github.com/OmegaMadLab/TerraformOnAzure-Challenge1)
+ [Challenge 2](https://github.com/OmegaMadLab/TerraformOnAzure-Challenge2)
+ [Challenge 3](https://github.com/OmegaMadLab/TerraformOnAzure-Challenge3)
+ [Challenge 4](https://github.com/OmegaMadLab/TerraformOnAzure-Challenge4)