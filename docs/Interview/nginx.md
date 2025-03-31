# Nginx

## Proxy ProxyHeader

### what is difference between proxy-header and proxy in Nginx?

The main difference between a proxy header and a proxy in Nginx is their purpose and functionality:

1. **Proxy Headers**:

   - Proxy headers are used to pass information about the _original request_ from the client to the upstream server.
   - These headers are typically used when Nginx is acting as a reverse proxy, forwarding requests to an upstream server.
   - Common proxy headers include `X-Forwarded-For`, `X-Forwarded-Host`, `X-Forwarded-Proto`, and `X-Real-IP`.
   - These headers help the upstream server understand the original client's information, such as the IP address, host, and protocol used.
   - Proxy headers are set by Nginx and passed along to the upstream server.

2. **Proxy**:
   - The `proxy` directive in Nginx is used to configure the settings for forwarding requests to an upstream server.
   - The `proxy` directive specifies the URL of the upstream server that Nginx should forward the request to.
   - It includes various configuration options, such as:
     - `proxy_pass`: The URL of the upstream server.
     - `proxy_set_header`: Sets additional headers to be passed to the upstream server.
     - `proxy_connect_timeout`: The timeout for connecting to the upstream server.
     - `proxy_read_timeout`: The timeout for reading a response from the upstream server.
   - The `proxy` directive is used to configure the overall behavior of the reverse proxy, including how requests are forwarded and how responses are handled.

In summary, **proxy headers** are used to pass information about the _original client request_ to the upstream server, while the `proxy` directive in Nginx is used to configure the settings for forwarding requests to an upstream server. Proxy headers are a part of the overall proxy configuration in Nginx, but they serve a different purpose than the `proxy` directive itself.

## `X-Forwarded-xxx` and `X-Real-IP` HTTP headers

The **X-Forwarded-For (XFF)**, **X-Forwarded-Proto (XFP)**, **X-Forwarded-Host (XFH)**, and **X-Real-IP** HTTP headers are _non-standard headers_ used to transmit client-side information (IP address, protocol, and host) when requests pass through proxies, load balancers, or reverse proxies. These headers help backend servers understand the original client’s details, which might otherwise be obscured by intermediaries. Below is a detailed explanation of each header:

### 1. X-Forwarded-For (XFF)

- **Purpose**: Identifies the **original IP address** of the client connecting through a proxy or load balancer.
- **Syntax**: A comma-separated list of IP addresses, where the **leftmost IP** is the client’s original IP, followed by each subsequent proxy that forwarded the request.
  - Example:
    `X-Forwarded-For: 192.168.2.1, 10.0.0.1, 172.16.0.1`
    Here, `192.168.2.1` is the client’s IP, and `10.0.0.1` and `172.16.0.1` are proxies.
- **Usage**:
  - Used when multiple proxies are involved to track the request path.
  - The backend server can use the first IP (client’s IP) for logging, geolocation, or access control.
- **Security Note**: Malicious clients can spoof this header, so servers should **only trust these headers from trusted proxies**.

### 2. X-Real-IP

- **Purpose**: Provides the **original client’s IP address** as seen by the _first proxy_ in the chain.
- **Syntax**: A single IP address (no list).
  - Example:
    `X-Real-IP: 192.168.2.1`
- **Usage**:
  - Simpler alternative to XFF, often used in setups with a single proxy (e.g., Nginx).
  - Less flexible than XFF for multi-proxy environments, as it doesn’t track intermediate proxies.
- **Relation to XFF**:
  - Some setups use `X-Real-IP` alongside `X-Forwarded-For` for backward compatibility.
  - Avoids ambiguity when only the client’s IP is needed.

### 3. X-Forwarded-Proto (XFP)

- **Purpose**: Indicates the **protocol** (HTTP or HTTPS) used by the client to connect to the _first proxy_.
- **Syntax**:
  - Example:
    `X-Forwarded-Proto: https`
- **Usage**:
  - Critical for servers behind SSL-terminating proxies (e.g., Cloudflare, Nginx).
  - Allows the backend to construct URLs with the correct protocol (e.g., for redirects or HSTS compliance).
  - Example: A proxy might receive HTTPS traffic but send HTTP to the backend; this header ensures the backend knows the original protocol.

### 4. X-Forwarded-Host (XFH)

- **Purpose**: Transmits the **original Host header** sent by the client to the _first proxy_.
- **Syntax**:
  - Example:
    `X-Forwarded-Host: example.com`
- **Usage**:
  - Useful for servers handling multiple domains (virtual hosting).
  - The backend can use this to serve content based on the original domain (e.g., `example.com` vs. `subdomain.example.com`).
  - Ensures proper routing and content delivery when the proxy handles multiple hosts.

### Key Considerations

1. **Security Risks**:

   - These headers can be easily spoofed if not properly configured.
   - **Only trust these headers when requests come from trusted proxies**.
   - Configure proxies to **strip or override these headers** before forwarding requests to the backend.

2. **Order of Proxies**:

   - `X-Forwarded-For` appends new proxies to the right. The client’s IP is always the leftmost entry.
   - Misconfigured proxies can corrupt the header chain (e.g., prepending instead of appending).

3. **Standards**:
   - These headers are **not part of the official HTTP specification** (RFC 7239 defines `Forwarded`, a standardized header).
   - However, they are widely adopted in practice.

### Example Scenario

Imagine a client accesses `https://example.com` through a reverse proxy (Proxy A) and a load balancer (Proxy B):

- **Client’s Request**:
  - `Host: example.com`
  - Protocol: HTTPS.
- **Proxy A (SSL Termination)**:
  - Sets `X-Forwarded-Proto: https`.
  - Sets `X-Forwarded-For: 192.168.2.1` (client IP).
  - Sets `X-Forwarded-Host: example.com`.
  - Forwards the request to Proxy B.
- **Proxy B (Load Balancer)**:
  - Appends its own IP to `X-Forwarded-For`: `192.168.2.1, 10.0.0.1`.
  - Forwards the request to the backend server.
- **Backend Server**:
  - Uses `X-Forwarded-For` to log the client’s IP (`192.168.2.1`).
  - Uses `X-Forwarded-Proto` to ensure secure redirects.
  - Uses `X-Forwarded-Host` to serve `example.com` content.

### Alternatives & Best Practices

- **RFC 7239 `Forwarded` Header**: A standardized header that combines all three (IP, protocol, host) into a single field. Example:
  `Forwarded: for=192.168.2.1; proto=https; host=example.com`.
- **Configuration Tips**:
  - Use trusted proxies to set these headers and disable client-set headers.
  - Validate headers (e.g., reject malformed or suspicious values).
  - Prefer `X-Forwarded-For` over `X-Real-IP` in multi-proxy setups.

By understanding these headers, developers and system administrators can ensure accurate logging, secure routing, and proper protocol handling in complex network architectures.
