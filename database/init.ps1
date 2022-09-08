# Script to initialize database
# Start a pod
kubectl apply -f .\pod-mysql.yaml
kubectl wait pod/pp --for=condition=Ready

# Copy files 
# Get-ChildItem *.sql | ForEach-Object { kubectl cp $_.Name pp:/usr/share/generic-128mi/sql }
kubectl cp .\sql pp:/usr/share/generic-128mi
kubectl cp .\execute-sql-scripts.sh pp:/usr/share/generic-128mi/sql/execute-sql-scripts.sh
kubectl exec pp -it -- sh /usr/share/generic-128mi/sql/execute-sql-scripts.sh

# Clean up
kubectl delete pod pp
Write-Host 'Done.'