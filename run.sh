#!/bin/bash

go build -o bookings cmd/web/*.go
./bookings -dbname=bookings -dbuser=halaszdavid -cache=false -production=false