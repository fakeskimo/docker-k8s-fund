# [실습 7] 쿠버네티스 종합 실습

[TOC]

## LAB

### Kubernetes Cluster

- 실습을 위한 쿠버네티스 클러스터 구성 정보 확인

```shell
# LAB007 실습을 위한 경로로 이동
$ cd ~/labhome/lab007

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





지금까지 배운 도커와 쿠버네티스 클러스터의 개념 및 기능을 확인하는 종합 실습
예제로 제공되는 YAML 명세서 및 애플리케이션 구성도 문서를 참고하여 , 쿠버네티스 클러스터에 애플리케이션을 배포한다 .
배포 중 발생하는 이슈에 대해서 원인을 찾아 수정하여 , 최종 애플리케이션 구동을 확인한다 .