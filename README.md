# Clockwork Infrastructure Terraform Modules for Landing Zones

The following list of Terraform modules used for deployment of a SAP Landing Zone. 

***NOTE: If planning on using these modules as is it is important to verify in the modules what they actually delivery. They are a work in progress and may not provide functionality even though their is an input parameter in place.***

## Bootstrap
Setup up the the initial S3 buckets and DynamoDB for a new Terraform landing zone location.  This is often used in a new Account, Region or VPC and everything else will leverage this and be deployed within it. 

More info: [README](./bootstrap/README.md)

## VPC
Provisions a new VPC along with the default security group, route table, ACL, Internet Gateway, DHCP options.  

More info: [README](./vpc/README.md)

## Subnet 
Provisions a set of subnets that can either be Public or Private based in the specified VPC and AZs. 

More info: [README](./subnets/README.md)

## VPC Endpoints
Create a VPC endpoint, currently only support S3 endpoints.

More info: [README](./vpc-endpoints/README.md)

## Transit Gateway
Provisions a Transit Gateway, a VPC attachment to the source VPC, transit gatway route tables, as well as RAM shares. 

More info: [README](transit-gateway/README.md)
## Transit Gateway Attachments
Provisions a Transit Gateway attachment between a VPC and the Transit Gateway as well as a route in the local route tables. 

More into: [REAME](./transit-gateway-attachment/README.md)


## Direct Connect - Virtual Private gateway
This module will create a `Virtual Gateway` associate it with the VPC referenced, enables route propagation with referenced route tables and creates a association proposal to the referenced `Direct Connect Gateway`. 

More info: [README](./virtual-private-gateway-dx/README.md)

## Customer Gateway and Transit Gateway attachment
Provisions an IPSec customer gateway and creates a VPN attachment to the specified transit gateway, and related routing. 

More info: [README](./customer-gateway/README.md)
## Route53
Creates a Private Route53 zone and attaches the default VPC to it. 

More info: [README](./route53/README.md)

## Route53 Records
Manage Route53 DNS records in the created zones. Provides the ability to create an a, cname and reverse record in-addr.arpa. 

More info: [README](./route53-records/README.md)

## Route53 Resolver

Create inbound and outbound Route53 DNS endpoint resolvers to allow forwarding dns requests between route53 and on premise DNS server. 

More info: [REAME](./route53-resolver/README.md)


## Route53 Resolver Association

Associate additional VPC (with the Route53 and Resolvers in it) with the Route53 rule sets to be able to route DNS requests to and from on-premise DNS. 

More info: [README](./route53-resolver-association/README.md)

## Route53 Zone Association

Manage the association between additional VPC's and the Route53 domain. Allows for VPC's in other account to be part of a single Route53 private domain. 

More info: [README](./route53-zone-association/README.md)
## Route53 Zone Association Authorization

Manage the association between additional VPC's and the Route53 domain. Allows for VPC's in other account to be part of a single Route53 private domain. 

More info: [README](./route53-zone-association-authorization/README.md)


## Elastic File System
Provisions a EFS along with the lifecycle policy, file system policy, mount targets, specified access points, and security group.

More Info: [README](./elastic-file-system/README.md)

## File Gateway
Provisions a Storage Gateway as a File Gateway along with an file gateway instance, a IAM roles and a security group. 

More Info: [README](./file-gateway/README.md)

## File Gateway - NFS Share 
Creates an NFS based share against the specified File Gateway. 

More Info: [README](./file-gateway-nfs-share/README.md)

## Storage Gateway S3 Bucket 
Creates a S3 Bucket that can be used as a target for a File Gateway share. Supports buckets that maybe in separate accounts then the storage gateway with an cross-account IAM role. 

More Info: [README](./storage-gateway-bucket/README.md)

## S3 Bucket
Allows for the creation of an S3 bucket.

More Info: [README](./s3-bucket/README.md)

## SAP PO Application Load Balancer
Allows for the provision of an AWS ALB along with a listener, default rule, targets, target groups, association to an certificate, security group and forward rules to a backend. 

More Info: [README](./sap-po-alb/README.md)

## Routing - Rule against Transit Gateway/VPC Peering
Allows for the setting defined routing rules against a specific table and against a Transit Gateway or VPC peering connection.

More Info: [README](./routing/README.md)

## Peering
Provisions VPC peering between VPC, handles the requestor/acceptor setting as well as default routing between peered VPC's.

More Info: [README](./peering/README.md)

## CommVault Media Agent 
Provisions an instance of a CommVault AMI for a media agent. 

More Info: [README](./commvault-media-agent/README.md)