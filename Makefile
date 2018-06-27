API_HOST = 0.0.0.0
API_PORT = 8000

LOCUST=locust
LOCUST_ENVS = LOCUST_HOSTNAME=http://$(API_HOST):$(API_PORT) DEBUG=0
LOCUST_LOG_PATH=locust.log
LOCUST_OPTS = -H 'http://$(API_HOST):$(API_PORT)' --logfile=$(LOCUST_LOG_PATH)

.PHONY: bench clean

bench:
	@cd ./scripts && \
		$(LOCUST_ENVS) $(LOCUST) $(LOCUST_OPTS)

clean:
	@docker ps -a | grep -v 'CONTAINER' | awk '{print $1}' | xargs docker rm -f
	@docker images | grep drf-apm | awk '{print $3}' | xargs docker rmi -f
	@docker volume ls -qf dangling=true | xargs docker volume rm 

