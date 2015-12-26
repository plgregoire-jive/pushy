#!/bin/sh

# Generate new keys for the client and server
keytool -genkeypair -alias pushy-test-server -keysize 2048 -validity 36500 -keyalg RSA -dname "CN=pushy" -keypass pushy-test -storepass pushy-test -keystore pushy-test-server.jks
keytool -genkeypair -alias pushy-test-client -keysize 2048 -validity 36500 -keyalg RSA -dname "CN=pushy" -keypass pushy-test -storepass pushy-test -keystore pushy-test-client.jks

# Import the server certificate into the client trust store
keytool -export -storepass pushy-test -keystore pushy-test-server.jks -alias pushy-test-server -file pushy-test-server.crt
keytool -import -storepass pushy-test -keystore pushy-test-client.jks -alias pushy-test-server -noprompt -file pushy-test-server.crt

# Import the client certificate into the server trust store
keytool -export -storepass pushy-test -keystore pushy-test-client.jks -alias pushy-test-client -file pushy-test-client.crt
keytool -import -storepass pushy-test -keystore pushy-test-server.jks -alias pushy-test-client -noprompt -file pushy-test-client.crt

# Remove imported certificates
rm pushy-test-server.crt
rm pushy-test-client.crt

# Generate a client key not trusted by the server
keytool -genkey -alias pushy-test-client-untrusted -keysize 2048 -validity 36500 -keyalg RSA -dname "CN=pushy" -keypass pushy-test -storepass pushy-test -keystore pushy-test-client-untrusted.jks
