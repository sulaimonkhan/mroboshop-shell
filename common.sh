color="\e[35m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
rm -f $log_file

app_prerequisites() {
  print_heading "$color Add Application user" 
  useradd roboshop &>>$log_file
  echo $?

  print_heading "$color Create Application Directory"
  rm -rf /app &>>$log_file
  mkdir /app  &>>$log_file
  echo $?


  print_heading "$color Download Application Content"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  echo $?

  cd /app

  print_heading "$color Extract Application Content"
  unzip /tmp/$app_name.zip &>>$log_file
  echo $?
}

print_heading () {
  echo -e "$color $1 $no_color" &>>$log_file
  echo -e "$color $1 $no_color" 
}