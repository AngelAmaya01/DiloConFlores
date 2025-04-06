# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia los archivos al contenedor
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Puerto que Render espera (Render asigna dinámicamente la variable $PORT)
ENV ASPNETCORE_URLS=http://+:$PORT
EXPOSE 10000

# Nombre del archivo .dll a ejecutar (ajusta si es distinto)
ENTRYPOINT ["dotnet", "FBackend.dll"]