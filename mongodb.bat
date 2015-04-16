@echo off
rem Specific for my environment #YOLO
start "C:\Program Files\MongoDB\Server\3.0\bin\mongo.exe" "test"
"C:\Program Files\MongoDB\Server\3.0\bin\mongod.exe" --config="C:\MongoDB\mongod.cfg"