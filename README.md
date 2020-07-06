# Puppet Print

Use the chromium rendering engine to print a html file into a pdf file. There are two basic routes in the microservice. 

1.  `localhost:3000/health` is a keep-alive `GET` endpoint for health checks. If this endpoint stops responding you should get your container management platform to restart this container.

2. `localhost:3000/pdf` is a `POST` endpoint that gets a `text/html` file (with inline embedded content) and it returns a pdf.

The purpose of the PDF microservice is to generate PDF documents from HTML. The max size for a html file is hard coded at 10mb. No database is used to generate the PDF. The file should be sent to the service with all files embedded into the html. One file goes in and one file comes out. 

## Run and Develop Locally

In the root of the project folder perform an `npm install` to build your node modules folder. This gets dependencies and allows linting and hinting in VS Code for the project as you make changes in typescript.

To develop locally `npm install` the dependencies and `npm run watch`. Watch command runs the project using nodemon which means every change in typescript will cause the project to recompile and restart. That means no manual steps are required to build or compile the changes during development.

## Run In Docker

You will need docker desktop installed. The docker container will run the contents of the `dist` folder. When docker is running `npm run docker-build` will create the container which will run a production version of puppet print. To run the container use `npm run docker-start` and the container will start running. After building docker containers many times it makes sense to tidy-up using `npm run docker-clean` which cleans up any dangling or exited containers.

## Testing

The REST API for both docker and local development runs on port 3000. To check that the API is working run `test/test.sh`. test.sh should get the microservice to generate `sample.pdf` from the `sample.html` file.

In the test folder there is a shell script that can be run `test.sh`. This requires bash and curl to use. The script POSTs `sample.html` to the printer service running and if the service is working correctly `sample.pdf` should appear in the test directory so you can inspect the results of the PDF print.

### Triggering the PDF export

