FROM microsoft/dotnet:2.2-sdk as build

ARG BUILDCONFIG=RELEASE
ARG VERSION=1.0.0

COPY WebAppDocker2_2/*.csproj /build/WebAppDocker2_2/

RUN dotnet restore ./build/WebAppDocker2_2/WebAppDocker2_2.csproj

COPY . ./build/
WORKDIR /build/WebAppDocker2_2/
RUN dotnet publish ./WebAppDocker2_2.csproj -c $BUILDCONFIG -o out /p:Version=$VERSION

FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app

COPY --from=build /build/WebAppDocker2_2/out .

ENTRYPOINT ["dotnet", "WebAppDocker2_2.dll"] 