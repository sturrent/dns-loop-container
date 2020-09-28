# dns-loop

This is a set of scripts and tools use to generate a docker image to simply run a DNS query in a loop using curl and then plot a graph showing the resolution time.
The github actions can be used to trigger a new build and push the updated image. The actions will get triggered any time a new release gets published.

The dns-loop script will run the curl-loop script that generates output of each DNS resolution time iteration and will pass that output to hist from the https://github.com/glamp/bashplotlib tool.

### Using in Kuberntes
Sample usage in kubernetes

Deploy pod:
```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: dns-loop
spec:
  containers:
  - name: dns-loop
    image: sturrent/dns-loop
    command: ["/bin/sh"]
    args: ["-c", "while true; do sleep 1000; done"]
EOF
```

#### Run the script with the default vaules:
```
kubectl exec -it dns-loop -- dns-loop
```
Note: default values in dns-loop are
* Iterations = 100
* URL = google.com
* Sleep time in between queries = 0.250 s

#### Execution example with default values:

![sample_view](https://user-images.githubusercontent.com/16940760/94466451-ae7f0880-017e-11eb-952b-a07a1e97570d.png)

#### Running with custom values:
This is a sample run using 200 iterations, URL azure.microsoft.com and running the queries every 100 ms

```
kubectl exec -it dns-loop -- dns-loop 200 azure.microsoft.com 0.100
```

![sample_view](https://user-images.githubusercontent.com/16940760/94466883-5a285880-017f-11eb-9e0c-ccd00b9ec7db.png)



