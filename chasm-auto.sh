echo -e "\033[0;35m"
echo "====================================================="
echo "                  AIRDROP ASC                        "
echo "====================================================="
echo -e '\e[35mNode :\e[35m' CHASM
echo -e '\e[35mTelegram Channel :\e[35m' @airdropasc
echo -e '\e[35mTelegram Group :\e[35m' @autosultan_group
echo "====================================================="
echo -e "\e[0m"

sleep 2

sudo apt-get update && sudo apt-get upgrade -y

sleep 2

echo -e "\033[0;35m"
echo "Submit Detail Your Chasm Scout"
echo "================================="
read -p "SCOUTNAME: " SCOUTNAME
read -p "SCOUTUID: " SCOUTUID
read -p "WEBHOOKAPI: " WEBHOOKAPI
read -p "GROQAPI: " GROQAPI
echo "================================="
echo -e "\e[0m"

sleep 2

sudo apt-get update

sudo apt-get install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

sleep 2

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sleep 2

mkdir -p ~/chasm
cd ~/chasm

cat > .env <<EOF
PORT=3001
LOGGER_LEVEL=debug
ORCHESTRATOR_URL=https://orchestrator.chasm.net
SCOUT_NAME=$SCOUTNAME
SCOUT_UID=$SCOUTUID
WEBHOOK_API_KEY=$WEBHOOKAPI
WEBHOOK_URL=http://$(hostname -I | awk '{print $1}'):3001/
PROVIDERS=groq
MODEL=gemma2-9b-it
GROQ_API_KEY=$GROQAPI
OPENROUTER_API_KEY=
OPENAI_API_KEY=
EOF

docker pull chasmtech/chasm-scout:latest
docker run -d --restart=always --env-file ./.env -p 3001:3001 --name scout chasmtech/chasm-scout

echo -e "\033[0;35m"
echo '=============== DONE ==================='
echo -e "\e[0m"
