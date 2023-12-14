echo "installing tools"
microdnf update

mkdir -p /opt/harness-delegate/repos_upgrade/node_repo
mkdir -p /opt/harness-delegate/repos_upgrade/java_repo
mkdir -p /opt/harness-delegate/repos_upgrade/maven_repo

microdnf install yum
microdnf install python38 python2

microdnf install which unzip jq git wget zip gcc make zlib-devel bzip2 bzip2-devel sqlite-devel openssl-devel patch ncurses-devel libffi libffi-devel readline xz-devel xz gcc-c++
curl -L http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/readline-devel-7.0-10.el8.x86_64.rpm -o readline-devel-7.0-10.el8.x86_64.rpm
yum localinstall readline-devel-7.0-10.el8.x86_64.rpm -y
yum install readline-devel

#microdnf install npm > /dev/null
cd /opt/harness-delegate
echo 'Install the Google Cloud CLI tool tarball'
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-291.0.0-linux-x86_64.tar.gz

echo 'Unzip tarball'
tar zxvf google-cloud-sdk-291.0.0-linux-x86_64.tar.gz && cd google-cloud-sdk

echo 'Install the CLI tool'
cat <<EOF | ./install.sh
n
y
EOF
export PATH=$PATH:/opt/harness-delegate/google-cloud-sdk/bin
echo 'export PATH=$PATH:/opt/harness-delegate/google-cloud-sdk/bin' > /root/.bash_profile
#ln -s /opt/harness-delegate/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
#ln -s /opt/harness-delegate/google-cloud-sdk/bin/gsutil /usr/bin/gsutil
cd ..
gcloud components install beta --quiet

gcloud --version
rm google-cloud-sdk-291.0.0-linux-x86_64.tar.gz

#adding java
wget https://download.java.net/openjdk/jdk8u43/ri/openjdk-8u43-linux-x64.tar.gz
tar xzvf openjdk-8u43-linux-x64.tar.gz
mv java-se-8u43-ri /opt/harness-delegate/repos_upgrade/java_repo/
update-alternatives --install /usr/bin/java java /opt/harness-delegate/repos_upgrade/java_repo/java-se-8u43-ri/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/harness-delegate/repos_upgrade/java_repo/java-se-8u43-ri/bin/javac 1
rm openjdk-8u43-linux-x64.tar.gz

wget https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_linux-x64_bin.tar.gz
tar xzvf openjdk-10.0.2_linux-x64_bin.tar.gz
mv jdk-10.0.2 /opt/harness-delegate/repos_upgrade/java_repo/
update-alternatives --install /usr/bin/java java /opt/harness-delegate/repos_upgrade/java_repo/jdk-10.0.2/bin/java 2
update-alternatives --install /usr/bin/javac javac /opt/harness-delegate/repos_upgrade/java_repo/jdk-10.0.2/bin/javac 2
rm openjdk-10.0.2_linux-x64_bin.tar.gz

wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
tar xzvf openjdk-11.0.2_linux-x64_bin.tar.gz
mv jdk-11.0.2 /opt/harness-delegate/repos_upgrade/java_repo/
update-alternatives --install /usr/bin/java java /opt/harness-delegate/repos_upgrade/java_repo/jdk-11.0.2/bin/java 3
update-alternatives --install /usr/bin/javac javac /opt/harness-delegate/repos_upgrade/java_repo/jdk-11.0.2/bin/javac 3
rm openjdk-11.0.2_linux-x64_bin.tar.gz

wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
tar xzvf openjdk-17.0.2_linux-x64_bin.tar.gz
mv jdk-17.0.2 /opt/harness-delegate/repos_upgrade/java_repo/
update-alternatives --install /usr/bin/java java /opt/harness-delegate/repos_upgrade/java_repo/jdk-17.0.2/bin/java 4
update-alternatives --install /usr/bin/javac javac /opt/harness-delegate/repos_upgrade/java_repo/jdk-17.0.2/bin/javac 4
rm openjdk-17.0.2_linux-x64_bin.tar.gz

#adding maven
wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.zip
unzip apache-maven-3.9.4-bin.zip -d /opt/harness-delegate/repos_upgrade/maven_repo
rm apache-maven-3.9.4-bin.zip

wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
unzip apache-maven-3.6.3-bin.zip -d /opt/harness-delegate/repos_upgrade/maven_repo
rm apache-maven-3.6.3-bin.zip

#install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install v10.18.0
npm install -g @angular/cli@7.3.7
nvm alias 1018 v10.18.0

nvm install v10.24.1
npm install -g @angular/cli@7.3.7
nvm alias v10 v10.24.1

nvm install v12.22.12
npm install -g @angular/cli@7.3.7
nvm alias v12 v12.22.12

nvm install v14.21.3
npm install -g @angular/cli@7.3.7
nvm alias v14 v14.21.3

nvm install v16.20.2
npm install -g @angular/cli@7.3.7
nvm alias v16 v16.20.2

nvm install v18.17.1
npm install -g @angular/cli@7.3.7
nvm alias v18 v18.17.1

nvm alias default v10.24.1
nvm use default
#gradle
wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip
unzip gradle-4.10.2-bin.zip
mv gradle-4.10.2 /opt
#echo "creating script to set gradle in path"
#cat <<EOF > /opt/gradle-path.sh
export GRADLE_HOME=/opt/gradle-4.10.2
export PATH=/opt/gradle-4.10.2/bin:${PATH}
#EOF
#chmod +x /opt/gradle-path.sh
rm gradle-4.10.2-bin.zip


#install pip
python3.8 -m ensurepip --upgrade
#virtualenv
python3.8 -m pip install virtualenv
#pyenv
curl https://pyenv.run | bash


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#envs
pyenv install 2.7.16
pyenv install 3.7.17
pyenv install 3.8.17
pyenv install 3.9.17
pyenv install 3.10.12
pyenv install 3.11.4
