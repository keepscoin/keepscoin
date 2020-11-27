# 1. use ubuntu 16.04
FROM       ubuntu:16.04
MAINTAINER manager@keepscoin.com
RUN             apt-get -y update
RUN             apt-get -y install curl
RUN             apt-get -y install software-properties-common

# 2. keepscoin release lastest download
RUN             mkdir /root/keepscoin && cd /root/keepscoin && curl -L https://github.com/keepscoin/keepscoin/releases/download/1.3.0.1/keepscoin-1.3.0.1-arm-linux-gnu-ubuntu.16.0.4.tar.gz$
RUN             mkdir /root/.keepscoin && cd /root/keepscoin &&  mv keepscoin.conf /root/.keepscoin/ && chmod 755 keepscoin*
RUN             cd /root/keepscoin && chmod 755 keepscoin*


# 3. install dependancy
RUN             apt-get -y install build-essential
RUN             apt-get -y install libtool autotools-dev autoconf
RUN             apt-get -y install libssl-dev libboost-all-dev
RUN             add-apt-repository -y ppa:bitcoin/bitcoin
RUN             apt-get -y update
RUN             apt-get install -y libdb4.8-dev libdb4.8++-dev
RUN             apt-get install -y libssl1.0-dev
RUN             apt-get install -y libminiupnpc-dev
RUN             apt-get install -y libzmq5

# 3. run keepscoin daemon
RUN             cd /root/keepscoin && ./keepscoin -txindex -daemon