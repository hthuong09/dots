# Get public IP address
alias myip="curl ifconfig.co"

# Check if port is open
canyouseeme() {
    port=$1
    response=$(curl -s ifconfig.co/port/$port)
    if [[ $response == *"reachable\":true"* ]]
    then
        echo "Yes, I can see you."
    else
        echo "No, I can not see you."
    fi
}

# Start python server
servehttp () {
    port=8000
    if [[ ! -z $1 ]]; then
        port=$1
    fi
    python -m http.server $port
}
alias httpup=servehttp

# alias listen="lsof -P -i -n"
# alias port='netstat -tulanp'
