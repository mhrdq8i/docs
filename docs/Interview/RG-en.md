# 🎯 Questions and Answers for Junior SRE (Support-focused)

## 🔹 Basic OS and Networking Concepts

### What is the difference between a process and a thread?

- A process is a running program with its own memory and resources.
- A thread is an execution path inside a process that shares the process’s resources with other threads.

### What does it mean when a program in Linux becomes zombie or defunct, and what should be done?

- A zombie process means it has finished execution but its entry remains in the process table because the parent hasn’t collected the exit status.
- Solution: Usually solved by killing/restarting the parent (`kill -9 <parent_pid>`).

### What’s the difference between TCP and UDP and their use cases?

- TCP is connection-oriented, reliable, guarantees ordered delivery (used for web, email).
- UDP is connectionless, faster, less reliable (used for DNS, video streaming, online games).

### When a website doesn’t load in the browser, what troubleshooting steps would you take?

1. Check internet connectivity (`ping 8.8.8.8`)
2. Verify DNS resolution (`dig`, `nslookup`)
3. Check routing (`traceroute`)
4. Test port availability (`telnet <host> 80`, `curl -v`)
5. Review firewall or network policies

### What are the uses of `top`, `htop`, `netstat`, `ss`, `curl`, `ping`, `traceroute`?

- `top/htop` → Monitor CPU, memory, and processes
- `netstat/ss` → View network connections and ports
- `curl` → Test HTTP endpoints
- `ping` → Check IP reachability
- `traceroute` → Trace the route packets take

## 🔹 Services and Monitoring

### What is SRE, and how does it differ from DevOps or SysAdmin?

- SRE focuses on **reliability**, **availability**, and **performance** of services.
- SysAdmins manage servers and infrastructure.
- DevOps focuses on CI/CD and bridging development and operations.

### What’s the difference between monitoring and observability?

- Monitoring: Collecting and viewing metrics/logs (e.g., CPU usage, error rates).
- Observability: The ability to understand the internal state of a system based on its outputs (logs, metrics, traces).

### What are SLI, SLO, and SLA?

- **SLI (Service Level Indicator):** A measurable metric (e.g., percentage of successful requests).
- **SLO (Service Level Objective):** The target for SLI (e.g., 99.9% success rate).
- **SLA (Service Level Agreement):** A contractual commitment with customers, including penalties if targets aren’t met.

### What would you do if a service’s CPU or memory usage suddenly spikes?

1. Check resource usage (`top`, `htop`)
2. Identify heavy processes
3. Check logs for memory leaks or infinite loops
4. Apply limits using cgroups/Kubernetes resource limits
5. Scale the service if needed

### You see HTTP 500 errors in logs — how do you investigate?

1. Identify timestamps of the errors
2. Check dependencies (databases, external services)
3. Verify system resources
4. Test endpoint manually with `curl`
5. Review recent changes (deployments, configs)

## 🔹 Containers and Tools

### Do you have Docker experience? How does a container interact with the host OS?

- A container is an isolated process running on the host kernel.
- It uses namespaces (for isolation of processes, network, mounts, etc.) and cgroups (to limit resources).

### What’s the difference between an image and a container?

- **Image**: Immutable, read-only snapshot.
- **Container**: A running instance of an image with a writable layer.

### Do you know Kubernetes? What is a Pod, and what does CrashLoopBackOff mean?

- **Pod**: The smallest deployable unit in K8s (one or more containers).
- **CrashLoopBackOff**: The container repeatedly crashes and Kubernetes keeps restarting it, often due to misconfiguration, dependency failure, or code bugs.

## 🔹 Support and Incident Handling

### If you get an alert at 3 AM that a database is down, what’s your first action?

**A:**

1. Validate the alert
2. Check service status (`systemctl status`, `docker logs`, health checks)
3. Review system resources (CPU, RAM, disk)
4. Attempt quick restore (restart or failover)
5. Notify the team if escalation is required

### What’s the difference between issue, incident, problem, and outage?

- **Issue:** Any reported problem
- **Incident:** An event affecting service reliability
- **Problem:** Root cause behind one or more incidents
- **Outage:** Severe or complete service downtime

### Have you written a postmortem? What should it include?

- A postmortem analyzes an incident and should include:

  - Description of the event
  - Timeline
  - Impact on users
  - Root cause
  - Actions taken
  - Action items for prevention

### If you notice a critical service is having issues but no alert has fired, what would you do?

1. Investigate and confirm the issue
2. Document and inform the team
3. Stabilize or mitigate the issue
4. Add or fix missing alerts afterward

## 🔹 Soft Skills

### How do you collaborate with developers when troubleshooting?

- Provide logs and metrics clearly
- Explain issues factually without blame
- Suggest reliability improvements

### Can you give an example of automating a repetitive issue?

- Automated restarting a service after crashes using a script or systemd unit instead of doing it manually.

### When multiple requests come at once, how do you prioritize?

- Based on **user and business impact**.
- Issues affecting critical services or SLA violations come first.
