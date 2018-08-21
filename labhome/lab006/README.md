# [실습 5] 클러스터 롤링 업데이트

[TOC]

## LAB

### Kubernetes Cluster

- 실습을 위한 쿠버네티스 클러스터 구성 정보 확인
  - Autoscaling 을 위해서는 리소스 사용량 모니터링을 위한 heapster, metrics-server 애드온이 필요합니다.

```shell
# LAB005 실습을 위한 경로로 이동
$ cd ~/labhome/lab006

# minikube heapster, metrics-server 애드온 활성화
$ minikube addons enable heapster
heapster was successfully enabled

$ minikube addons enable metrics-server
metrics-server was successfully enabled

# minikube 활성화 된 애드온 목록에서 heapster, metrics-server 확인
$ minikube addons list
- addon-manager: enabled
- coredns: disabled
- dashboard: enabled
- default-storageclass: enabled
- efk: disabled
- freshpod: disabled
- heapster: enabled
- ingress: enabled
- kube-dns: enabled
- metrics-server: enabled
- nvidia-driver-installer: disabled
- nvidia-gpu-device-plugin: disabled
- registry: disabled
- registry-creds: disabled
- storage-provisioner: enabled

# labctrl rebuild 명령으로 minikube 초기화

$ labctl rebuild
Deleting local Kubernetes cluster...
Machine deleted.
Starting local Kubernetes v1.10.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Setting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
Switched to context "minikube".
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Snapshot taken. UUID: 84790685-eb68-4783-a693-2234fe0fe45f
minikube is ready!!

# minikube 와 kubectl 연결 상태 확인
$ kubectl cluster-info 
Kubernetes master is running at https://192.168.99.100:8443
KubeDNS is running at https://192.168.99.100:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

# heapster, metrics-server 애드온 포드 구동 상태 확인
$ kubectl get pod -n kube-system
NAME                                        READY     STATUS    RESTARTS   AGE
default-http-backend-59868b7dd6-2r98r       1/1       Running   0          8m
etcd-minikube                               1/1       Running   0          7m
heapster-kvcfw                              1/1       Running   0          8m
influxdb-grafana-86smx                      2/2       Running   0          8m
kube-addon-manager-minikube                 1/1       Running   0          8m
kube-apiserver-minikube                     1/1       Running   0          8m
kube-controller-manager-minikube            1/1       Running   0          8m
kube-dns-86f4d74b45-fhmrm                   3/3       Running   0          8m
kube-proxy-d9x2d                            1/1       Running   0          8m
kube-scheduler-minikube                     1/1       Running   0          8m
kubernetes-dashboard-5498ccf677-69tsb       1/1       Running   0          8m
metrics-server-85c979995f-6qvtc             1/1       Running   0          8m
nginx-ingress-controller-5984b97644-cpdnq   1/1       Running   0          8m
storage-provisioner                         1/1       Running   0          8m


# 만약 LAB 실행 중 문제가 있을 경우 아래 두가지 명령어를 이용해 복구할 수 있습니다.
$ labctl --help
Please use corret option [restore|rebuild]

   labctl restore: Quick lab restore
   labctl rebuild: Complete lab rebuild
```



### Manual Scaling

- 오토 스케일링을 위한 애플리케이션 클러스터 배포

- 사용자가 직접 replica 개수 변경하는 매뉴얼 스케일링

```shell
# 스케일링 테스트를 위한 

$ kubectl run hpa-example --image=k8s.gcr.io/hpa-example --requests=cpu=200m --expose --port=80



```





### Auto Scaling

- CPU 사용량을 기준 오토 스케일러 (P. 5)hpa) 오브젝트 생성

- Load Generator 를 생성하여 오토 스케일링 기능 확인

- Load Generator 제거 후 스케일 다운 확인

```shell

```



## References

* https://github.com/kubernetes/community/blob/master/contributors/design-proposals/instrumentation/monitoring_architecture.md