FROM adoptopenjdk/openjdk11:jdk11u-alpine-nightly as build
WORKDIR /workspace/app

COPY . .
RUN ./mvnw package -Pprod | egrep -v "(^\[INFO\])"

FROM openjdk:11-jre
WORKDIR /workspace/app
COPY --from=build /workspace/app/target/j4kdemo-0.0.1-SNAPSHOT.jar .
ENTRYPOINT ["java", "-jar", "-XX:+AlwaysPreTouch", "j4kdemo-0.0.1-SNAPSHOT.jar"]
