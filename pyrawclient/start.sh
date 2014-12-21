#!/bin/sh

# Create RAW configuration file
echo "[files]\nbase_path=/data\n\n[sql]\nresource_path=/resources\nconnection_string = host=$RAWSERVER_PORT_5432_TCP_ADDR port=$RAWSERVER_PORT_5432_TCP_PORT user=raw password=raw dbname=raw" > /etc/raw.config

# Launch notebook
/notebook.sh