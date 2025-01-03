# Step 1: Use an image with JDK 21
FROM openjdk:21-slim as builder

# Install required tools
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    bash

# Install Gradle
RUN curl -s https://get.sdkman.io | bash \
    && source ~/.sdkman/bin/sdkman-init.sh \
    && sdk install gradle 7.6

# Set the environment variables for Gradle
ENV GRADLE_USER_HOME=/opt/gradle
ENV PATH="/root/.sdkman/candidates/gradle/current/bin:$PATH"

# Set the working directory and copy the Gradle files
WORKDIR /app/backend

# Copy Gradle wrapper files (to ensure version consistency)
COPY backend/gradle-wrapper.jar backend/gradle-wrapper.properties backend/gradlew backend/gradlew.bat backend/settings.gradle.kts backend/build.gradle.kts /app/backend/

# Copy the source code (including application.properties if it's in src/main/resources)
COPY backend/src/main /app/backend/src

# Step 2: Build the Kotlin project using Gradle
RUN ./gradlew build --no-daemon

# Step 3: Create the final image to run the app
FROM openjdk:21-slim

# Copy the built jar from the build stage
COPY --from=builder /app/backend/build/libs/spring_backend-0.0.1-SNAPSHOT.jar /app/app.jar

# Set the command to run your Kotlin application
CMD ["java", "-jar", "/app/app.jar"]
