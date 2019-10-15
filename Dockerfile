FROM rabbitmq:3.8

ENV RABBITMQ_VERSION=3.8.0

RUN rabbitmq-plugins enable --offline rabbitmq_management
RUN rabbitmq-plugins enable --offline rabbitmq_mqtt
RUN rabbitmq-plugins enable --offline rabbitmq_web_mqtt
RUN rabbitmq-plugins enable --offline  rabbitmq_prometheus
# Fix nodename
RUN echo 'NODENAME=rabbit@localhost' > /etc/rabbitmq/rabbitmq-env.conf


EXPOSE 15672
EXPOSE 15675
EXPOSE 15692
EXPOSE 1883
EXPOSE 8883


