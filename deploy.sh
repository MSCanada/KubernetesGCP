docker build -t msuhail/multi-client:latest -t msuhail/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t msuhail/multi-server:latest -t msuhail/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t msuhail/multi-worker:latest -t msuhail/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push msuhail/multi-client:latest
docker push msuhail/multi-server:latest
docker push msuhail/multi-worker:latest

docker push msuhail/multi-client:$SHA
docker push msuhail/multi-server:$SHA
docker push msuhail/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=msuhail/multi-server:$SHA
kubectl set image deployments/client-deployment client=msuhail/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=msuhail/multi-worker:$SHA
