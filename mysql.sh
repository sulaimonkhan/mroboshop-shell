source common.sh
app_name=mysql

if [ -z "$1"]; then
  echo INput MySQL Root Password is missing
  exit 1
fi
MYSQL_ROOT_PASSWORD=$1



print_heading "Install MYQL Server"
dnf install mysql-server -y &>>$log_file
status_check $?

print_heading "Start MYSQL Service"
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file
status_check $?

print_heading "Setup MYSQL Password"
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$log_file
status_check $?