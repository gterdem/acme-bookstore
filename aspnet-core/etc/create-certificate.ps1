New-Item -ItemType Directory -Force dev-cert
cd dev-cert
Remove-Item * -Include *.pfx
dotnet dev-certs https -v -ep bookstore-devcert.pfx -p 64fd4a14-311a-47bb-80b1-ac9665b0e0c7
cd..