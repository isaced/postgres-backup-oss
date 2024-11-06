FROM alpine:3.20

# Install postgres-client
RUN apk add --no-cache postgresql-client

# Install ossutil
RUN wget https://gosspublic.alicdn.com/ossutil/v2-beta/2.0.4-beta.10251600/ossutil-2.0.4-beta.10251600-linux-amd64.zip -O /tmp/ossutil.zip && \
    unzip /tmp/ossutil.zip -d /tmp && \
    mv /tmp/ossutil-2.0.4-beta.10251600-linux-amd64/ossutil /usr/bin/ossutil && \
    rm -rf /tmp/ossutil.zip /tmp/ossutil-2.0.4-beta.10251600-linux-amd64

# Copy backup script
COPY src/backup.sh /backup.sh
COPY src/start.sh /start.sh

RUN chmod +x /backup.sh

# Start cron and keep container running
ENTRYPOINT ["sh", "start.sh"]