# Static nginx serving html

This example shows how to serve some static content from Nginx.

## Services

### Nginx
Nginx docker image with some static default content

## Tasks

### wait-10-minutes
Sleeps for 10 minutes

## Tests

|  Phase       | Duration   | Description                                                         |
|--------------|------------|---------------------------------------------------------------------|
| testnet      |  10 minutes | Run one nginx node serving static content on port 80                |