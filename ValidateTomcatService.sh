#!/bin/bash

# Define the path to the Tomcat bin directory
TOMCAT_BIN_PATH="/opt/apache-tomcat-9.0.89/bin"

# Function to check if Tomcat is running
is_tomcat_running() {
  # Check if Tomcat process is running
  if ps aux | grep '[t]omcat' > /dev/null
  then
    return 0
  else
    return 1
  fi
}

# Function to start Tomcat
start_tomcat() {
  echo "Starting Tomcat..."
  $TOMCAT_BIN_PATH/startup.sh
}

# Main script logic
if is_tomcat_running
then
  echo "Tomcat is already running."
else
  echo "Tomcat is not running. Starting Tomcat..."
  start_tomcat
fi