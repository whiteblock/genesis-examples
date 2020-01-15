# Static nginx serving html with a HTML page we inject.

This example shows how to serve some static content from Nginx, serving our own HTML.

## Services

### Nginx
Nginx docker image with some static default content

## Tasks

### wait-10-minutes
Sleeps for 10 minutes

## Tests

|  Phase       | Duration   | Description                                                         |
|--------------|------------|---------------------------------------------------------------------|
| Serving      |  10 minutes | Run one nginx node serving static content on port 80                |