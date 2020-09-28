FROM debian:stable

COPY dns-loop curl-loop awk-dns-loop /usr/bin/

RUN apt-get update && apt-get install -y openssh-client dnsutils curl nmap python3-pip

RUN pip3 install bashplotlib

CMD ["/bin/bash"]