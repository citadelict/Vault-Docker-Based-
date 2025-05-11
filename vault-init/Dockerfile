FROM hashicorp/vault:1.18

# Install curl using apk
RUN apk update && apk add --no-cache curl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
