# Query URL for convenience
#ELB_URL=$( aws elbv2 describe-load-balancers --query 'LoadBalancers[*].[DNSName]' --output text )
ELB_URL="demo-s-Sampl-gu6X3i9Yc2SN-1446926428.us-east-1.elb.amazonaws.com"

# Busy loop queries. CTRL-C to end loop
while true; do curl -sLo /dev/null -w 'Code %{response_code} Duration %{time_total} \n' ${ELB_URL}; done