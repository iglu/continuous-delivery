FROM openjdk:8u151-jre

RUN groupadd app && useradd -m -d /app -g app app
USER app
WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["devel"]
COPY entrypoint.sh /

COPY boot.jar /app/boot.jar
