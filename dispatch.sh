source common.sh

echo -e "$color copy dispatch service file $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "$color Install Golang $no_color"
dnf install golang -y

echo -e "$color Add Application user $no_color"
useradd roboshop

echo -e "$color Create Application Directory $no_color"
rm -rf /app
mkdir /app 

echo -e "$color Download Application Content $no_color"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip 
cd /app 

echo -e "$color Extract Application Content $no_color"
unzip /tmp/dispatch.zip

echo -e "$color Download Application Dependiences $no_color"
cd /app 
go mod init dispatch
go get 
go build

echo -e "$color Start Application Service $no_color"
systemctl daemon-reload
systemctl enable dispatch 
systemctl restart dispatch