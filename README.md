# Adoptium Temurin OpenJDK11 - OCI Image JRE11 minimal
Custom Images for Java11 Runners

Image build with default charset _en_US.UTF-8_

WORKDIR ***/opt/app***

ENTRYPOINT _/bin/bash_

CMD _java_runner.sh_

EXPOSED 8080 8443 8778

|Environment Vars|Description|
|---|---|
|JAVA_OPTIONS| set adicional java options for execute jar file: _-Dfile.encoding=UTF-8_|
|CLASSPATH| set custom classpath on image|
|JAVA_ARGS| set arguments for execute java program: _port 8080_|
|JAR_APP| if copy multiples jar files, you must be set a jar with mainclass|

### Dockerfile for use
```
FROM demonioazteka/ubi8-jre11-minimal:latest
COPY /target /opt/app
```

### Docker run
```
docker run --env JAVA_ARGS="--port 8080" --env JAVA_OPTIONS="-Dfile.encoding=UTF-8" runner/java 
```