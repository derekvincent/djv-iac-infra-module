### Customer Gateway with VPN attachment to Transit Gateway
Provisions an IPSec customer gateway and creates a VPN attachment to the specified transit gateway, and related routing. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bgp\_asn | BGP ASN | `string` | `"65000"` | no |
| customer | Customer Name - billing tag | `string` | n/a | yes |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| ip\_address | Customer VPN IP address | `string` | n/a | yes |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| static\_routes\_only | Determine if the VPN will static route of BGP. | `bool` | `false` | no |
| target | The VPN partner or target name being deployed for. | `string` | n/a | yes |
| target\_static\_route\_cidrs | A list of CIDR's that will be added to the static route table for the VPN connection | `list(any)` | `[]` | no |
| transit\_gateway\_id | Transit Gateway ID to attachment to | `string` | n/a | yes |
| transit\_gateway\_route\_table\_id | The ID of the Transit Gateway route table you want to add the VPN target routes to. | `string` | `""` | no |
| tunnel1\_ike\_versions | IKE Version [ikev1, ikev2] | `list(string)` | `null` | no |
| tunnel1\_phase1\_dh\_group\_numbers | Phase 1 DH group numbers [ 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 ]. | `list(number)` | `null` | no |
| tunnel1\_phase1\_encryption\_algorithms | Phase 1 encryption algorithms [ ES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 ]. | `list(string)` | `null` | no |
| tunnel1\_phase1\_integrity\_algorithms | Phase 1 integrity algorithms [ SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 ]. | `list(string)` | `null` | no |
| tunnel1\_phase2\_dh\_group\_numbers | Phase 2 DH group numbers [ 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 ]. | `list(number)` | `null` | no |
| tunnel1\_phase2\_encryption\_algorithms | Phase 2 encryption algorithms [ AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 ]. | `list(string)` | `null` | no |
| tunnel1\_phase2\_integrity\_algorithms | Phase 2 integrity algorithms [ SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 ]. | `list(string)` | `null` | no |
| tunnel2\_ike\_versions | IKE Version [ikev1, ikev2] | `list(string)` | `null` | no |
| tunnel2\_phase1\_dh\_group\_numbers | Phase 1 DH group numbers [ 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 ]. | `list(number)` | `null` | no |
| tunnel2\_phase1\_encryption\_algorithms | Phase 1 encryption algorithms [ ES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 ]. | `list(string)` | `null` | no |
| tunnel2\_phase1\_integrity\_algorithms | Phase 1 integrity algorithms [ SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 ]. | `list(string)` | `null` | no |
| tunnel2\_phase2\_dh\_group\_numbers | Phase 2 DH group numbers [ 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24 ]. | `list(number)` | `null` | no |
| tunnel2\_phase2\_encryption\_algorithms | Phase 2 encryption algorithms [ AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16 ]. | `list(string)` | `null` | no |
| tunnel2\_phase2\_integrity\_algorithms | Phase 2 integrity algorithms [ SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512 ]. | `list(string)` | `null` | no |
| type | Customer Gateway Type. Only supported type currently is ipsec.1 | `string` | `"ipsec.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| customer\_gateway\_id | Customer Gateway ID. |
| vpn\_attachment\_id | Customer Gateway VPN attachment id to the customer gateway. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->