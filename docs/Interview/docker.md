# Docker

## Docker  Full Architecture

A **full architectural diagram of Docker** with **all components**, arrows showing **how they interact**.

- **what each part is?**
- **how it works?**
- **why it’s needed?**

Here’s the structured breakdown:

## 🐳 **Docker Full Architecture**

```bash
+------------------+             +-------------------+
|  Docker CLI /    |             |  Docker Compose,  |
|  Client (API)    |             |  Buildx, etc.     |
+--------+---------+             +---------+---------+
         |                                 |
         | REST API (via UNIX socket/HTTP) |
         v                                 v
+------------------------------------------------------+
|                  Docker Daemon (dockerd)             |
|                                                      |
|  +----------------------+   +---------------------+  |
|  | Build System         |   |  Container Runtime  |  |
|  | - BuildKit           |   |  - containerd       |  |
|  | - Buildx(CLI plugin) |   |  - runc (low level) |  |
|  +----------------------+   +---------------------+  |
|                                                      |
|  +----------------------+   +---------------------+  |
|  | Networking           |   |  Storage            |  |
|  | - Bridge, Host,      |   |  - Images (layers)  |  |
|  |   Overlay, Macvlan   |   |  - Volumes          |  |
|  +----------------------+   +---------------------+  |
|                                                      |
+------------------------------------------------------+
         |
         v
+----------------------+
|  Docker Registry     |
|  (Hub, Nexus, ECR,   |
|  GCR, private, etc)  |
+----------------------+
```

### 🔍 **Explanation of Components**

### 1. **Docker CLI / Client**

- **What**: The command-line interface (`docker run`, `docker build`, etc.) or REST API.
- **How**: Sends requests (build, run, stop, pull, push) to the Docker Daemon over Unix socket or TCP.
- **Why**: User entry point; without it you can’t interact with Docker.

### 2. **Docker Daemon (`dockerd`)**

- **What**: The brain of Docker, a background service that manages everything.
- **How**: Listens to CLI/API requests, orchestrates builds, networking, runtime, and storage.
- **Why**: Central controller; coordinates all sub-systems.

### 3. **Build System**

- **BuildKit**

  - **What**: Modern build engine for Docker images.
  - **How**: Parallel builds, caching, secrets, mounts, advanced frontend (Dockerfile).
  - **Why**: Efficient image creation.
- **Buildx**

  - **What**: CLI plugin to control BuildKit.
  - **How**: Enables multi-platform builds, remote builders, advanced push.
  - **Why**: Extends BuildKit capabilities to the user.

### 4. **Container Runtime**

- **containerd**

  - **What**: Industry-standard container runtime, manages lifecycle (start/stop/pull/push).
  - **How**: Talks to `runc` to actually create containers.
  - **Why**: Abstracts container execution from Docker.
- **runc**

  - **What**: Low-level runtime that runs containers (based on OCI spec).
  - **How**: Uses Linux namespaces & cgroups to isolate processes.
  - **Why**: Core of “what a container is”.

### 5. **Networking**

- **What**: Provides connectivity between containers, host, and external networks.
- **How**: Uses Linux bridges, iptables, overlay drivers, DNS.
- **Why**: Containers need to communicate with each other and the outside world.
- Types:

  - **Bridge** (default, private container LAN)
  - **Host** (shares host network)
  - **Overlay** (multi-host networking, Swarm/K8s)
  - **Macvlan** (assigns MACs from physical LAN)

### 6. **Storage**

- **Images**

  - **What**: Read-only templates layered with UnionFS.
  - **How**: Pulled from registry or built locally.
  - **Why**: Base definition of a container.
- **Volumes**

  - **What**: Persistent storage separate from container lifecycle.
  - **How**: Mounted into containers.
  - **Why**: Keep data even if container is removed.
- **Layering**

  - **What**: Images built from multiple layers.
  - **How**: COW (copy-on-write).
  - **Why**: Reuse common layers, save space.

### 7. **Registry**

- **What**: Repository of images (Docker Hub, private registries).
- **How**: Stores, pulls, pushes image layers.
- **Why**: Distributes and shares containerized applications.

✅ **How it works all together**

1. User runs `docker run nginx`.
2. CLI → Daemon (`dockerd`).
3. Daemon checks **local image cache**; if missing, pulls from **registry**.
4. Daemon asks **containerd** to create container.
5. **containerd** calls **runc** to start process in isolated namespaces/cgroups.
6. Networking stack connects container to right network.
7. Volumes/images mount into container filesystem.
8. Container runs → user sees output.

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

## BuildKit & BuildX

### Docker BuildKit

- **What it is:**

  BuildKit is the **next-generation backend** for building Docker images. It was introduced to replace the legacy builder that `docker build` originally used.

- **Key features:**

  - Parallel builds → speeds up image creation.
  - Build cache improvements (local, inline, external).
  - Secret management (`--secret` for injecting secrets at build time).
  - Build-time mounts (e.g., `RUN --mount=...` for efficient builds).
  - Better support for multi-stage builds.
  - Frontends (like `Dockerfile` or `dockerfile:experimental`).

- **How it works:**

  BuildKit is a **build engine**. When you run `DOCKER_BUILDKIT=1 docker build ...`, you’re telling Docker to use BuildKit instead of the old builder.

### Docker Buildx

- **What it is:**

  Buildx is a **CLI plugin** (`docker buildx`) that **wraps BuildKit** and exposes its full power with a friendlier interface. It was introduced later to manage more advanced use cases.

- **Key features:**

  - Manages multiple **build contexts/drivers** (local, remote, Kubernetes, Docker).
  - Makes **cross-platform builds** easy with `--platform` (e.g., build for `linux/arm64` on an x86 machine).
  - Lets you **create builder instances** with isolated cache/storage backends.
  - Pushes directly to registries without storing local images (`--push`).
  - Exposes all BuildKit features that `docker build` doesn’t natively expose.

- **How it works:**

  `docker buildx build` always uses BuildKit under the hood. It’s essentially the **frontend/manager** for BuildKit.

### In short

- **BuildKit** = the *engine* that performs the builds.
- **Buildx** = the *tooling* (CLI plugin) that lets you interact with BuildKit in more powerful ways (multi-arch, remote builders, etc.).

✅ **Example:**

- If you just enable BuildKit:

  ```bash
  DOCKER_BUILDKIT=1 docker build .
  ```

  → Faster, better caching, but only local builds.

- If you use Buildx:

  ```bash
  docker buildx build --platform linux/amd64,linux/arm64 --push -t myrepo/myimage:latest .
  ```

  → Same BuildKit engine, but now with multi-platform support and direct push.

## Docker UFS

### Union File System*

In the context of Docker, **UFS stands for Union File System**. It's a foundational technology that enables Docker's efficient and lightweight image and container management.

At its core, a Union File System allows multiple directories, known as layers, to be transparently overlaid, creating a single, unified view. This means that files and directories from different layers appear as if they are in a single filesystem, even though they are physically stored separately.

### How UFS Works with Docker

Docker leverages UFS to build container images and run containers in a layered fashion. Here's a breakdown of how it works:

- **Image Layers:** A Docker image is not a single monolithic file. Instead, it's composed of multiple read-only layers stacked on top of each other. Each instruction in a Dockerfile (e.g., `RUN`, `COPY`, `ADD`) creates a new layer. This layered approach is highly efficient because layers can be shared and reused across different images. For instance, if you have multiple images based on the same Ubuntu base image, the Ubuntu layers are stored only once on the host machine.

- **Container Layer:** When you start a container from an image, Docker adds a thin, writable layer on top of the read-only image layers. This is often called the "container layer" or "writable layer." Any changes you make inside the running container, such as creating, modifying, or deleting files, are written to this container layer. The underlying image layers remain untouched.

- **Copy-on-Write (CoW):** This is a key principle of UFS. When a running container needs to modify a file that exists in one of the read-only image layers, the UFS performs a "copy-on-write" operation. It copies the file from the read-only layer up to the writable container layer and then modifies the copied file. This ensures that the original image remains immutable and that multiple containers can share the same underlying image without interfering with each other.

### Advantages of UFS in Docker

The use of Union File Systems in Docker offers several significant benefits:

- **Efficiency and Disk Space Savings:** Because image layers are shared, you don't need to have a full copy of the entire filesystem for every container. This dramatically reduces disk space usage, especially when you have many containers based on the same images.

- **Faster Container Startup:** Since Docker only needs to create the thin writable container layer when starting a new container, the startup process is incredibly fast.

- **Image Versioning and Rollbacks:** The layered architecture makes it easy to version images. Each layer is a set of changes, similar to commits in a version control system. This also simplifies rolling back to a previous version of an image.

- **Isolation:** The copy-on-write mechanism ensures that changes made within one container do not affect other containers, even if they are based on the same image.

### Common UFS Implementations

While the concept is "Union File System," Docker can use different storage drivers that implement this functionality. Some of the common ones include:

- **OverlayFS (overlay2):** This is the preferred and default storage driver for most modern Linux distributions. It's known for its performance and simplicity.

- **AUFS (Another Union File System):** This was one of the earliest storage drivers used by Docker and is still available, though less common now.

In summary, the Union File System is a crucial technology that underpins Docker's efficiency, speed, and flexibility by enabling a layered approach to building and running containers.
