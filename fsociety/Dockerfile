FROM sspreitzer/shellinabox:latest

RUN apt-get update && apt-get install -y openssh-server sudo nano man
COPY fsociety/bash.bashrc /etc/profile
COPY fsociety/f.ascii /usr/f.ascii
RUN mkdir /var/run/sshd

#
# Create the user the hacker used to login.
#
RUN useradd -d /home/elliot -m elliot
RUN echo 'elliot:fsociety1986' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 4200

#
# Add the user to the SUDOers group
#
RUN usermod -aG sudo elliot
RUN chsh -s /bin/bash elliot

#
# Create a greetings file.
#
COPY fsociety/etc-profile /etc/profile1
RUN cat /etc/profile1 >> /etc/profile && rm /etc/profile1

#
# Infect the computer.
#
COPY fsociety/infected.bashrc /root/.bashrc
COPY fsociety/infected.bashrc /home/elliot/.bashrc
COPY fsociety/infected.file /etc/init.d/fsociety

#
# Encrypt success message
#
COPY fsociety/scripts/success.txt /usr/success.txt
RUN cat /usr/success.txt | openssl enc -aes-256-cbc -a -salt -pass pass:XER0 -pbkdf2 -iter 100000 > /usr/.success.txt
# Copy the success decryption binary
COPY fsociety/scripts/build/md5 /usr/bin/md5
RUN chmod +x /usr/bin/md5 && rm /usr/success.txt
# Copy the progress binary
COPY fsociety/scripts/build/gprogress /usr/bin/gprogress

#
# Make sure we can check that the file exists.
#
RUN chmod +r /root && chmod g-r /root/.bashrc && chmod a-r /root/.bashrc