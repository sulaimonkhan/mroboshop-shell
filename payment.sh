source common.sh
app_name

echo -e "$color copy payment service file $no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color Install python $no_color"
dnf install python3 gcc python3-devel -y

app_prerequisites


echo -e "$color Download application dependencies $no_color"
cd /app 
pip3 install -r requirements.txt


echo -e "$color start application service  $no_color"
systemctl daemon-reload
systemctl enable payment 
systemctl restart payment