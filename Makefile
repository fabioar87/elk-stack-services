DEPLOY_HOME=deployment
VOLUME_HOME=volume-claim
SERVICE_HOME=service
CLUSTER_CONF_HOME=cluster
LOGSTASH_POD=logstash_pod
LOGSTASH_DATA=logstash_custom/data

create-cluster:
	kind create cluster --config $(CLUSTER_CONF_HOME)/elk-cluster-config.yaml --name elk

deploy-volume-conf:
	kubectl create -f $(VOLUME_HOME)/local-storage-class.yaml
	kubectl create -f $(VOLUME_HOME)/local-fs-persistent-volume.yaml

deploy-all:
	kubectl create -f $(DEPLOY_HOME)/elasticsearch-deployment.yaml,$(DEPLOY_HOME)/kibana-deployment.yaml,$(DEPLOY_HOME)/logstash-deployment.yaml
	kubectl create -f $(VOLUME_HOME)/elasticsearch-claim1-persistentvolumeclaim.yaml,$(VOLUME_HOME)/logstash-claim0-persistentvolumeclaim.yaml
	kubectl create -f $(SERVICE_HOME)/elasticsearch-service.yaml,$(SERVICE_HOME)/kibana-service.yaml

push-csv:
	kubectl cp $(LOGSTASH_DATA)/access_log.csv default/$(LOGSTASH_POD):/data/

create-volume:
	kubectl create -f $(VOLUME_HOME)/elasticsearch-claim1-persistentvolumeclaim.yaml,$(VOLUME_HOME)/logstash-claim0-persistentvolumeclaim.yaml

create-service:
	kubectl create -f $(SERVICE_HOME)/elasticsearch-service.yaml,$(SERVICE_HOME)/kibana-service.yaml

destroy-all:
	kubectl delete -f $(DEPLOY_HOME)/elasticsearch-deployment.yaml,$(DEPLOY_HOME)/kibana-deployment.yaml,$(DEPLOY_HOME)/logstash-deployment.yaml
	kubectl create -f $(VOLUME_HOME)/elasticsearch-claim1-persistentvolumeclaim.yaml,$(VOLUME_HOME)/logstash-claim0-persistentvolumeclaim.yaml
	kubectl create -f $(SERVICE_HOME)/elasticsearch-service.yaml,$(SERVICE_HOME)/kibana-service.yaml

destroy-volume:
	kubectl delete -f $(VOLUME_HOME)/elasticsearch-claim1-persistentvolumeclaim.yaml,$(VOLUME_HOME)/logstash-claim0-persistentvolumeclaim.yaml

destroy-service:
	kubectl delete -f $(SERVICE_HOME)/elasticsearch-service.yaml,$(SERVICE_HOME)/kibana-service.yaml

destroy-pv:
	kubectl delete -f $(VOLUME_HOME)/local-fs-persistent-volume.yaml

create-pv:
	kubectl create -f $(VOLUME_HOME)/local-fs-persistent-volume.yaml
