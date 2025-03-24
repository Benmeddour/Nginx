# Nginx Project

This project is a Node.js application configured to work with Nginx as a reverse proxy.

## Prerequisites

- Node.js (v14 or higher)
- Nginx

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/nginx-project.git
    cd nginx-project
    ```

2. Install dependencies:
    ```sh
    npm install
    ```

## Configuration

1. Configure Nginx:
    - Open the Nginx configuration file (e.g., `/etc/nginx/nginx.conf` or `/etc/nginx/sites-available/default`).
    - Add the following configuration:
    ```nginx
    server {
        listen 80;
        server_name yourdomain.com;

        location / {
            proxy_pass http://localhost:3000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
    }
    ```

2. Restart Nginx:
    ```sh
    sudo systemctl restart nginx
    ```
    ## Usage

    1. Start the Node.js application:
        ```sh
        node server.js
        ```

    2. Open your browser and navigate to `http://localhost:3000` to ensure the application is running.

    3. If everything is working correctly, you should see your application being served through Nginx at `http://yourdomain.com`.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


