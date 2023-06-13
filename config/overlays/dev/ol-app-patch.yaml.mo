apiVersion: apps.openliberty.io/v1beta2
kind: OpenLibertyApplication
metadata:
  name: openliberty-starter-app
spec:
  applicationVersion: 1.0.0
  applicationImage: '{{IMAGE_NAME}}'
  replicas: {{REPLICA_COUNT}}
  service:
    port: 9443
    type: ClusterIP
    annotations:
      prometheus.io/scrape: 'false'
  resources: {}
  pullPolicy: Always
  probes:
    readiness: 
      failureThreshold: 12
      httpGet:
        path: /health/ready
        port: 9080
      initialDelaySeconds: 5
      periodSeconds: 3
      timeoutSeconds: 1
    liveness:
      failureThreshold: 12
      httpGet:
        path: /health/live
        port: 9080
      initialDelaySeconds: 5
      periodSeconds: 3
  expose: true
  route:
    # Ingress required entries.
    pathType: 'Prefix'
    path: '/'
