FROM rabbitmq:3.7

ENV PROMETHEUS_RABBITMQ_EXPORTER_VERSION="v3.7.2.2" RABBITMQ_VERSION=3.7.7

# prometheus exporter plugin
RUN apt-get update && apt-get install --yes wget && \
    cd /tmp && \
    wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/${PROMETHEUS_RABBITMQ_EXPORTER_VERSION}/accept-0.3.3.ez && \
    wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/${PROMETHEUS_RABBITMQ_EXPORTER_VERSION}/prometheus-3.5.1.ez && \
    wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/${PROMETHEUS_RABBITMQ_EXPORTER_VERSION}/prometheus_cowboy-0.1.4.ez && \
    wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/${PROMETHEUS_RABBITMQ_EXPORTER_VERSION}/prometheus_httpd-2.1.8.ez && \
    wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/${PROMETHEUS_RABBITMQ_EXPORTER_VERSION}/prometheus_process_collector-1.3.1.ez && \
    wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/${PROMETHEUS_RABBITMQ_EXPORTER_VERSION}/prometheus_rabbitmq_exporter-v3.7.2.2.ez && \
    apt-get purge --yes wget && \
    mv *.ez /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/plugins/

RUN rabbitmq-plugins enable --offline rabbitmq_management
RUN rabbitmq-plugins enable --offline rabbitmq_mqtt
RUN rabbitmq-plugins enable --offline prometheus accept prometheus_rabbitmq_exporter prometheus_process_collector prometheus_httpd prometheus_cowboy

# Fix nodename
RUN echo 'NODENAME=rabbit@localhost' > /etc/rabbitmq/rabbitmq-env.conf


EXPOSE 15672
EXPOSE 1883
EXPOSE 8883


