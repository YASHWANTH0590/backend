FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17
WORKDIR /app
COPY --from=build /app/target/heritage-backend-0.0.1-SNAPSHOT.war app.war

# Read the port from Render and expose it
ENV PORT 8080
EXPOSE 8080

# Tell Spring Boot to run the WAR file
CMD ["java", "-jar", "app.war"]
