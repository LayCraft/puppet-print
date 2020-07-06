FROM node:12

# update the apt packages
RUN apt-get update

# Install Chromium for OS dependencies. Chromium is not actually used but puppeteer requires them
RUN apt-get install -y wget gnupg ca-certificates \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  # refresh apt lists so we can get chrome
  && apt-get update \
  && apt-get install -y google-chrome-stable \
  # Install fonts to support major charsets for printing (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
  && apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
  # remove the apt lists
  && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont 

# It's a good idea to use dumb-init to help prevent zombie chrome processes.
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /usr/src/app
# copy the repo's npm dependencies into the working directory
COPY package*.json ./
# install the dependencies
RUN npm ci
# copy the rest of the repo files into to work directory
COPY . .
# build the typescript files into javascript files
RUN npm run build
# open the print service port
EXPOSE 3000
USER 1001

# Use the Yelp init system as an entrypoint into the container to minimize zombie processes
ENTRYPOINT ["dumb-init", "--"]
# run the 
CMD ["npm", "run", "start"]
