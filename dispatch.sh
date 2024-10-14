echo -e "\e[35m copy dispatch service file \e[0m"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[35m Install Golang \e[0m"
dnf install golang -y

echo -e "\e[35m Add Application user \e[0m"
useradd roboshop

echo -e "\e[35m Create Application Directory \e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[35m Download Application Content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip 
cd /app 

echo -e "\e[35m Extract Application Content \e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[35m Download Application Dependiences \e[0m"
cd /app 
go mod init dispatch
go get 
go build

echo -e "\e[35m Start Application Service \e[0m"
systemctl daemon-reload
systemctl enable dispatch 
systemctl restart dispatch