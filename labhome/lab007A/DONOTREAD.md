# [실습 7] 쿠버네티스 종합 실습 (해답)







```shell
$ cd ~/labhome/lab007/guestbook/
$ eval $(minikube docker-env)
$ vim app/app.py 

# Redis 호스트 확인 및 변경
$ grep redis-svc app/app.py 
app.redis = redis.StrictRedis(host='redis-svc', port=6379, db=0)

# guestbook listening 포트 확인 (80 아님)
$ grep 8080 app/app.py 
  app.run(host='0.0.0.0', port=8080)

# guestbook:v3 빌드
$ docker build -t guestbook:v3 .
{{ 생략 }}
Successfully built dbd8dd3df562
Successfully tagged guestbook:v3

$ docker images | grep guestbook
guestbook                                                        v3                  dbd8dd3df562        53 seconds ago      71.6MB

$ cat redis-pvc.yml 
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: redis-pvc
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: FileSystem
  resources:
    requests:
      storage: 5Gi
$ kubectl create -f redis-pvc.yml 
persistentvolumeclaim/redis-pvc created
$ kubectl get pvc
NAME        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
redis-pvc   Bound     pvc-385a9f3b-a51a-11e8-99cf-080027098349   5Gi        RWO            standard       4s
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM               STORAGECLASS   REASON    AGE
pvc-385a9f3b-a51a-11e8-99cf-080027098349   5Gi        RWO            Delete           Bound     default/redis-pvc   standard                 6s

$ cat redis-pod-service.yml 
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
  labels:
    app: redis
    tier: backend
spec:
  containers:
  - name: redis
    image: redis:alpine
    volumeMounts:
    - mountPath: /data
      name: redis-data
  volumes:
  - name: redis-data
    persistentVolumeClaim:
      claimName: redis-pvc

---

apiVersion: v1
kind: Service
metadata:
  name: redis-svc
  labels:
    app: redis
    tier: backend
spec:
  selector:
    app: redis
    tier: backend
  ports:
  - port: 6379
    targetPort: 6379

$ kubectl create -f redis-pod-service.yml 
pod/redis-pod created
service/redis-svc created

$ cat guestbook-deploy.yml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: guestbook-deploy
  labels:
    app: guestbook
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: guestbook
      tier: frontend
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
    spec:
      containers:
      - name: guestbook
        image: guestbook:v3
        ports:
          - containerPort: 8080

$ kubectl create -f guestbook-deploy.yml 
deployment.apps/guestbook-deploy created

$ cat guestbook-svc.yml 
apiVersion: v1
kind: Service
metadata:
  name: guestbook-svc
  labels:
    app: guestbook
    tier: frontend
spec:
  type: NodePort
  selector:
    app: guestbook
    tier: frontend
  ports:
  - port: 8080 
    targetPort: 8080

$ kubectl create -f guestbook-svc.yml 
service/guestbook-svc created

$ minikube service list
|-------------|----------------------|-----------------------------|
|  NAMESPACE  |         NAME         |             URL             |
|-------------|----------------------|-----------------------------|
| default     | guestbook-svc        | http://192.168.99.100:31979 |
| default     | kubernetes           | No node port                |
| default     | redis-svc            | No node port                |
| kube-system | default-http-backend | http://192.168.99.100:30001 |
| kube-system | heapster             | No node port                |
| kube-system | kube-dns             | No node port                |
| kube-system | kubernetes-dashboard | http://192.168.99.100:30000 |
| kube-system | metrics-server       | No node port                |
| kube-system | monitoring-grafana   | http://192.168.99.100:30002 |
| kube-system | monitoring-influxdb  | No node port                |
|-------------|----------------------|-----------------------------|

# 웹브라우저에서 서비스 확인
$ minikube service guestbook-svc
Opening kubernetes service default/guestbook-svc in default browser...

$ kubectl autoscale deploy guestbook-deploy --cpu-percent=50 --min=3 --max=12
horizontalpodautoscaler.autoscaling/guestbook-deploy autoscaled

$ kubectl get hpa
NAME               REFERENCE                     TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
guestbook-deploy   Deployment/guestbook-deploy   <unknown>/50%   3         12        3          3m


```

