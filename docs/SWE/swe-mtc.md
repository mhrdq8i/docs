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
│   ├── Self-Healing Systems
│   └── Replication
├── Performance
│   ├── Latency
│   ├── Throughput
│   └── Resource Utilization
└── Scalability
    ├── Vertical Scaling (Scale Up)
    ├── Horizontal Scaling (Scale Out)
    ├── Elasticity
    └── Sharding
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

---

### **Replication**
The process of copying and maintaining data across multiple servers or locations to ensure redundancy, improve fault tolerance, and enhance read performance.

**How it works:**
- Data is duplicated from a primary (master) database to one or more secondary (replica/slave) databases
- Changes made to the primary are propagated to replicas, either synchronously or asynchronously

**Key benefits:**
- **Fault Tolerance**: If the primary server fails, a replica can take over
- **High Availability**: Service continues even if one server goes down
- **Read Scalability**: Read operations can be distributed across multiple replicas
- **Geographic Distribution**: Data can be closer to users in different regions, reducing latency

**Common patterns:**
- **Master-Slave Replication**: One primary for writes, multiple replicas for reads
- **Master-Master Replication**: Multiple nodes can accept writes
- **Synchronous Replication**: Writes confirmed only after all replicas are updated (slower but more consistent)
- **Asynchronous Replication**: Writes confirmed immediately, replicas updated later (faster but may lag)

---

### **Sharding**
The technique of horizontally partitioning data across multiple databases or servers, where each shard contains a subset of the total data.

**How it works:**
- Data is split based on a **shard key** (e.g., user ID, geographic region, date range)
- Each shard operates independently and holds only a portion of the dataset
- Application logic routes requests to the appropriate shard

**Key benefits:**
- **Horizontal Scalability**: Distributes data and load across multiple machines
- **Performance**: Smaller datasets per shard means faster queries
- **Storage Capacity**: Overcomes single-server storage limitations
- **Parallel Processing**: Operations can run simultaneously across shards

**Sharding strategies:**
- **Range-based**: Data divided by ranges (e.g., users A-M on shard1, N-Z on shard2)
- **Hash-based**: Hash function determines which shard stores the data
- **Geographic**: Data partitioned by location (e.g., US users, EU users)
- **Directory-based**: Lookup table maps data to shards

**Challenges:**
- Complex queries across multiple shards
- Rebalancing when adding/removing shards
- Maintaining data consistency across shards
- Choosing the right shard key is critical

---

### **Replication vs. Sharding**

| Aspect | Replication | Sharding |
|--------|-------------|----------|
| **Purpose** | Redundancy & fault tolerance | Scale storage & processing capacity |
| **Data** | Full copies on each server | Different subsets on each server |
| **Reads** | Can be distributed | Must route to correct shard |
| **Writes** | All replicas get same data | Each shard gets different data |
| **When to use** | Need high availability & read scaling | Dataset too large for one server |

**Often used together**: Many systems use both—sharding to distribute data, and replication within each shard for fault tolerance.
