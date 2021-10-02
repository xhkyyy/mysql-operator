


#====================================================================================================

# install
helm install mysql-operator ./charts/mysql-operator --set orchestrator.persistence.enabled=false

cat <<EOF | kubectl apply -f-
apiVersion: mysql.presslabs.org/v1alpha1
kind: MysqlCluster
metadata:
  name: my-cluster
spec:
  replicas: 2
  secretName: my-cluster-secret
---
apiVersion: v1
kind: Secret
metadata:
  name: my-cluster-secret
type: Opaque
data:
  ROOT_PASSWORD: $(echo -n "root123" | base64)
EOF

#====================================================================================================

# uninstall
helm uninstall mysql-operator

cat <<EOF | kubectl delete -f-
apiVersion: mysql.presslabs.org/v1alpha1
kind: MysqlCluster
metadata:
  name: my-cluster
spec:
  replicas: 2
  secretName: my-cluster-secret
---
apiVersion: v1
kind: Secret
metadata:
  name: my-cluster-secret
type: Opaque
data:
  ROOT_PASSWORD: $(echo -n "root123" | base64)
EOF

#====================================================================================================

# orchestrator
kubectl port-forward service/mysql-operator 8080:80

#====================================================================================================
