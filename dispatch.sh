source common.sh
app_name=dispatch

echo -e "$color copy dispatch service file $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service
echo $?

echo -e "$color Install Golang $no_color"
dnf install golang -y
echo $?

app_prerequisites

echo -e "$color Download Application Dependiences $no_color"
cd /app 
go mod init dispatch
go get 
go build
echo $?

echo -e "$color Start Application Service $no_color"
systemctl daemon-reload
systemctl enable dispatch 
systemctl restart dispatch
echo $?