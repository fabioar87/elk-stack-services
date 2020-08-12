# README #

Neueda technical test.

### Technical Requirements ###

Some technical requirements to implement the solution. I implemented locally, with no CSP (Cloud Service Provider) service. Kind has been used to create a kubernetes cluster environment locally.
There are some limitations in this approach, such as using Services kubernetes object LoadBalancer. However for the purpose of demonstrate the solution implementation, some work around can be taken for exaample, using NodePort as Service.

* Go version 1.13+ [Go official page](https://golang.org/)
* Kind (Kubernets in Docker) version v0.9.0 [Kind official page](https://kind.sigs.k8s.io/)
* Linux operating system

## Local Cluster Configuration ##
