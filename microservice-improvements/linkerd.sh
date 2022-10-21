kubectl get -n store deploy -o yaml  | microk8s linkerd inject - | kubectl apply -f -
