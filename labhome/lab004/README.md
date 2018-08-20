# [실습 4] 클러스터에 동일한 설정 배포

[TOC]

## LAB

### Kubernetes Cluster

실습을 위한 쿠버네티스 클러스터 구성 정보 확인



```shell

# LAB004 실습을 위한 경로로 이동
$ cd ~/labhome/lab004
$ pwd
/home/jhlee/labhome/lab004

$ kubectl cluster-info 
Kubernetes master is running at https://192.168.99.100:8443
KubeDNS is running at https://192.168.99.100:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.


```



### ConfigMap

예제 파일을 이용해 ConfigMap 생성 연습

애플리케이션 클러스터에 ConfigMap 으로 동일 설정 배포 및 업데이트 확인



```shell
$ cat redis-config 
maxmemory 2mb
maxmemory-policy allkeys-lru

$ kubectl create configmap example-redis-config --from-file=./redis-config
configmap/example-redis-config created

$ kubectl get configmaps 
NAME                   DATA      AGE
example-redis-config   1         16s

$ kubectl describe cm example-redis-config
Name:         example-redis-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
redis-config:
----
maxmemory 2mb
maxmemory-policy allkeys-lru

Events:  <none>

$ kubectl get configmap example-redis-config -o yaml
apiVersion: v1
data:
  redis-config: |
    maxmemory 2mb
    maxmemory-policy allkeys-lru
kind: ConfigMap
metadata:
  creationTimestamp: 2018-08-20T07:09:31Z
  name: example-redis-config
  namespace: default
  resourceVersion: "1104"
  selfLink: /api/v1/namespaces/default/configmaps/example-redis-config
  uid: fc5cd4e0-a447-11e8-b754-080027ef3e31
  
$ cat redis-pod.yml 
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: kubernetes/redis:v1
    env:
    - name: MASTER
      value: "true"
    ports:
    - containerPort: 6379
    resources:
      limits:
        cpu: "0.1"
    volumeMounts:
    - mountPath: /redis-master-data
      name: data
    - mountPath: /redis-master
      name: config
  volumes:
    - name: data
      emptyDir: {}
    - name: config
      configMap:
        name: example-redis-config
        items:
        - key: redis-config
          path: redis.conf


$ kubectl get pod
NAME      READY     STATUS    RESTARTS   AGE
redis     1/1       Running   0          4m


$ kubectl exec -it redis redis-cli
127.0.0.1:6379> CONFIG GET maxmemory
1) "maxmemory"
2) "2097152"
127.0.0.1:6379> CONFIG GET maxmemory-policy
1) "maxmemory-policy"
2) "allkeys-lru"
127.0.0.1:6379> 

```



### Secret

- 예제 파일을 이용해 Secret 생성 연습
  - 애플리케이션 클러스터에 Secret 으로 인증 정보 배포 및 인증 과정 확인



```shell

```





## References

* https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/
* 