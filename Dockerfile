FROM alpine:latest
RUN apk add --no-cache aria2
EXPOSE 6800
ENTRYPOINT ["aria2c"]
CMD ["--conf-path=/config/aria2.conf"]
