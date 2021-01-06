# Clockwork AWS SAP Networking Terraforms


These are somewhat opionated based on deployment and landing zones for SAP workloads. 

## VPC

### Features
- Creation of a VPC 
    - enable_dns_hostnames
    - enable_dns_support
- Creation of VPC secuirty group 
    - ***Needs to be finished***
- Creation of VPC default route table  
    - ***Needs to be finsihed***
- Creation of a Internet Gateway
- Creation of a DHCP option set
- Association of the option set to the VPC

### Input 
- vpc_cide - VPC CIDR range 
- enable_dns_hostnames - Enable DNS hostnames
- enable_dns_support - Enable DNS support 
- enable_internet_gateway = Enable the creation of an internet GW 
- dns_domain_name - DHCP DNS domain name 
- dns_server_list - DHCP DNS server list  

### Output

- vpc_id
- vpc_cidr_block
- iwg_is
- vpc_default_security_group_id
- vpc_main_route_table_id
- vpc_default_network_acl_id

## Subnets

Private and public subnets can be created based on the input `type`. A map of the AZ and CIDR for each subnet is passed in to be created. 

**Public subnets** will create a single route table and assign the VPC internet gateway to it as its default route. They also have the option `enable_nat_gateway` of creating a single NAT Gateway in the first AZ. 

**Private subnet** will create a single route table and assign a NAT gateway (potentially that is create in the public subent) as it default route for internet access. 

### Features - Private Subnet

- 
