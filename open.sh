#！/bin/bash/
echo "欢迎使用install ss5"、
read -p "是否安装y/n:" choice
if [[ "$choice" != "y"]]; then
    echo "安装取消"
    exit 1
fi

sudo apt-get update

sudo apt-get install -y ss5

sudo sed -i 's/ALL:PARANOID/ALL:ALL/g' /etc/ss5/ss5.conf
sudo sed -i 's/#auth 0.0.0.0\/0 - u\/r/auth 0.0.0.0\/0 - u\/r/g' /etc/ss5/ss5.conf
sudo sed -i 's/#permit u\/r 0.0.0.0\/0 - 0.0.0.0\/0/permit u\/r 0.0.0.0\/0 - 0.0.0.0\/0/g' /etc/ss5/ss5.conf

echo "请输入用户名(换行)密码(换行)
echo "$USERNAME $PASSWORD" | sudo tee -a /etc/ss5/ss5.passwd
sudo chmod 600 /etc/ss5/ss5.passwd

# 启动并设置服务开机自启
sudo systemctl restart ss5
sudo systemctl enable ss5

# 开放防火墙端口（假设你使用的是 ufw）
sudo ufw allow 1080/tcp

echo "SOCKS5 代理已安装并启动，监听端口 1080"
