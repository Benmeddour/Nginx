## Introduction
When developing web applications, we typically test them on `localhost`, using Node.js’s built-in server. In this environment, everything runs smoothly because the traffic is minimal. However, when the application is deployed to production and starts receiving real user requests from the internet, problems arise—slow performance, crashes, and unresponsiveness.

The reason behind this is that a **Node.js server alone is not optimized to handle high traffic efficiently**. While Node.js is great for handling asynchronous requests, it still has limitations when dealing with a large number of concurrent users. Using `localhost` or running a standalone Node.js server in production means:

* **No Load Balancing**: All traffic goes to a single instance, which can get overwhelmed.
* **Lack of Reverse Proxy Features**: Direct client requests expose the backend, increasing security risks.
* **Inefficient Resource Management**: A single server may not scale well under heavy load.

To address these issues, we use a web server like **Nginx**, which acts as a reverse proxy and load balancer. Instead of letting users interact directly with the Node.js server, Nginx sits in front, handling incoming requests and distributing them efficiently across multiple instances of the application.

In this project, we will **deploy three instances of a Node.js application and configure Nginx to manage all incoming requests**. This will ensure better performance, improved scalability, and higher availability.

Follow along to learn how to set up Nginx as a **reverse proxy and load balancer** to optimize your web application for production!

## Prerequisites
- [minikube installed](https://minikube.sigs.k8s.io/docs/start)
- Basic understanding of Kubernetes and Docker

## Installation

This project has been containerized using Docker. To set up the environment, you will need the `nginx_pod.yaml` and `nodeApp_pods_creation.yaml` files. Follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/Benmeddour/Nginx.git
    cd Nginx
    ```

2. Deploy the Nginx pod:
    ```sh
    kubectl apply -f nginx_pod.yaml
    ```

3. Deploy three instances of the Node.js application:
    ```sh
    kubectl apply -f nodeApp_pods_creation.yaml
    ```

## Configuration

1. Verify that all pods are running:
    ```sh
    kubectl get pods -o wide
    ```

2. Note down the IP addresses of the `nodeApp` pods. These will be required for configuring the load balancer.

3. If all pods are in the `Running` state, access the Nginx container:
    ```sh
    kubectl exec nginx-pod -it -- /bin/bash
    ```

4. Update the Nginx configuration:
    - Install a text editor (if not already installed):
        ```sh
        apt update
        apt install nano
        ```
    - Open the Nginx configuration file:
        ```sh
        nano /etc/nginx/nginx.conf
        ```
    - Add the following configuration under the `http` block:

        ```nginx
        upstream nodejs_cluster {
            # Define the load balancing algorithm
            least_conn; # Requests are sent to the server with the least active connections

            # Specify the IP addresses of your Node.js application pods
            server 192.168.1.101:3000; # Node.js instance 1
            server 192.168.1.102:3000; # Node.js instance 2
            server 192.168.1.103:3000; # Node.js instance 3
        }
        ```

5. Update the default site configuration:
    - Open the default configuration file:
        ```sh
        nano /etc/nginx/conf.d/default.conf
        ```
    - Replace the `location / {}` block with the following:
        ```nginx
        location / {
            proxy_pass http://nodejs_cluster;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
        ```

6. Restart the Nginx service to apply the changes:
    ```sh
    nginx -s reload
    ```

Your Nginx server is now configured to act as a reverse proxy and load balancer for the Node.js application instances.

## Test the Setup Using a Curl Pod

To verify that the Nginx reverse proxy and load balancer are working as expected, you can use a `curl` pod to send requests to the Nginx pod.

1. Deploy a `curl` pod:
    ```sh
    kubectl run curl-pod --image=curlimages/curl -i --tty -- /bin/sh
    ```

2. Send a request to the Nginx pod:
    ```sh
    curl http://<NGINX_POD_IP>:80
    ```

    Replace `<NGINX_POD_IP>` with the IP address of the Nginx pod. You can find this IP by running:
    ```sh
    kubectl get pods -o wide
    ```

3. Observe the response. You should see the output from one of the Node.js application instances. Repeat the `curl` command multiple times to verify that requests are being distributed across the instances.

4. Exit the `curl` pod shell:
    ```sh
    exit
    ```

This confirms that the Nginx reverse proxy and load balancer are correctly routing traffic to the Node.js application instances.
## Summary

In this project, we demonstrated how to optimize a Node.js application for production by deploying multiple instances and configuring Nginx as a reverse proxy and load balancer. Key steps included:

- Setting up the environment using Kubernetes and Docker.
- Deploying three Node.js application instances and an Nginx pod.
- Configuring Nginx to distribute incoming requests efficiently using the `least_conn` load balancing algorithm.
- Verifying the setup with a `curl` pod to ensure proper traffic distribution.

This setup improves performance, scalability, and availability, making it suitable for handling high traffic in production environments. For more information about Nginx, you can visit [my_nginx_wiki](https://github.com/Benmeddour/Nginx/wiki), which I created to simplify and explain Nginx concepts.