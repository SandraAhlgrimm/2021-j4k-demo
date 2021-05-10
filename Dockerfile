FROM adoptopenjdk/openjdk11:jdk11u-alpine-nightly as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests | egrep -v "(^\[INFO\])"
COPY /target/ /target/

FROM adoptopenjdk:11-jre-hotspot
VOLUME /tmp
COPY --from=build /target/ /target/
ENTRYPOINT ["java -noverify -XX:+AlwaysPreTouch com.microsoft.devrel.j4kdemo.J4KdemoApp"]
