FROM 1and1internet/ubuntu-16

RUN apt-get update -y && apt-get install varnish -y 
RUN apt-get install nano -y

COPY default.vcl /etc/varnish/default.vcl

ENV VARNISH_START /usr/sbin/varnishd -j unix,user=varnish -F -f /etc/varnish/default.vcl -a 0.0.0.0:6081 -s malloc,1g

EXPOSE 6081

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]