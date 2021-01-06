output "vpc_acceptor" {
  value = data.aws_vpc.acceptor.*
}

output "vpc_requestor" {
  value = data.aws_vpc.requestor.*
}