color="\e[35m"
no_color="\e[0m"


echo -e "$color copy payment service file $no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color Install python $no_color"
dnf install python3 gcc python3-devel -y

echo -e "$color Add Application user $no_color"
useradd roboshop

echo -e "$color create application directory $no_color"
rm -rf /app
mkdir /app 

echo -e "$color Download application content $no_color"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip 
cd /app 

echo -e "$color Extract application content $no_color"
unzip /tmp/payment.zip


echo -e "$color Download application dependencies $no_color"
cd /app 
pip3 install -r requirements.txt


echo -e "$color start application service  $no_color"
systemctl daemon-reload
systemctl enable payment 
systemctl restart payment