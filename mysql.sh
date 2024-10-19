source common.sh
app_name=mysql

print_heading "Install MYQL Server"
dnf install mysql-server -y &>>$log_file
status_check $?

print_heading "Start MYSQL Service"
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file
status_check $?

print_heading "Setup MYSQL Password"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
status_check $?