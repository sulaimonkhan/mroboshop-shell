source common.sh
app_name=catalogue


nodjes_setup

print_heading "Copy MongoDB repo file"
cp $scripts_path/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
status_check $?

print_heading "Install MongoDB Client"
dnf install mongodb-mongosh -y &>>$log_file
status_check $?

print_heading "Load Master Data"
mongosh --host mongodb.sulaimondevopsb72.online </app/db/master-data.js &>>$log_file
status_check $?

print_heading "Restart Catalogue Service"
systemctl restart catalogue &>>$log_file
status_check $?


