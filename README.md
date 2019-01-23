# Kafka Server 

This repository will contain all components needed to start and run the core kafak service. 

# Image Information
## Ports
 - 9092: exposed by default to allow connections to the kafka broker

## Environment Variables
 - KAFKA_ADVERTISED_HOST_NAME - Sets the advertised host name in the server.properties
 - KAFKA_ADVERTISED_PORT - Sets the advertised port in the server.properties, this is needed to run multiple brokers on the same docker host.
 - KAFKA_PORT - Sets the actual port kafka uses to communicate
 - KAFKA_BROKER_ID - Unique broker ID for the container, starting at 0. [0, 1, 2, 3, ...]
 - ZOOKEEPER_IP - IP address of the zookeeper sever. If running on the same non-default network as the zookeeper server's container the name of the container can be used.
 - ZOOKEEPER_PORT - Port of the zookeeper server, only necessary if zookeeper is not on port 2181.