# 06 Monitoring Distributed Systems

## Recap

### Review

First, the key points from the file include definitions like **white-box & black-box** monitoring, the four golden signals **(latency, traffic, errors, saturation)**, and the importance of distinguishing symptoms from causes. There's also a focus on avoiding alert fatigue by only paging for urgent, actionable issues.

The main purpose of monitoring. The four golden signals are crucial, so each should be explained briefly. The **symptoms vs. causes section** is important for understanding how to set up effective alerts.

The elements are covered: monitoring definitions, four signals, symptoms vs. causes, black-box vs. white-box, alerting best practices, case studies, and long-term strategies. Also, mention the importance of dashboards and avoiding unnecessary complexity.

### Definitions

#### **Core Principles of Monitoring**

1. **Purpose of Monitoring**:

   - Analyze trends, compare performance, alert on issues, build dashboards, and debug problems.
   - Focus on **user-visible symptoms** (e.g., slow responses) rather than internal causes (e.g., CPU spikes) for paging.

2. **Key Definitions**:

   - **White-box Monitoring**: Metrics from internal system data (logs, instrumentation).
   - **Black-box Monitoring**: External checks simulating user interactions (e.g., HTTP probes).
   - **Alert**: A notification requiring human action (paged, ticketed, or emailed).

3. **The Four Golden Signals**:
   - **Latency**: Time to service requests (distinguish between successful/failed requests).
   - **Traffic**: Demand on the system (e.g., requests/sec, concurrent users).
   - **Errors**: Failure rate (explicit, implicit, or policy-based errors).
   - **Saturation**: Resource utilization (e.g., CPU, memory) and capacity limits.

### **Symptoms vs. Causes**

- **Symptoms** (What’s broken): Directly impact users (e.g., HTTP 500 errors).
- **Causes** (Why it’s broken): Underlying issues (e.g., database connection failures).
- **Black-box monitoring** detects active symptoms; **white-box monitoring** identifies root causes and imminent problems.

### **Alerting Best Practices**

1. **Avoid Alert Fatigue**:

   - Page only for **urgent, actionable, user-visible issues**.
   - Eliminate non-critical alerts (e.g., "CPU at 90%") unless they signal an imminent problem.
   - Use dashboards (not emails) to track subcritical issues.

2. **Actionable Alerts**:

   - Ensure every page requires **human intelligence** to resolve (avoid robotic responses).
   - Automate fixes for predictable issues (e.g., restarting a failed service).

3. **Signal Over Noise**:
   - Remove unused metrics, infrequent alerts, or redundant dashboards.
   - Prioritize simplicity to avoid fragile, complex systems.

### **Case Studies**

1. **Bigtable SRE**:

   - Over-alerting on synthetic SLOs led to burnout.
   - **Solution**: Temporarily relax SLOs (e.g., 75th percentile latency), disable email alerts, and focus on long-term fixes.

2. **Gmail**:
   - Task-level alerts overwhelmed engineers.
   - **Solution**: Script automated responses and prioritize root-cause fixes over band-aid solutions.

### **Long-Term Monitoring Strategy**

- Balance **short-term availability** (tactical fixes) with **long-term stability** (sustainable systems).
- Use **dashboards** to track trends and subcritical issues (e.g., error budgets, capacity forecasts).
- Regularly audit monitoring rules to remove obsolete alerts.

### **Key Takeaways**

- Monitoring must be **simple, actionable, and symptom-focused**.
- Prioritize **user experience** over internal metrics for paging.
- Invest in **automated remediation** and root-cause analysis to reduce toil.
- Align monitoring with **SLOs** to ensure reliability without over-engineering.

## Symptoms and Causes

In the context of monitoring distributed systems, **symptoms** and **causes** represent distinct layers of observability and are critical for effective incident management. Here's a detailed breakdown based on the chapter:

### **Symptoms**

- **Definition**: Observable, user-facing issues that indicate something is broken.
- **Characteristics**:
  - **User Impact**: Directly affect end-user experience (e.g., slow responses, HTTP 500 errors).
  - **Black-Box Detection**: Identified via external checks (e.g., synthetic probes simulating user interactions).
  - **Actionable Alerts**: Should trigger pages only when symptoms are urgent and require human intervention.
- **Examples**:
  - High latency for successful requests.
  - Increased error rates (e.g., HTTP 404/500 errors).
  - Service unavailability (e.g., users unable to load a page).

### **Causes**

- **Definition**: Underlying reasons behind symptoms, often rooted in system internals.
- **Characteristics**:
  - **Internal Metrics**: Detected via white-box monitoring (e.g., logs, CPU usage, database connection pools).
  - **Root-Cause Analysis**: Requires debugging to identify why a symptom occurred (e.g., network latency, resource exhaustion).
  - **Non-Alertable**: Typically not paged for unless they directly threaten user experience.
- **Examples**:
  - Database connection timeouts (cause → slow responses).
  - Overloaded CPUs or memory leaks (cause → latency spikes).
  - Misconfigured load balancers (cause → HTTP 500 errors).

### **Key Relationships**

1. **Layered Systems**:

   - A symptom for one team may be a cause for another.
     - _Example_: Slow database queries (symptom for the database SRE) → cause of slow frontend responses (symptom for the frontend SRE).

2. **Monitoring Types**:

   - **Black-Box**: Focuses on symptoms (e.g., "Is the website down?").
   - **White-Box**: Reveals causes (e.g., "Why is the database slow?").

3. **Alerting Philosophy**:
   - **Page on Symptoms**: Alerts should prioritize user-visible issues (e.g., "Latency > 1s for 99th percentile").
   - **Investigate Causes**: Use dashboards and logs to diagnose root causes post-alert.

### **Best Practices**

- **Avoid Over-Alerting**:
  - Do not page for causes (e.g., "CPU at 90%") unless they directly risk user impact.
  - Use dashboards to track non-critical causes (e.g., "Disk usage at 70%").
- **Prioritize Symptoms**:
  - Alert on the **Four Golden Signals** (latency, traffic, errors, saturation) to capture user impact.
- **Post-Mortem Analysis**:
  - Use white-box data to identify causes after resolving symptoms (e.g., logs, traces).

### **Takeaway**

Symptoms represent the "what’s broken," while causes explain the "why." Effective monitoring prioritizes symptoms for alerting to ensure rapid response to user impact, while causes are analyzed post-incident to drive systemic improvements. This distinction minimizes noise, reduces burnout, and aligns monitoring with SRE principles of reliability and sustainability.
