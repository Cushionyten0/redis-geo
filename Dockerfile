FROM microsoft/aspnetcore-build:2.0 AS build-env
COPY src /app
WORKDIR /app

COPY NuGet.Config /root/.nuget/NuGet/
RUN dotnet restore --configfile ../NuGet.Config
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/RedisGeo/out .
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT ["dotnet", "RedisGeo.dll", "http://*:5000"]

#new line