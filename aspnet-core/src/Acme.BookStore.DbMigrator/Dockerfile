#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["NuGet.Config", "."]
COPY ["src/Acme.BookStore.DbMigrator/Acme.BookStore.DbMigrator.csproj", "src/Acme.BookStore.DbMigrator/"]
COPY ["src/Acme.BookStore.EntityFrameworkCore/Acme.BookStore.EntityFrameworkCore.csproj", "src/Acme.BookStore.EntityFrameworkCore/"]
COPY ["src/Acme.BookStore.Domain/Acme.BookStore.Domain.csproj", "src/Acme.BookStore.Domain/"]
COPY ["src/Acme.BookStore.Domain.Shared/Acme.BookStore.Domain.Shared.csproj", "src/Acme.BookStore.Domain.Shared/"]
COPY ["src/Acme.BookStore.Application.Contracts/Acme.BookStore.Application.Contracts.csproj", "src/Acme.BookStore.Application.Contracts/"]
RUN dotnet restore "src/Acme.BookStore.DbMigrator/Acme.BookStore.DbMigrator.csproj"
COPY . .
WORKDIR "/src/src/Acme.BookStore.DbMigrator"
RUN dotnet build "Acme.BookStore.DbMigrator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Acme.BookStore.DbMigrator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Acme.BookStore.DbMigrator.dll"] 