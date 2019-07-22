FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY ["ncrdemo2.csproj", "."]
RUN dotnet restore "ncrdemo2.csproj"
COPY . .
RUN dotnet build "ncrdemo2.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ncrdemo2.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ncrdemo2.dll"]