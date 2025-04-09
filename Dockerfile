# Use Maven to build the app
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use JDK to run the app
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy WAR from build stage
COPY --from=build /app/target/heritage-backend-0.0.1-SNAPSHOT.war app.war

# Run the WAR
ENTRYPOINT ["java", "-jar", "app.war"]
