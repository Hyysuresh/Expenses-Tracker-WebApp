# stage 1 image build 
FROM maven:3.8.3-openjdk-17 AS builder


#work dirctory
WORKDIR /app

#copy the mavan poject file
COPY . .

#build mavan 
RUN mvn clean install -DskipTests=true


# stage 2 
#small size java
FROM openjdk:17-alpine


WORKDIR /app


#copy the build stage 1
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar



#port 8080
EXPOSE 8080


#Define the command to run application
CMD ["java", "-jar", "/app/target/expenseapp.jar"]

