#!/bin/bash

COMPOSE_FILE="docker-compose.yaml"
INSTANCE_IP=""
REMOTE_PATH="/home/ec2-user"
SSH_USER="ec2-user"
KEY="*.pem"

echo "Copiando $COMPOSE_FILE a la instancia EC2..."
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $KEY "$COMPOSE_FILE" "$SSH_USER@$INSTANCE_IP:$REMOTE_PATH"

echo "Conectando a la instancia EC2 y ejecutando docker-compose..."
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $KEY "$SSH_USER@$INSTANCE_IP" << EOF
cd "$REMOTE_PATH"
docker-compose up -d --build
docker ps
EOF

echo "¡Listo!"
