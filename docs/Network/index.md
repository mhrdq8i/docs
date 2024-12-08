
# Network

All things about my network experience like, OSI model, TCP/IP, Switches, Routers, Firewall and other.

## DNS

The Domain Name System (DNS) is the phonebook of the Internet. Humans access information online through domain names, like geekfa.net or espn.com. Web browsers interact through Internet Protocol (IP) addresses. DNS translates domain names to IP addresses so browsers can load Internet resources.

### DNS record

DNS records (aka zone files) are instructions that live in authoritative DNS servers and provide information about a domain including what IP address is associated with that domain and how to handle requests for that domain. These records consist of a series of text files written in what is known as DNS syntax. DNS syntax is just a string of characters used as commands that tell the DNS server what to do. All DNS records also have a ‘TTL’, which stands for time-to-live, and indicates how often a DNS server will refresh that record.

- **A record** - The record that holds the IP address of a domain.
- **AAAA record** - The record that contains the IPv6 address for a domain (as opposed to A records, which list the IPv4 address).
- **CNAME record** - Forwards one domain or subdomain to another domain, does NOT provide an IP address
- **MX record** - Directs mail to an email server.
- **TXT record** - Lets an admin store text notes in the record. These records are often used for email security.
- **NS record** - Stores the name server for a DNS entry.
- **SOA record** - Stores admin information about a domain.
- **SRV record** - Specifies a port for specific services.
- **PTR record** - Provides a domain name in reverse-lookups.
