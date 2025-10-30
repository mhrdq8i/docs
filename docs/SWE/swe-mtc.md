# Terms

# Software Engineer Main Terms Concept 

```bash
Reliability
├── Availability
│   ├── Uptime
│   ├── Redundancy
│   ├── Failover
│   ├── Disaster Recovery
│   └── Incident Management
├── Fault Tolerance
│   ├── Error Detection
│   ├── Recovery Mechanisms
│   └── Self-Healing Systems
├── Performance
│   ├── Latency
│   ├── Throughput
│   └── Resource Utilization
└── Scalability
    ├── Vertical Scaling (Scale Up)
    ├── Horizontal Scaling (Scale Out)
    └── Elasticity
```

## **Reliability**
The ability of a system to function correctly and consistently over time, meeting specified requirements under stated conditions.

---

### **Availability**
The degree to which a system is operational and accessible when needed, typically expressed as a percentage (e.g., 99.9% uptime).

**Uptime**
The total time a system is operational and available for use, often measured as a percentage of total time.

**Redundancy**
The duplication of critical components or functions to provide backup in case of failure, ensuring continued operation.

**Failover**
The automatic switching to a redundant or standby system, server, or network when the primary system fails.

**Disaster Recovery**
The processes and policies for restoring systems, data, and operations after catastrophic events like natural disasters or major outages.

**Incident Management**
The process of identifying, analyzing, and responding to system failures or service disruptions to minimize impact and restore normal operations quickly. This includes detection, escalation, resolution, and post-incident analysis to prevent future occurrences.

This term typically sits alongside or encompasses aspects of **Fault Tolerance** and **Availability**, as it deals with how organizations respond to and manage system reliability issues when they occur.

---

### **Fault Tolerance**
The ability of a system to continue operating properly even when one or more components fail.

**Error Detection**
Mechanisms to identify when errors or failures occur in a system, often through monitoring, logging, or automated checks.

**Recovery Mechanisms**
Processes and techniques used to restore a system to normal operation after a fault or error occurs.

**Self-Healing Systems**
Systems that can automatically detect, diagnose, and recover from failures without human intervention.

---

### **Performance**
How efficiently and quickly a system executes tasks and responds to requests.

**Latency**
The time delay between a request being made and the response being received, typically measured in milliseconds.

**Throughput**
The amount of work or number of transactions a system can process in a given time period.

**Resource Utilization**
How efficiently a system uses its available resources (CPU, memory, storage, network bandwidth).

---

### **Scalability**
The capacity of a system to handle growing amounts of work or to be expanded to accommodate growth.

**Vertical Scaling (Scale Up)**
Adding more power to existing machines (more CPU, RAM, storage) to handle increased load.

**Horizontal Scaling (Scale Out)**
Adding more machines or nodes to distribute the workload across multiple systems.

**Elasticity**
The ability to automatically scale resources up or down based on current demand, particularly common in cloud environments.
