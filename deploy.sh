docker build -t yogihulk/multi-client:latest -t yogihulk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yogihulk/multi-server -t yogihulk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yogihulk/multi-worker -t yogihulk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yogihulk/multi-client
docker push yogihulk/multi-worker
docker push yogihulk/multi-server
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yoguhulk/multi-server:$SHA