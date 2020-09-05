docker build -t nambaikin/multi-client:latest -t nambaikin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nambaikin/multi-server:latest -t nambaikin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nambaikin/multi-worker:latest -t nambaikin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nambaikin/multi-client:latest
docker push nambaikin/multi-server:latest
docker push nambaikin/multi-worker:latest

docker push nambaikin/multi-client:$SHA
docker push nambaikin/multi-server:$SHA
docker push nambaikin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nambaikin/multi-server:$SHA
kubectl set image deployments/client-deployment client=nambaikin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nambaikin/multi-worker:$SHA