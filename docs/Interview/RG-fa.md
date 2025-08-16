# 🎯 Junior SRE Interview Questions + Answers

## 🔹 Operating System & Linux

1. What does the `top` command show?

   **Answer:** Running processes, CPU usage, memory usage, and load average.

2. What is the difference between a `hard link` and a `soft link`?

   **Answer:**

   - A hard link points directly to the file’s inode;
   - A soft link (symlink) is a shortcut pointing to the file path.

3. What is the purpose of the `/etc/hosts` file?

   **Answer:** Manual mapping of hostnames to IP addresses.

4. Difference between `systemctl start` and `systemctl enable`?

   **Answer:**

   - `start` runs the service immediately;
   - `enable` makes it run automatically on boot.

5. Difference between process and thread?

   **Answer:**

   - **Process** = independent program with its own memory space.
   - **Thread** = unit of execution inside a process sharing the same memory.

6. Difference between `kill -9` and `kill -15`?

   **Answer:**

   - `-15` is a graceful termination signal (can be handled);
   - `-9` forces immediate kill (cannot be handled).

7. What does `df -h` show?

   **Answer:** Disk usage, total, used, and available space on partitions.

8. What is the difference between swap and RAM?

   **Answer:**

   - RAM is fast volatile memory;
   - SWAP uses disk as backup memory, much slower.

9. Purpose of `/etc/resolv.conf`?

   **Answer:** Configures DNS servers used by the system.

## 🔹 Networking

10. What does `ping` do?

    **Answer:** Sends `ICMP` packets to check reachability and latency.

11. Difference between TCP and UDP?

    **Answer:**

    - TCP is connection-oriented and reliable;
    - UDP is connectionless and faster but unreliable.

12. If DNS is not working but the network is fine, what do you check?

    **Answer:** Verify `/etc/resolv.conf`, test with `dig` or `nslookup`, check the DNS server.

13. What is port 80 used for?

    **Answer:** HTTP.

14. What is port 443 used for?

    **Answer:** HTTPS (HTTP over TLS).

15. Difference between public IP and private IP?

    **Answer:**

    - Public IP is routable on the internet;
    - private IP is only used in local networks.

16. What does NAT do?

    **Answer:** Translates private IP addresses to public IPs for internet access.

17. If `ping` fails but `traceroute` shows a path, what’s the reason?

    **Answer:** `ICMP` may be blocked by a firewall.

18. Difference between Layer 4 and Layer 7 load balancing?

    **Answer:**

    - L4 → based on IP/port (TCP/UDP).
    - L7 → based on application data (HTTP headers, paths).

## 🔹 Databases

19. Difference between RDBMS and NoSQL?

    **Answer:**

    - **RDBMS** (MySQL, PostgreSQL) stores structured data with ACID compliance;
    - **NoSQL** (MongoDB, Cassandra) handles unstructured data, scales horizontally.

20. What is database replication?

    **Answer:** Keeping identical copies of data across multiple servers for availability and redundancy.

21. Difference between Backup and Snapshot?

    **Answer:**

    - **Backup** = copy of data stored elsewhere;
    - **Snapshot** = point-in-time copy of a system/disk (usually in the same environment).

## 🔹 Security

22. Why is SSH key authentication better than passwords?

    **Answer:** Stronger security, prevents brute-force, easier for automation.

23. Difference between symmetric and asymmetric encryption?

    **Answer:**

    - **Symmetric** → same key for encryption/decryption (fast).
    - **Asymmetric** → public/private keys (more secure, slower).

24. Why is the Principle of Least Privilege important?

    **Answer:** Reduces risk by limiting user and service permissions.

## 🔹 Monitoring & Observability

25. Difference between Metrics, Logs, and Traces?

    **Answer:**

    - **Metrics** → numeric time-series data (CPU, latency)
    - **Logs** → textual events
    - **Traces** → request path across distributed systems

26. Difference between an Alert and a Notification?

    **Answer:**

    - **Alert** is triggered when a condition is violated;
    - **Notification** is the delivery method to the team.

27. Difference between Histogram and Gauge?
    **Answer:**

    - **Histogram** → distribution of values in buckets;
    - **Gauge** → current value of a metric.

28. What is a Canary Release?

    **Answer:** Gradual rollout of a new version to a small subset of users to reduce risk.

## 🔹 CI/CD & DevOps

29. Difference between Continuous Integration and Continuous Deployment?

    **Answer:**

    - **CI** = automatically testing and building code.
    - **CD** = automatically deploying code to production.

30. If a build fails in GitLab CI or Jenkins, what’s your first step?

    **Answer:** Check logs, identify the failing stage, rollback or apply a quick fix.

31. What is Blue-Green Deployment?

    **Answer:** Having two environments (blue & green) and switching traffic between them for zero-downtime deployment.

## 🔹 Cloud & Infrastructure

32. Difference between IaaS, PaaS, and SaaS?

    **Answer:**

    - **IaaS** → Infrastructure as a Service (VMs, storage).
    - **PaaS** → Platform as a Service (Heroku, App Engine).
    - **SaaS** → Software as a Service (Gmail, Slack).

33. What is Auto Scaling?

    **Answer:** Automatically adjusts the number of instances based on workload.

34. Difference between Region and Availability Zone?

    **Answer:**

    - **Region** = geographic area (e.g., Europe West).
    - **AZ** = independent datacenters within a region.

## 🔹 SRE Culture

35. Difference between SLA, SLO, and SLI?

    **Answer:**

    - **SLA** → agreement with customers
    - **SLO** → internal service quality target
    - **SLI** → numeric indicator (e.g., latency <200ms for 99% of requests)

36. What is a Postmortem and why is it important?

    **Answer:** A report after an incident including timeline, root causes, and corrective actions; ensures learning and prevention.

37. What is an Error Budget?

    **Answer:** Allowed amount of downtime/errors over a period, based on the SLO.

38. What is Blameless Culture?

    **Answer:** Focusing on learning and fixing issues instead of blaming individuals.
