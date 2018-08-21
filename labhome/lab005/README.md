# [실습 5] 클러스터 롤링 업데이트

[TOC]

## LAB

### Kubernetes Cluster

- 실습을 위한 쿠버네티스 클러스터 구성 정보 확인

```shell
# LAB005 실습을 위한 경로로 이동
$ cd ~/labhome/lab005

$ kubectl cluster-info 
Kubernetes master is running at https://192.168.99.100:8443
KubeDNS is running at https://192.168.99.100:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

# 만약 LAB 실행 중 문제가 있을 경우 아래 두가지 명령어를 이용해 복구할 수 있습니다.
$ labctl --help
Please use corret option [restore|rebuild]

   labctl restore: Quick lab restore
   labctl rebuild: Complete lab rebuild
```



### Deployment

Deployment 명세서 예제 내용 확인 및 배포 연습
Deployment 를 통해 Pod, ReplicaSet 이 한번에 같이 배포됨을 확인





### Rolling-Update

배포된 Deployment 의 컨테이너 이미지를 교체
새로운 이미지를 포함한 Pod 를 롤링 업데이트