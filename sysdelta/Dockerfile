FROM ubuntu
MAINTAINER friedeggwhale
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -y update
RUN apt-get install -y nano
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
RUN apt-get install -y python3
RUN apt-get install -y python3-mysql.connector
RUN apt-get install -y php libapache2-mod-php php-mysql
RUN apt-get clean
COPY . /opt/
RUN /bin/bash -c '/opt/genStudent.sh /opt/studentDetails.txt'
RUN /bin/bash -c '/opt/setUp.sh'
RUN /bin/bash -c '/opt/permit.sh'

COPY gamma-z.hm.conf /etc/apache2/sites-available/
COPY obser.er.conf /etc/apache2/sites-available/
RUN /bin/bash -c 'a2ensite gamma-z.hm'
RUN /bin/bash -c 'a2ensite obser.er'
RUN mkdir /var/www/obser.er
RUN mkdir /var/www/obser.er/endpage
COPY index.html /var/www/obser.er/
COPY index.php /var/www/obser.er/endpage/


RUN /bin/bash -c 'a2dissite 000-default'



EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
