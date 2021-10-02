

## 关于域名

* `<cluster_name>-mysql-master` is the service that points to the master node and this endpoint
 should be used for writes. This service is usually used to construct the DSN.
* `<cluster_name>-mysql` is the service that routes traffic to _all healthy_ nodes from the
 cluster. You should use this endpoint for reads.
* `mysql` is the service used internally to access all nodes within a namespace. You can use this
 service to access a specific node (e.g. `<cluster_name>-mysql-0.mysql.<namespace>`)


## mysql 域名测试

kubectl run -i --tty busybox --image=busybox --restart=Never --rm=true -- sh

* 写请求：telnet `my-cluster-mysql-master` 3306
* 读请求：telnet `my-cluster-mysql` 3306   telnet `my-cluster-mysql-replicas` 3306



















