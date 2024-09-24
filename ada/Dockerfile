FROM sspreitzer/shellinabox:latest

RUN apt-get update && apt-get install -y openssh-server sudo nano man
COPY ada/bash.bashrc /etc/profile
COPY ada/f.ascii /usr/f.ascii
RUN mkdir /var/run/sshd

#
# Create the user the hacker used to login.
#
RUN useradd -d /home/elliot -m elliot
RUN echo 'elliot:fsociety1986' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
EXPOSE 4200

#
# Add the user to the SUDOers group
#
RUN usermod -aG sudo elliot
RUN chsh -s /bin/bash elliot

#
# Create a greetings file.
#
COPY ada/etc-profile /etc/profile1
RUN cat /etc/profile1 >> /etc/profile && rm /etc/profile1

#
# Infect the computer.
#
COPY ada/infected.bashrc /root/.bashrc
COPY ada/infected.bashrc /home/elliot/.bashrc
COPY ada/infected.file /etc/init.d/fsociety

#
# Encrypt success message
#
COPY ada/success.txt /usr/success.txt
RUN cat /usr/success.txt | openssl enc -aes-256-cbc -a -salt -pass pass:toto1986 -pbkdf2 -iter 100000 > /usr/.success.txt
RUN echo "openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 100000 -salt -pass pass:toto1986 -in /usr/.success.txt" > /usr/bin/secret
RUN chmod +x /usr/bin/secret && rm /usr/success.txt

#
# Make sure we can check that the file exists.
#
RUN chmod +r /root && chmod g-r /root/.bashrc && chmod a-r /root/.bashrc