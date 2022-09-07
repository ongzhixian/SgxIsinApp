# Script to initialize database
# Start a pod
kubectl apply -f .\pod-mysql.yaml
kubectl wait pod/pp --for=condition=Ready

# Copy files 
Get-ChildItem *.sql | ForEach-Object { kubectl cp $_.Name pp:/usr/share/sql-scripts }
kubectl cp .\cp.sh pp:/usr/share/sql-scripts
kubectl exec pp -it -- sh /usr/share/sql-scripts/cp.sh

# Clean up
kubectl delete pod pp
Write-Host 'Done.'