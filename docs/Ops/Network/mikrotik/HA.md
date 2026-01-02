# HA

Mikrotik hAP ax Lite - Dual WAN Active-Passive Failover Configuration

## Project Overview

**Objective:** Configure a Mikrotik hAP ax Lite router to support two internet connections (Fiber and Ztel) with automatic failover in active-passive mode.

**Device:** Mikrotik hAP ax Lite (RouterOS 7.7)
**Hardware:** 2.4GHz WiFi 6 radio only (AX600)

## Network Architecture

```bash
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                     DUAL WAN SETUP                              │
│                                                                 │
│  Fiber Modem (192.168.100.0/24)    Ztel Modem (192.168.0.0/24)  │
│         │                                    │                  │
│    [Ethernet Cable]                   [WiFi 2.4GHz]             │
│         │                                    │                  │
│         └────────────┬───────────────────────┘                  │
│                      │                                          │
│         ╔════════════▼════════════════╗                         │
│         ║  hAP ax Lite Router         ║                         │
│         ║                             ║                         │
│         ║  • ether1: Fiber WAN        ║                         │
│         ║  • wifi1: Ztel WAN          ║                         │
│         ║  • wlan-ap-24: WiFi AP      ║                         │
│         ║  • bridge-local: Client LAN ║                         │
│         ║  • Gateway: 192.168.8.1     ║                         │
│         ╚════════════╤════════════════╝                         │
│                      │                                          │
│        ┌─────────────┼─────────────┐                            │
│        │             │             │                            │
│   ether2-4       wifi 2.4GHz    bridge-local                    │
│  (Wired LAN)    (Wireless AP)    (DHCP Server)                  │
│  192.168.8.x    192.168.8.x      192.168.8.10-254               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Step-by-Step Configuration

### STEP 1: Configure wifi1 as Station (Ztel Connection)

**Purpose:** Connect hAP ax Lite to Ztel modem wirelessly

**Path:** Interfaces → Wireless → wifi1

**Configuration:**

- **Band:** 2GHz-ax
- **Mode:** station
- **SSID:** Ztel-2.4GHz (your Ztel modem WiFi name)
- **Security:** WPA2 PSK
- **WPA2 Pre-Shared Key:** [your-ztel-password]
- **Country:** Iran
- **Transmit Power:** 20
- **Disabled:** NO

**Result:** wifi1 connects to Ztel modem and gets IP via DHCP

---

### STEP 2: Add DHCP Client for wifi1 (Ztel)

**Path:** IP → DHCP Client → Add New

**Configuration:**

- **Interface:** wifi1
- **Use Peer NTP:** NO

**Result:** wifi1 receives IP address from Ztel modem (192.168.0.x range)

---

### STEP 3: Add DHCP Client for ether1 (Fiber)

**Path:** IP → DHCP Client → Add New

**Configuration:**

- **Interface:** ether1
- **Use Peer NTP:** NO

**Result:** ether1 receives IP address from Fiber modem (192.168.100.x range)

---

### STEP 4: Physical Connection & Verification

**Physical Setup:**

1. Plug Fiber modem cable into **ether1** on hAP ax Lite
2. Verify both connections:
   - Go to **IP** → **Addresses**
   - Should see:
     - wifi1: 192.168.0.174/24 (Ztel) ✓
     - ether1: 192.168.100.45/24 (Fiber) ✓

---

### STEP 5: Create Virtual AP for Wireless Clients

**Purpose:** Allow clients to connect wirelessly to hAP ax Lite

**Path:** Interfaces → Wireless → Add New

**Configuration:**

- **Name:** wlan-ap-24
- **Band:** 2GHz-ax
- **Mode:** ap-bridge
- **SSID:** Home-2.4GHz
- **Security:** WPA2 PSK
- **WPA2 Pre-Shared Key:** client-password (your choice)
- **Country:** Iran
- **Disabled:** NO

**Result:** Virtual AP created on same 2.4GHz radio as wifi1 (station)

---

### STEP 6: Create Bridge for Local Network

**Purpose:** Bridge all client ports together

**Path:** Interfaces → Bridges → Add New

**Configuration:**

- **Name:** bridge-local
- **Protocol Mode:** rstp
- **Disabled:** NO

**Result:** Bridge created for LAN clients

---

### STEP 7-8: Add Bridge Ports

**Purpose:** Connect wired and wireless clients to bridge

**Path:** Bridges → Ports (in Bridge menu on left sidebar)

**Add These Ports:**

1. **ether2 → bridge-local** (wired client)
2. **ether3 → bridge-local** (wired client)
3. **ether4 → bridge-local** (wired client)
4. **wlan-ap-24 → bridge-local** (wireless clients)

**Important:** DO NOT add ether1 or wifi1 to bridge (they are WAN!)

---

### STEP 9: Assign IP to Bridge (Client Gateway)

**Path:** IP → Addresses → Add New

**Configuration:**

- **Address:** 192.168.8.1/24
- **Interface:** bridge-local

**Result:** bridge-local becomes gateway for all clients

---

### STEP 10: Create IP Pool for DHCP

**Path:** IP → Pool → Add New

**Configuration:**

- **Name:** pool-clients
- **Addresses:** 192.168.8.10-192.168.8.254

**Result:** DHCP pool defined

---

### STEP 11: Create DHCP Server

**Path:** IP → DHCP Server → Add New

**Configuration:**

- **Name:** dhcp-local
- **Interface:** bridge-local
- **Address Pool:** pool-clients
- **Disabled:** NO

**Result:** DHCP server created

---

### STEP 12: Configure DHCP Network

**Path:** IP → DHCP Server → Networks tab → Add New

**Configuration:**

- **Address:** 192.168.8.0/24
- **Gateway:** 192.168.8.1
- **DNS Servers:** 8.8.8.8, 1.1.1.1

**Result:** DHCP network configured

---

### STEP 13: Add Primary Route (Fiber - Active)

**Path:** IP → Routes → Add New

**Configuration:**

- **Dst. Address:** 0.0.0.0/0
- **Gateway:** 192.168.100.1 (Fiber modem gateway)
- **Distance:** 1 (PRIMARY)
- **Check Gateway:** ping

**Result:** Primary route to Fiber created

---

### STEP 14: Add Secondary Route (Ztel - Failover)

**Path:** IP → Routes → Add New

**Configuration:**

- **Dst. Address:** 0.0.0.0/0
- **Gateway:** 192.168.0.1 (Ztel modem gateway)
- **Distance:** 2 (SECONDARY)
- **Check Gateway:** ping

**Result:** Secondary failover route to Ztel created

---

### STEP 15: Configure Health Monitoring (Netwatch)

**Path:** Tools → Netwatch

**Monitor 1 - Fiber Gateway:**

- **Host:** 192.168.100.1
- **Type:** icmp
- **Timeout:** 5s
- **Up Script:** `:log info "Fiber online"`
- **Down Script:** `:log warning "Fiber down, switching to Ztel"`

**Monitor 2 - Ztel Gateway:**

- **Host:** 192.168.0.1
- **Type:** icmp
- **Timeout:** 5s
- **Up Script:** `:log info "Ztel online"`
- **Down Script:** `:log warning "Ztel down"`

**Result:** Gateway health monitoring configured

---

### STEP 16: Configure NAT Rule 1 (Fiber)

**Path:** IP → Firewall → NAT → Add New

**Configuration:**

- **Chain:** srcnat
- **Out. Interface:** ether1
- **Action:** masquerade
- **Comment:** NAT Fiber WAN

**Result:** Clients can access internet via Fiber

---

### STEP 17: Configure NAT Rule 2 (Ztel)

**Path:** IP → Firewall → NAT → Add New

**Configuration:**

- **Chain:** srcnat
- **Out. Interface:** wifi1
- **Action:** masquerade
- **Comment:** NAT Ztel WAN

**Result:** Clients can access internet via Ztel

---

### STEP 18: Configure Firewall Input Rule

**Path:** IP → Firewall → Filter

**Rule 0 - INPUT chain:**

- **Chain:** input
- **Connection State:** Check `established`, `related`, `untracked`, `new`
- **Action:** accept
- **Comment:** Allow input

**Result:** Router can receive packets

---

### STEP 19: Configure Firewall Output Rule

**Path:** IP → Firewall → Filter → Add New

**Rule 1 - OUTPUT chain:**

- **Chain:** output
- **Connection State:** Check `established`, `related`, `untracked`, `new`
- **Action:** accept
- **Comment:** Allow output

**Result:** Router can send packets

---

### STEP 20: Configure Firewall Return Traffic Rules

**CRITICAL:** These rules allow response packets to return from internet to clients

**Path:** IP → Firewall → Filter → Add New

**Rule 2 - ether1 → bridge-local (Fiber return):**

- **Chain:** forward
- **In. Interface:** ether1
- **Out. Interface:** bridge-local
- **Connection State:** Check `established`, `related`, `untracked` (NO new!)
- **Action:** accept
- **Comment:** Allow Fiber return traffic

**Rule 3 - wifi1 → bridge-local (Ztel return):**

- **Chain:** forward
- **In. Interface:** wifi1
- **Out. Interface:** bridge-local
- **Connection State:** Check `established`, `related`, `untracked` (NO new!)
- **Action:** accept
- **Comment:** Allow Ztel return traffic

**Result:** Internet responses can reach clients

---

### STEP 21: Configure Firewall Forward Traffic Rules

**Purpose:** Allow clients to send traffic to internet

**Path:** IP → Firewall → Filter → Add New

**Rule 4 - bridge-local → ether1 (Fiber forward):**

- **Chain:** forward
- **In. Interface:** bridge-local
- **Out. Interface:** ether1
- **Connection State:** Check `new`, `established`, `related`, `untracked`
- **Action:** accept
- **Comment:** Allow to Fiber

**Rule 5 - bridge-local → wifi1 (Ztel forward):**

- **Chain:** forward
- **In. Interface:** bridge-local
- **Out. Interface:** wifi1
- **Connection State:** Check `new`, `established`, `related`, `untracked`
- **Action:** accept
- **Comment:** Allow to Ztel

**Result:** Clients can send packets to internet

---

### STEP 22: Configure DNS

**Path:** IP → DNS

**Configuration:**

- **Servers:** 8.8.8.8, 1.1.1.1
- **Allow Remote Requests:** YES

**Result:** DNS queries work

---

## Testing

### Test 1: Verify WiFi AP is Broadcasting

1. On phone/laptop, scan WiFi networks
2. Look for `Home-2.4GHz` SSID
3. **Expected:** SSID visible ✓

---

### Test 2: Connect Wireless Client

1. Connect to `Home-2.4GHz`
2. Enter password: `client-password`
3. Check IP address: Should be 192.168.8.x
4. **Expected:** Client gets IP from DHCP ✓

---

### Test 3: Test Internet Access (Fiber Primary)

```bash
ping 8.8.8.8
```

**Expected:** Responses from Fiber connection ✓

---

### Test 4: Test Failover (Fiber → Ztel)

1. Client is connected and internet working
2. **Unplug Fiber cable from ether1**
3. Wait 5-10 seconds (netwatch timeout)
4. Try `ping 8.8.8.8` again
5. **Expected:** Internet continues via Ztel ✓

---

### Test 5: Test Failover Recovery (Ztel → Fiber)

1. **Plug Fiber cable back into ether1**
2. Wait 5-10 seconds
3. Verify internet still works
4. **Expected:** Traffic switches back to Fiber ✓

---

### Test 6: Test Wired Client (Optional)

1. Plug ethernet cable into ether2, ether3, or ether4
2. Should receive 192.168.8.x IP from DHCP
3. Internet should work
4. **Expected:** Wired client works ✓

---

## Final Configuration Summary

| Component | Configuration | Status |
|-----------|---------------|--------|
| **WAN - Fiber** | ether1 (DHCP) | 192.168.100.x | ✓ Active |
| **WAN - Ztel** | wifi1 (Station) | 192.168.0.x | ✓ Ready |
| **Wireless AP** | wlan-ap-24 | Home-2.4GHz | ✓ Broadcasting |
| **LAN Bridge** | bridge-local | 192.168.8.1/24 | ✓ Active |
| **DHCP Server** | dhcp-local | 192.168.8.10-254 | ✓ Active |
| **Routing** | Distance 1 (Fiber) | Primary | ✓ Active |
| **Routing** | Distance 2 (Ztel) | Failover | ✓ Ready |
| **Health Check** | Netwatch | Fiber & Ztel | ✓ Monitoring |
| **NAT** | srcnat ether1 | Fiber masquerade | ✓ Active |
| **NAT** | srcnat wifi1 | Ztel masquerade | ✓ Active |
| **Firewall** | Input/Output | Allow all | ✓ Active |
| **Firewall** | Forward rules | Bidirectional | ✓ Active |

---

## Key Lessons Learned

### 1. Firewall Rule Order Matters

- Rules are evaluated **top-to-bottom**
- First matching rule wins
- General rules block specific rules below them

### 2. Return Traffic Must Be Allowed

- Clients need **TWO rules** for each WAN:
  - One for **sending traffic** (client → WAN)
  - One for **receiving responses** (WAN → client)
- Without return rules, traffic gets stuck

### 3. Connection State Is Critical

- **New traffic:** Use `new, established, related, untracked`
- **Return traffic:** Use `established, related, untracked` (NO new!)
- Wrong settings = packets get dropped

### 4. No In. Interface in NAT srcnat

- RouterOS doesn't support In. Interface in srcnat chain
- NAT rules only need Out. Interface

### 5. Don't Bridge WAN Interfaces

- WAN interfaces (ether1, wifi1) should stay independent
- Only LAN ports should be bridged
- Bridging WANs causes conflicts with routing

### 6. Hardware Limitations

- hAP ax Lite has only **2.4GHz** (no 5GHz)
- Must use same radio for station + AP
- Both run simultaneously via virtual interfaces

## Troubleshooting Checklist

- [ ] Both modems have IPs in Addresses list (IP → Addresses)
- [ ] Routes show correct distances (IP → Routes)
- [ ] NAT rules have correct Out. Interface (IP → Firewall → NAT)
- [ ] Firewall rules have correct Chain and Connection State (IP → Firewall → Filter)
- [ ] Bridge ports include wlan-ap-24 (Bridges → Ports)
- [ ] DHCP server is enabled (IP → DHCP Server)
- [ ] wifi1 is in station mode (Interfaces → Wireless)
- [ ] wlan-ap-24 is in ap-bridge mode (Interfaces → Wireless)

## Performance Notes

**Bandwidth Sharing:**

- Both Fiber and Ztel are independent WAN connections
- No bandwidth sharing during normal operation
- Failover is automatic and transparent to clients

**Latency:**

- Primary (Fiber): Direct route via ether1
- Failover (Ztel): Direct route via wifi1
- Both routes are low-latency (same physical location)

**Failover Time:**

- Detection: 5-10 seconds (netwatch timeout)
- Switching: Automatic via distance-based routing
- Client impact: None (connection stays alive during switch)

## Additional Notes

### Why This Architecture Works

1. **Active-Passive:** Fiber is always primary (distance=1), Ztel is standby (distance=2)
2. **Automatic Failover:** When Fiber unreachable, netwatch triggers, routes switch automatically
3. **No Split-Tunneling:** All clients use single gateway (192.168.8.1)
4. **NAT Handles Both WANs:** Each WAN interface has its own masquerade rule
5. **Firewall Protects Both Routes:** Rules allow traffic in both directions

### Future Improvements

- Add redundant AP (second hAP ax Lite) for client coverage
- Configure traffic limiting per client (QoS)
- Add DNS failover (local DNS server)
- Monitor link status with SNMP
- Configure automatic backup via second Fiber modem

## Conclusion

Your Mikrotik hAP ax Lite is now configured for **dual WAN active-passive failover** with:

✓ Two independent internet connections
✓ Automatic failover from Fiber to Ztel
✓ Automatic recovery when Fiber returns
✓ Wireless and wired client support
✓ Full internet access on both WANs

**The system is ready for production use!**

---

*Configuration Date: January 2, 2026*
*RouterOS Version: 7.7 (stable)*
*Device: Mikrotik hAP ax Lite*
