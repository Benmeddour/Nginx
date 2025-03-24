# Authentication with JWT Token

This repository contains a Node.js project that demonstrates how to implement authentication using JSON Web Tokens (JWT).

## Features

- User registration and login
- Password hashing
- JWT token generation and verification
- Protected routes

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/authentication_JWT_Token.git
    ```
2. Navigate to the project directory:
    ```sh
    cd authentication_JWT_Token
    ```
3. Install the dependencies:
    ```sh
    npm install
    ```

## Usage

1. Start the server:
    ```sh
    npm start
    ```
2. The server will be running on `http://localhost:3000`.

## Endpoints

- `POST /register` - Register a new user
- `POST /login` - Login and receive a JWT token
- `GET /protected` - Access a protected route (requires a valid JWT token)

## Workflow

This project uses GitHub Actions for continuous integration and deployment. The workflows are defined in the `.github/workflows` directory.

### CI Workflow

The CI workflow is triggered on every push and pull request to the `master` branch. It includes the following steps:

1. **Setup Node.js** - Set up the Node.js environment.
2. **Install Dependencies** - Install project dependencies using `npm install`.
3. **Run Tests** - Run the test suite using `npm test`.

### Docker Workflow

The Docker workflow builds and pushes a Docker image to Docker Hub. It includes the following steps:

1. **Checkout Code** - Checkout the repository code.
2. **Set up Docker Buildx** - Set up Docker Buildx for multi-platform builds.
3. **Log in to Docker Hub** - Log in to Docker Hub using secrets.
4. **Build and Push Docker Image** - Build and push the Docker image to Docker Hub.




