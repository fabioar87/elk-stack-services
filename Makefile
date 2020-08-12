DEPLOY_HOME=deployment
VOLUME_HOME=volume-claim
SERVICE_HOME=service

deploy-all: create-volume create-service
	kubectl create -f $(DEPLOY_HOME)/elasticsearch-deployment.yaml,$(DEPLOY_HOME)/kibana-deployment.yaml,$(DEPLOY_HOME)/logstash-deployment.yaml

create-volume:
	kubectl create -f $(VOLUME_HOME)/elasticsearch-claim1-persistentvolumeclaim.yaml,$(VOLUME_HOME)/logstash-claim0-persistentvolumeclaim.yaml

create-service:
	kubectl create -f $(SERVICE_HOME)/elasticsearch-service.yaml,$(SERVICE_HOME)/kibana-service.yaml

destroy-all: destroy-volume destroy-service
	kubectl delete -f $(DEPLOY_HOME)/elasticsearch-deployment.yaml,$(DEPLOY_HOME)/kibana-deployment.yaml,$(DEPLOY_HOME)/logstash-deployment.yaml

destroy-volume:
	kubectl delete -f $(VOLUME_HOME)/elasticsearch-claim1-persistentvolumeclaim.yaml,$(VOLUME_HOME)/logstash-claim0-persistentvolumeclaim.yaml

destroy-service:
	kubectl delete -f $(SERVICE_HOME)/elasticsearch-service.yaml,$(SERVICE_HOME)/kibana-service.yaml

destroy-pv:
	kubectl delete -f $(VOLUME_HOME)/local-fs-persistent-volume.yaml

create-pv:
	kubectl create -f $(VOLUME_HOME)/local-fs-persistent-volume.yaml
