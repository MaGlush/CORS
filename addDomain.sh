#!/bin/bash
echo
echo "*******************************************"
echo \* Скрипт по добавлению виртуального хоста \*
echo "*******************************************"
echo

read -n 1 -p "Apache установлен? [y/n]: " AMSURE 
if [ "$AMSURE" = "n" ] 
then
echo Установка Apache
sudo apt-get update
sudo apt-get install apache2
fi
echo
echo Пример: domain.com
read -p "Введите host: " HOST
echo HOST_NAME: $HOST

echo Создание структуры директорий
sudo mkdir -p /var/www/$HOST/public_html
echo Назначение прав
sudo chown -R $USER:$USER /var/www/$HOST/public_html
sudo chmod -R 755 /var/www
echo Создание index.html
echo "<html>
    <head>
        <title>Welcome to $HOST!</title>
    </head>
    <body>
        <h1>Success! $HOST virtual host is working!</h1>
    </body>
</html>" > /var/www/$HOST/public_html/index.html
echo Создание файла конфигурации хоста
echo "<VirtualHost *:80>
        ServerAdmin admin@$HOST
        ServerName $HOST
        ServerAlias www.$HOST
        DocumentRoot /var/www/$HOST/public_html
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"  > $HOST.conf
sudo mv $HOST.conf /etc/apache2/sites-available/$HOST.conf
echo Включение виртуального хоста
sudo service apache2 restart
sudo a2ensite $HOST.conf
echo Перезагрузка apache
sudo systemctl restart apache2
echo Настройка hosts
ifconfig
echo Добавьте строку your_ip $HOST и сохраните
echo
read -p "Нажми ENTER, чтобы продолжить" CHECK
sudo nano /etc/hosts
echo
read -p "Нажми ENTER, для проверки" CHECK
xdg-open http://www.$HOST