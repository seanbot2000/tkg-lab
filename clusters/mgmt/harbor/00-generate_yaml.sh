#bin/bash

mkdir -p clusters/mgmt/harbor/generated/

# 01-namespace.yaml
yq read clusters/mgmt/harbor/01-namespace.yaml > clusters/mgmt/harbor/generated/01-namespace.yaml

# 02-certs.yaml
yq read clusters/mgmt/harbor/02-certs.yaml > clusters/mgmt/harbor/generated/02-certs.yaml
yq write clusters/mgmt/harbor/generated/02-certs.yaml -i "spec.commonName" $HARBOR_CN
yq write clusters/mgmt/harbor/generated/02-certs.yaml -i "spec.dnsNames[0]" $HARBOR_CN
yq write clusters/mgmt/harbor/generated/02-certs.yaml -i "spec.dnsNames[1]" $NOTARY_CN

# harbor-values.yaml
yq read clusters/mgmt/harbor/harbor-values.yaml > clusters/mgmt/harbor/generated/harbor-values.yaml
yq write clusters/mgmt/harbor/generated/harbor-values.yaml -i "expose.ingress.hosts.core" $HARBOR_CN
yq write clusters/mgmt/harbor/generated/harbor-values.yaml -i "expose.ingress.hosts.notary" $NOTARY_CN  
yq write clusters/mgmt/harbor/generated/harbor-values.yaml -i "externalURL" https://$HARBOR_CN