# Nginx Project

This project is a Node.js application configured to work with Nginx as a reverse proxy.

## Prerequisites

- Node.js (v14 or higher)
- Nginx

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/Benmeddour/Nginx.git
    cd Nginx
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

## NGINX vs Apache: Web Server Comparison

### Introduction to Web Servers

NGINX (pronounced "engine-x") and Apache HTTP Server are the two most popular open-source web servers powering over 60% of websites worldwide. While both serve similar fundamental purposes - delivering web content to users - they have different architectures and strengths.

### NGINX Architecture

- **Event-driven architecture:** Handles thousands of concurrent connections efficiently.
- **Optimized static content delivery.**
- **Advanced reverse proxy capabilities.**
- **Seamless connection to app servers.**

### Apache Architecture

- **Process/thread-based architecture.**
- **Flexible processing models (prefork, worker, event).**
- **Directory-level configuration with .htaccess.**
- **Extensible functionality with dynamic modules.**
- **Traditional dynamic content handling with CGI support.**

### Core Components Compared

| Aspect          | NGINX                            | Apache                                |
|-----------------|----------------------------------|---------------------------------------|
| Architecture    | Event-driven, asynchronous       | Process/thread-based                  |
| Performance     | Excellent for static content     | Better for dynamic content            |
| Configuration   | Centralized                      | Distributed (.htaccess)               |
| Resource Usage  | Lightweight                      | More resource-intensive               |
| Use Cases       | Modern web apps, microservices   | Traditional web applications          |

### When to Use Each

Choose **NGINX** when you need:
- High performance static content delivery
- Reverse proxy/load balancing
- Microservices architecture support
- Kubernetes integration

Choose **Apache** when you need:
- .htaccess flexibility
- Shared hosting environments
- Legacy application support
- Dynamic module loading

Both servers continue to evolve, with many organizations using them in complementary ways - NGINX as a reverse proxy in front of Apache application servers.

## Additional Resources

- [NGINX Documentation](https://nginx.org/en/docs/)
- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
- [Creating Kubernetes Pods for Applications](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Configuring NGINX as a Load Balancer](https://docs.nginx.com/nginx/admin-guide/load-balancer/)

For in-depth comparisons and tutorials, check out this [YouTube video](https://youtu.be/q8OleYuqntY).
