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

---

# 🎯 SRE Interview Questions with Answers (Mid-level+)

## 🖥️ OS & Performance

### What’s the difference between load average and CPU usage, and how do you interpret them?

- **CPU usage** shows the percentage of CPU time used.
- **Load average** shows the average number of processes waiting for CPU, disk, or I/O over 1, 5, and 15 minutes.
- High load with low CPU usage usually indicates I/O bottlenecks.

### How do you detect memory leaks in a service?

- Monitor memory usage over time (`top`, `htop`, Prometheus metrics).
- Use tools like `valgrind`, `pmap`, `gperftools`, or `heapdump` depending on the language.
- Check GC (garbage collection) logs in languages like Java/Python.

### What does high IOwait indicate, and how would you troubleshoot it?

- IOwait means CPU is idle but waiting for disk I/O.
- **Causes**: slow disks, too many concurrent requests, database contention.
- **Troubleshooting**: check `iostat`, `iotop`, disk latency, optimize queries, use faster storage (SSD/NVMe).

### Difference between vertical scaling and horizontal scaling?

- **Vertical:** Adding more resources (CPU/RAM) to a single machine. Easy but limited.
- **Horizontal:** Adding more machines/instances. More scalable, but adds complexity (load balancing, consistency).

## 🌐 Networking & Distributed Systems

### How does DNS caching work at different levels?

- **App-level cache** (e.g., browser cache).
- **OS resolver cache** (`nscd`, `systemd-resolved`).
- **Recursive resolver cache** (like 8.8.8.8).
- **Authoritative DNS** has TTL that controls cache duration.

### If latency increases between two microservices, how do you find the root cause?

- Check metrics (latency, error rate) from monitoring.
- Trace requests with distributed tracing (Jaeger, OpenTelemetry).
- Use network tools (`mtr`, `tcpdump`).
- Verify downstream dependencies (DB, API).

### What are circuit breaker and retry patterns, and why are they important?

- **Retry:** Automatically retry failed requests (with backoff).
- **Circuit breaker:** Stops sending requests when failure rate is high, allowing system to recover.
- Important in distributed systems to prevent cascading failures.

### Explain CAP theorem with examples

- **C (Consistency):** All nodes see the same data at the same time.
- **A (Availability):** Every request receives a response.
- **P (Partition tolerance):** System works despite network splits.
- **Example CP**: HBase, ZooKeeper.
- **Example AP**: Cassandra, DynamoDB.

## 📊 Observability & Monitoring

### Difference between metrics, logs, and traces?

- **Metrics:** Aggregated numerical data (CPU, QPS, latency).
- **Logs:** Event-based text records.
- **Traces:** Track requests across services (useful in microservices).

### What is cardinality in metrics, and why is it dangerous in Prometheus?

- **Cardinality** = number of unique label combinations.
- **High cardinality** (e.g., per-user metrics) causes high memory usage and slow queries.
- **Rule**: Avoid unbounded labels (like user IDs, request IDs).

### Difference between blackbox and whitebox monitoring?

- **Blackbox:** Tests from outside (ping, HTTP check). Focus on availability.
- **Whitebox:** Monitors internal metrics/logs. Focus on internal health.

### How do you deal with alert fatigue?

- Deduplicate and group alerts.
- Prioritize by severity and business impact.
- Use SLO-based alerting instead of raw metrics.
- Regularly review and tune alert rules.

## 🛠️ Containers / Kubernetes

### Difference between Deployment, StatefulSet, and DaemonSet in K8s?

- **Deployment:** Stateless workloads, easy scaling.
- **StatefulSet:** Stateful apps (DBs, Kafka), keeps identity & stable storage.
- **DaemonSet:** Ensures one pod runs on every node (e.g., logging/monitoring agents).

### Why might a Pod stay in Pending state?

- Not enough resources (CPU/RAM).
- Node selectors/affinity rules not satisfied.
- Missing PersistentVolume.
- Scheduler can’t place it due to taints/tolerations.

### When do you use HPA (Horizontal Pod Autoscaler), and what are its limitations?

- **Use**: Auto-scale pods based on metrics (CPU, custom metrics).

- **Limitations**:
  - Scaling delay (reactive, not predictive).
  - Doesn’t handle queue-based workloads well.
  - Needs accurate metrics.

### What is the role of kube-proxy?

- Handles Service networking in K8s.
- Maintains iptables/IPVS rules for load balancing traffic to pods.

## ⚡ Incident Response & Reliability

### Scenario: primary DB is down, replicas are healthy. What do you do?

- Promote a replica to primary (manual or via failover tool like Patroni, Orchestrator).
- Redirect traffic to new primary.
- Investigate and fix the original primary before reintroducing it.

### What metrics are critical for DB monitoring?

- Connection count, query latency, slow queries.
- Replication lag.
- Buffer cache hit ratio.
- Disk I/O and locks.

### What are MTTR, MTTD, and MTBF, and why are they important?

- **MTTR (Mean Time to Recovery):** Avg time to recover from failure.
- **MTTD (Mean Time to Detect):** Avg time to detect a failure.
- **MTBF (Mean Time Between Failures):** Avg time between failures.
- They measure reliability and efficiency of incident response.

### If rollback isn’t possible during a critical outage, what fallback strategies exist?

- Feature flagging (disable problematic feature).
- Graceful degradation (disable non-critical services).
- Rate limiting or traffic shedding.
- Serving cached/stale data.

## 🧩 Automation & DevOps Practices

### What is Infrastructure as Code (IaC), and why is it important? and it's tools?

- Managing infra with code instead of manual config.
- **Benefits**: repeatability, version control, automation.
- **Tools**: Terraform, Ansible, Pulumi, CloudFormation.

### What are the stages of a CI/CD pipeline, and how do they relate to SRE?

- **Stages**: build → test → deploy → verify.
- **SRE ensures reliability**: automated rollbacks, monitoring after deploys, canary releases.

### What’s the difference between blue-green and canary deployment?

- **Blue-green:** Two environments, switch all traffic at once.
- **Canary:** Gradually shift traffic to new version, monitor errors, roll back if needed.

### What is chaos engineering, and why is it useful?

- **Definition**: Practice of intentionally injecting failures into systems.
- **Goal**: test resilience and validate recovery processes before real outages happen.

---

# 🔹 Senior/Lead SRE Interview Questions (Advanced Level)

## 🏗️ Architecture & Scalability

### How would you design a highly available global system (e.g., an e-commerce site) that serves millions of users?

**A (key points):**

- Multi-region deployment (active-active or active-passive).
- Load balancing with global traffic managers (GSLB, Anycast DNS).
- Database replication across regions (read replicas, multi-master with conflict resolution).
- CDN for static assets.
- Caching layer (Redis, Memcached).
- Graceful degradation under heavy load.

### What’s the difference between consistency models (strong, eventual, causal)? When would you use each?

- **Strong consistency:** Clients always read the latest write (banking).
- **Eventual consistency:** Updates propagate over time (social feeds).
- **Causal consistency:** Reads respect cause-effect order (chat systems).

### How do you handle a “thundering herd” problem?

- Add caching with randomized TTLs.
- Use request coalescing (deduplicate identical requests).
- Apply rate limiting/backpressure.
- Queue requests with message brokers.

## 🌐 Reliability & Trade-offs

### How do you decide between active-active vs. active-passive architecture for a critical system?

- **Active-active:** Higher availability, load distribution, complex conflict resolution.
- **Active-passive:** Easier to manage, cheaper, but slower failover.
- Decision depends on SLA requirements and budget.

### How do you approach error budgets?

- **Error budget** = SLO target − actual reliability.
- If error budget is burned quickly → slow down releases, focus on reliability.
- If error budget is underused → increase release velocity.

#### In a system with 5 nines availability target (99.999%), what does that mean in downtime per year?

- **99.999%** = \~5 minutes/year downtime allowed.
- Implies extreme redundancy, automation, and very fast failover.

## 📊 Observability at Scale

### How do you design an observability stack for thousands of microservices?

- Centralized logging (ELK/Loki/Cloud-native log storage).
- Metrics with high retention and downsampling (Prometheus + Cortex/Thanos).
- Distributed tracing (OpenTelemetry/Jaeger).
- SLO-driven alerting (reduce noise).

### How would you debug a performance regression in production when metrics look normal?

- Use tracing to track request latency across services.
- Compare baseline vs regression requests.
- Check for hidden bottlenecks (thread pools, DB indexes, GC pauses).
- Test with load replay (synthetic traffic).

## 🔄 Incident Response at Scale

### Imagine a global outage is caused by a bad config push. How do you manage the incident?

1. Declare incident and assign roles (commander, communicator, investigator).
2. Rollback config immediately.
3. Communicate status to stakeholders/customers.
4. Run postmortem: root cause, why rollback didn’t happen faster, fix processes.

### How do you balance speed of incident response with risk of making it worse?

- Use predefined runbooks for known failure modes.
- Prefer safe rollbacks before risky fixes.
- Separate mitigation (quick fix) from remediation (long-term fix).

## ⚡ Cost & Efficiency

### How do you optimize cloud infrastructure cost while maintaining reliability?

- Rightsizing instances.
- Auto-scaling down at off-peak.
- Spot/preemptible instances for non-critical workloads.
- Storage lifecycle policies (tiering).
- Monitoring unused resources.

### If management asks to cut infra costs by 20% without lowering SLOs, what strategies do you apply?

- Identify overprovisioned clusters.
- Consolidate workloads with bin-packing.
- Review error budgets → maybe slightly relax SLOs.
- Optimize DB queries and caching.

## 🧩 Culture & Leadership

### How do you enforce a blameless postmortem culture?

- Focus on system/process failures, not individuals.
- Encourage sharing failures openly.
- Reward proactive prevention instead of heroics.

### How do you mentor junior SREs?

- Pair on incident handling.
- Walk through troubleshooting thought processes.
- Encourage writing runbooks and automation scripts.
- Teach prioritization (impact vs urgency).

### This level is typically for Lead SRE or Senior

- Must be able to design complex systems
- Explain trade-offs between cost, scale, and reliability
- Take a leadership role in critical incidents
- Help the team grow and develop the right culture.
