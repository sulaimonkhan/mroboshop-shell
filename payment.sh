source common.sh
app_name=payment

if [ -z "$1" ]; then
  echo INput Rabbitmq is missing
  exit 1
fi  


RABBITMQ_PASSWORD=$1
python_setup