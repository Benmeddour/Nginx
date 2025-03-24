# Use the official Node.js image as the base image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json .
COPY server.js .
COPY index.html .
COPY images ./images

# Install dependencies
RUN npm install


# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "server.js"]