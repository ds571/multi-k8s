docker build -t dsandoval571/multi-client:latest -t dsandoval571/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dsandoval571/multi-server:latest -t dsandoval571/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dsandoval571/multi-worker:latest -t dsandoval571/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dsandoval571/multi-client:latest
docker push dsandoval571/multi-server:latest
docker push dsandoval571/multi-worker:latest

docker push dsandoval571/multi-client:$SHA
docker push dsandoval571/multi-server:$SHA
docker push dsandoval571/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dsandoval571/multi-server:$SHA
kubectl set image deployments/client-deployment client=dsandoval571/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dsandoval571/multi-worker:$SHA