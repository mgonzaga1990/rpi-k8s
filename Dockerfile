FROM alpine

MAINTAINER MarkJaysonGonzaga (markjayson.gonzaga1990@gmail.com)


RUN apk add --update --no-cache curl && \
   curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl && \
   mv kubectl /usr/bin/kubectl && \
   chmod +x /usr/bin/kubectl

RUN kubectl version --client
RUN apk add bash

COPY init-k8s.sh kubectl.sh /opt/mjayson/kubectl/bin/
RUN chmod +x /opt/mjayson/kubectl/bin/*

USER root

#ENTRYPOINT ["./opt/mjayson/kubectl/bin/kubectl.sh"]

