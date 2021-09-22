#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["NuGet.Config", "."]
COPY ["src/Acme.BookStore.IdentityServer/Acme.BookStore.IdentityServer.csproj", "src/Acme.BookStore.IdentityServer/"]
COPY ["src/Acme.BookStore.EntityFrameworkCore/Acme.BookStore.EntityFrameworkCore.csproj", "src/Acme.BookStore.EntityFrameworkCore/"]
COPY ["src/Acme.BookStore.Domain/Acme.BookStore.Domain.csproj", "src/Acme.BookStore.Domain/"]
COPY ["src/Acme.BookStore.Domain.Shared/Acme.BookStore.Domain.Shared.csproj", "src/Acme.BookStore.Domain.Shared/"]
RUN dotnet restore "src/Acme.BookStore.IdentityServer/Acme.BookStore.IdentityServer.csproj"
COPY . .
WORKDIR "/src/src/Acme.BookStore.IdentityServer"
RUN dotnet build "Acme.BookStore.IdentityServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Acme.BookStore.IdentityServer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Acme.BookStore.IdentityServer.dll"]