FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish NetCoreMvcDocker.csproj -c Release -o out
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS="http://*:5001"
ENTRYPOINT ["dotnet","NetCoreMvcDocker.dll"]