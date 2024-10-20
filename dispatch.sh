source common.sh
app_name=dispatch

if [ -z "$1" ]; then
  echo INput Rabbitmq Password is missing
  exit 1
fi


RABBITMQ_PASSWORD=$1



print_heading "copy dispatch service file" 
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file 
status_check $?


print_heading "Install Golang"
dnf install golang -y &>>$log_file
status_check $?

app_prerequisites

print_heading "Download Application Dependiences" 
go mod init dispatch &>>$log_file
go get &>>$log_file
go build &>>$log_file
status_check $?

print_heading "Start Application Service"
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl restart dispatch &>>$log_file
status_check $?

