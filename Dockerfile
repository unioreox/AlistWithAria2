FROM debian:latest

RUN mkdir /opt/aria2
WORKDIR /opt/aria2
RUN apt update -y && apt install -y cron procps iptables wget curl ca-certificates
RUN wget -N git.io/aria2.sh && chmod +x aria2.sh
RUN echo 1|bash aria2.sh
WORKDIR /opt/alist
RUN wget https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz && tar -zxvf alist-linux-amd64.tar.gz && rm -rf alist-linux-amd64.tar.gz
RUN chmod +x alist

CMD ((echo 12 && echo y)|bash /opt/aria2/aria2.sh) \
    && /etc/init.d/aria2 start && /opt/alist/alist server

EXPOSE 5244
EXPOSE 6800
EXPOSE 6888
