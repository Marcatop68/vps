FROM ubuntu:22.04

# Install dependencies
RUN apt update && \
    apt install -y software-properties-common wget curl git openssh-client python3 && \
    # Install sshx
    curl -sSf https://sshx.io/get | sh && \
    mv sshx /usr/local/bin/ && \
    apt clean

# Create a dummy index page to keep the service alive
RUN mkdir -p /app && echo "SSHx Session Running..." > /app/index.html
WORKDIR /app

# Expose a fake web port to trick Railway into keeping container alive
EXPOSE 6080

# Start a dummy Python web server to keep Railway service active
# and start sshx session
# Note: sshx by default will print a connection URL to stdout.
# You'll need to check your container logs to get this URL.
CMD python3 -m http.server 6080 & \
    sshx
    
