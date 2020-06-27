# Register consul repo
helm repo add hashicorp https://helm.releases.hashicorp.com

# Get consul chart from report
helm search repo hashicorp/consul

# Inspect consul chart from repo
helm inspect values hashicorp/consul | more

