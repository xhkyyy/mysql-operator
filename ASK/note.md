

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


kubectl run -i --tty mysql --image=mysql:5.7.35 --restart=Never --rm=true -- sh

```sql
-- MASTER: mysql -uroot -proot123 -hmy-cluster-mysql-master -P3306
show databases;

CREATE DATABASE mytestdb CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS mytestdb (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num INT,
    title VARCHAR(50)
)  ENGINE=INNODB;

show tables;

insert into mytestdb(num,title) values(100, 'hello mysql');

select * from mytestdb;

select count(*) from mytestdb;
```


```sql
-- SLAVE: mysql -uroot -proot123 -hmy-cluster-mysql-replicas -P3306
use mytestdb;

show tables;

select * from mytestdb;

insert into mytestdb(num,title) values(200, 'hello kubernetes'); -- 因为 --super-read-only option 一定会报错
```

```sql
-- ALL: mysql -uroot -proot123 -hmy-cluster-mysql -P3306
use mytestdb;

show tables;

select * from mytestdb;

insert into mytestdb(num,title) values(200, 'hello kubernetes'); -- 因为 --super-read-only option 一定会报错
```
















