FROM alpine:latest
RUN apk add --no-cache curl unzip
RUN curl -L -o xray.zip https://github.com && \
    unzip xray.zip -d /usr/local/bin && \
    rm xray.zip
RUN mkdir -p /etc/xray && echo '{"log":{"loglevel":"warning"},"inbounds":[{"port":10000,"listen":"0.0.0.0","protocol":"vless","settings":{"clients":[{"id":"6f2b4c1a-829d-491a-b36e-715a3dfc6e94"}],"decryption":"none"},"streamSettings":{"network":"ws","wsSettings":{"path":"/"}}}],"outbounds":[{"protocol":"freedom"}]}' > /etc/xray/config.json
CMD ["/usr/local/bin/xray", "run", "-c", "/etc/xray/config.json"]
EXPOSE 10000
