@echo off
rem Specific for my environment #YOLO
start "Client" "C:\Program Files\MongoDB\Server\3.0\bin\mongo.exe"
"C:\Program Files\MongoDB\Server\3.0\bin\mongod.exe" --config="C:\MongoDB\mongod.cfg"
