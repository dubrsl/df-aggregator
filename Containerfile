FROM quay.io/centos/centos:stream9

ARG CENTOS_FRONTEND=noninteractive
RUN dnf -y update --refresh
RUN dnf -y --setopt=install_weak_deps=False --best install npm python3-pip python3-setuptools

# exist system packages
    # python3-bottle \
    # python3-numpy \
    # python3-lxml \
    # python3-w3lib \
    # python3-attrs \
    # python3-dateutil \
    # python3-scipy \
    # python3-six \
    # python3-gevent \
    # python3-zope-interface \
    # python3-zope-event \
    # python3-greenlet \

RUN mkdir -p /root/df-aggregator && \
    mkdir -p /var/lib/df-aggregator

COPY . /root/df-aggregator/
WORKDIR /root/df-aggregator/static
RUN npm install cesium
WORKDIR /root/df-aggregator
RUN pip3 install -r requirements.txt

CMD ./df-aggregator.py --debug --database=/var/lib/df-aggregator/databasename.db --ip=0.0.0.0
VOLUME /var/lib/df-aggregator
