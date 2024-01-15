FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App
EXPOSE 80
EXPOSE 443

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out
RUN dotnet test

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "Esteiras.dll"]