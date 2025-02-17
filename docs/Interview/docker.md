# Docker

## Runc-Shim

### What is difference between SHIM and RUNC in docker?

In Docker, **`shim`** and **`runc`** are components that play crucial roles in the container lifecycle, but they serve different purposes. Here's a detailed explanation of their differences:

### 1. `runc`

- **What is `runc`?**

  - `runc` is a lightweight, standalone CLI tool for spawning and running containers according to the **Open Container Initiative (OCI)** specification.
  - It is the reference implementation of the OCI runtime specification and is used by Docker (and other container runtimes) to create and manage containers.
  - `runc` is responsible for the low-level tasks of setting up the container environment, such as namespaces, cgroups, and filesystem mounts.

- **Key Responsibilities**:

  - Creating and starting containers.
  - Setting up isolation using Linux kernel features (namespaces, cgroups, etc.).
  - Managing the container lifecycle (start, stop, pause, delete).
  - Ensuring compliance with the OCI runtime specification.

- **How Docker Uses `runc`**:

  - Docker uses `runc` as its default container runtime to create and run containers.
  - When you run a container with Docker, it delegates the actual container creation and execution to `runc`.

- **Example**:
  - When you run `docker run`, Docker prepares the container configuration (e.g., image, networking, volumes) and then calls `runc` to create and start the container.

### 2. `containerd-shim` (or `shim`)

- **What is `shim`?**

  - The `shim` is a lightweight process that sits between the container runtime (like `runc`) and the container manager (like Docker or Kubernetes).
  - It acts as an intermediary to decouple the container lifecycle from the Docker daemon or other high-level managers.
  - Each container has its own `shim` process.

- **Key Responsibilities**:

  - Managing the lifecycle of a single container.
  - Keeping the container running even if the Docker daemon is restarted or crashes.
  - Handling I/O streams (stdin, stdout, stderr) for the container.
  - Reporting the container's exit status back to the container manager.

- **Why is `shim` Needed?**

  - Without the `shim`, if the Docker daemon crashes or is restarted, all running containers would also stop. The `shim` ensures that containers continue running independently of the Docker daemon.
  - It also allows Docker to upgrade or restart without affecting running containers.

- **How Docker Uses `shim`**:
  - When Docker starts a container, it creates a `shim` process for that container.
  - The `shim` then invokes `runc` to create and start the container.
  - The `shim` remains running as long as the container is running, acting as a bridge between the container and Docker.

### Key Differences Between `shim` and `runc`

| Aspect                  | `runc`                                                                       | `shim`                                                                                     |
| ----------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| **Purpose**             | Low-level container runtime for creating and running containers.             | Intermediary process to manage container lifecycle and decouple it from the Docker daemon. |
| **Role**                | Implements the OCI specification to create and run containers.               | Manages the container process and ensures it runs independently of the Docker daemon.      |
| **Lifecycle**           | Used to start, stop, and delete containers.                                  | Keeps the container running and handles I/O streams.                                       |
| **Dependency**          | Directly interacts with the Linux kernel to set up namespaces, cgroups, etc. | Depends on `runc` to create the container but manages it afterward.                        |
| **Number of Instances** | One `runc` process per container creation.                                   | One `shim` process per running container.                                                  |

### How They Work Together

1. When you run a container with Docker, the Docker daemon prepares the container configuration.
2. Docker calls `containerd`, which then invokes `containerd-shim`.
3. The `shim` process calls `runc` to create and start the container.
4. Once the container is running, `runc` exits, but the `shim` remains active to manage the container's lifecycle and I/O.

### Summary

- **`runc`**: The low-level runtime that creates and runs containers.
- **`shim`**: A helper process that ensures containers run independently of the Docker daemon and manages their lifecycle.

Together, `runc` and `shim` enable Docker to provide a robust and flexible container runtime environment.

---

## Image Layers

### Which dockerfile commands commit layer on the docker image?

1. RUN
2. COPY
3. ADD
4. WORKDIR
5. ENV

### How many ways do we have to reduce the size of generated docker image?

Reducing the size of a Docker image is an important consideration for improving efficiency, reducing deployment time, and minimizing resource usage. Below are several strategies you can employ to reduce the size of your Docker image:

### 1. Use Smaller Base Images

- Choose lightweight base images such as `alpine`, `distroless`, or minimal variants of official images.

  - Example: Use `python:3.9-alpine` instead of `python:3.9`.

- Avoid using large full-fledged OS images like `ubuntu` unless absolutely necessary.

### 2. Minimize the Number of Layers

- Combine commands into a single `RUN` instruction to reduce the number of layers.

  - Example:

    ```dockerfile
    # Instead of this:
    RUN apt-get update
    RUN apt-get install -y curl

    # Do this:
    RUN apt-get update && apt-get install -y curl
    ```

- Fewer layers result in smaller images and faster builds.

### 3. Clean Up Intermediate Files

- Remove unnecessary files, packages, and dependencies after installation.

  - Example:

    ```dockerfile
    RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
    ```

- This ensures temporary files (e.g., package lists) are not included in the final image.

### 4. Use Multi-Stage Builds

- Build your application in one stage and copy only the necessary artifacts to a smaller runtime image in another stage.

  - Example:

    ```dockerfile
    # Stage 1: Build
    FROM golang:1.19 AS builder
    WORKDIR /app
    COPY . .
    RUN go build -o main .

    # Stage 2: Runtime
    FROM alpine:latest
    WORKDIR /app
    COPY --from=builder /app/main .
    CMD ["./main"]
    ```

### 5. Avoid Installing Unnecessary Packages

- Only install the packages required for your application to run.
- Avoid including development tools or libraries that are not needed at runtime.

### 6. Use `.dockerignore` File

- Exclude unnecessary files and directories from being copied into the image.

  - Example `.dockerignore`:

  ```dockerfile
  .git
  *.log
  node_modules/
  target/
  ```

### 7. Optimize Language-Specific Dependencies

- For Node.js:

  - Use `--production` flag when installing npm packages to exclude devDependencies.

    ```dockerfile
    RUN npm install --only=production
    ```

- For Python:

  - Use `pip` with the `--no-cache-dir` option to avoid caching dependencies.

    ```dockerfile
    RUN pip install --no-cache-dir -r requirements.txt
    ```

### 8. Squash Image Layers

- Use tools like `docker-squash` or build systems that support squashing layers to combine all layers into a single layer.

**Note:** Squashing may not be ideal for all workflows due to potential loss of build history.

### 9. Compress Binaries and Assets

- Compress static assets (e.g., JavaScript, CSS) and binaries to reduce their size.
- Use tools like `upx` to compress executables.

### 10. Leverage Official and Optimized Images

- Use official and optimized images from trusted sources like Docker Hub.
- These images are often pre-configured for minimal size and security.

### 11. Remove Unused Environment Variables

- Avoid setting unnecessary environment variables that increase the image size.
- Clean up environment variables if they are no longer needed.

### 12. Use Slim or Minimal Tags

- Many official Docker images provide slim or minimal versions (e.g., `node:18-slim`, `java:17-jre-slim`).
- These variants are optimized for smaller sizes.

### 13. Monitor and Analyze Image Size

- Use tools like `docker inspect` or third-party tools like `dive` to analyze the contents of your image and identify areas for optimization.

  - Example:

    ```bash
    docker inspect --format='{{.Size}}' <image_id>
    ```

By applying these techniques, you can significantly reduce the size of your Docker images while maintaining functionality and performance. The effectiveness of each method depends on the specific context of your application and its dependencies.

