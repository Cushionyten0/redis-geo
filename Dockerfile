FROM microsoft/aspnetcore-build:2.0 AS build-env
FROM microsoft/dotnet:latest
COPY src /app
WORKDIR /app

#RUN dotnet restore --configfile ../NuGet.Config
RUN ["cp", "NuGet.Config", "/root/.nuget/NuGet/NuGet.Config"]
RUN ["dotnet", "restore"]
#RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app/RedisGeo
RUN ["dotnet", "build"]
#WORKDIR /app
#COPY --from=build-env /app/RedisGeo/out .
EXPOSE 5000/tcp
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT ["dotnet", "run", "--server.urls", "http://*:5000"]

#new line