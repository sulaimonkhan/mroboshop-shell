source common.sh
app_name=shipping

if [ -z "$1" ]; then
  echo INput MySQL Root Password is missing
  exit 1
fi  

MYSQL_ROOT_PASSWORD=$1

maven_setup

print_heading "Install MYSQL Client"
dnf install mysql -y &>>$log_file
status_check $?

for sql_file in schema app-user master-data; do
  print_heading "Load SQL File - $sql_file"
  mysql -h mysql.sulaimondevopsb72 .online -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/$sql_file.sql &>>$log_file
  status_check $?
done

print_heading "Restart Shipping Service" 
systemctl restart shipping &>>$log_file
status_check $?

