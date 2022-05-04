# Image building
docker build -t valtrenta/multi-client:latest -t valtrenta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t valtrenta/multi-server:latest -t valtrenta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t valtrenta/multi-worker:latest -t valtrenta/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push valtrenta/multi-client:latest
docker push valtrenta/multi-client:$SHA
docker push valtrenta/multi-server:latest
docker push valtrenta/multi-server:$SHA
docker push valtrenta/multi-worker:latest
docker push valtrenta/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=valtrenta/multi-server:$SHA
kubectl set image deployments/client-deployment client=valtrenta/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=valtrenta/multi-worker:$SHA