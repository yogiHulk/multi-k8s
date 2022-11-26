docker build -t yogihulk/multi-client:latest -t yogihulk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yogihulk/multi-server -t yogihulk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yogihulk/multi-worker -t yogihulk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yogihulk/multi-client:latest
docker push yogihulk/multi-worker:latest
docker push yogihulk/multi-server:latest

docker push yogihulk/multi-client:$SHA
docker push yogihulk/multi-worker:$SHA
docker push yogihulk/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yoguhulk/multi-server:$SHA
kubectl set image deployments/client-deployment client=yoguhulk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yoguhulk/multi-worker:$SHA