docker build -f ./Dockerfile . -t docker-registry.cicd-instances.svc.cluster.local:5000/jenkins-custom:v0.0.1
docker push docker-registry.cicd-instances.svc.cluster.local:5000/jenkins-custom:v0.0.1
