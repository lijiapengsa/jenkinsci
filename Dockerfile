FROM   haha123/jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
<<<<<<< HEAD
RUN /usr/local/bin/install-plugins.sh /usr/share/jenkins/plugins.txt
=======
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
>>>>>>> 7ad43f487fbddb7db12f912367ad2babf14dbfef
