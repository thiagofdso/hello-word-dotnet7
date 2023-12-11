# Use the official .NET SDK 7.0 image as a base image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Set the working directory
WORKDIR /app

# Copy the necessary files to the container
COPY *.csproj ./
COPY Program.cs ./

# Restore dependencies
RUN dotnet restore

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the port
EXPOSE 8080

# Run the application
ENTRYPOINT ["dotnet", "hello-world.dll"]
