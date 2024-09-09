#clone_app!/bin/bash

clone_app() {
	echo "step>>>>>>>>>>>>>>>>cloning the files"
	git clone 'https://github.com/Zunaied/Devops-task-v1.git'
}

install_requirement() {
	echo "step>>>>>>>>>>>>>>>>install requirement service"
	apt install docker.io docker-compose -y
}
service_restart() {
        echo "step>>>>>>>>>>>>>>>>restarting docker service" 
	sudo chown $USER /var/run/docker.sock
	sudo systemctl restart docker
	sudo systemctl enable docker

}
build_docker() {
	echo"step>>>>>>>>>>>>>>>>build docker image"
	cd /home/rafee/scripts/Devops-task-v1
	docker build -t api .
}
deploy() {
	echo "step>>>>>>>>>>>>>>>>deploy app"
	#docker run -d -p 5500:5500 api:latest
	docker-compose up -d
}
echo "********* Deployment started **********"
if ! clone_app; then
       echo "error in clone app"     
fi
if ! install_requirement; then
	echo "error in installing docker"
fi
if ! service_restart; then
	echo "error in service restart"
	
fi
if ! build_docker; then
	echo "error in docker build"
	exit 1
fi
if ! deploy; then
	echo "error in deploy"
	exit 1
fi

clone_app
install_requirement
service_restart
build_docker
deploy

echo "*********** Deployment Done ***********"
