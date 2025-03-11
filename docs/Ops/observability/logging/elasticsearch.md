# Elasticsearch

## Definitions

### **1. What is Elasticsearch?**

- A **distributed search and analytics engine** built on Apache Lucene.
- Designed for **full-text search**, **structured search**, **analytics**, and **real-time data operations**.
- Scales horizontally (add more servers) to handle petabytes of data.
- Uses **REST APIs** for all operations (no SQL, but a JSON-based query language called **Query DSL**).

**Common Use Cases**:

- Log analysis (e.g., ELK Stack: Elasticsearch, Logstash, Kibana).
- E-commerce product search.
- Real-time application monitoring.
- Business analytics (e.g., aggregating sales data).

---

### **2. Core Concepts**

Let’s break down the jargon:

#### **Cluster & Nodes**

- **Cluster**: A group of **nodes** (servers) working together.
- **Node**: A single server in the cluster. Each node has a role (e.g., data storage, ingest processing).

#### **Indices & Documents**

- **Index**: Like a "database" in SQL. Stores a collection of **documents** (JSON objects).
  - Example: A `blog` index with `posts` and `comments`.
- **Document**: A JSON object (e.g., `{"title": "Elasticsearch 101", "author": "Alice"}`).
- **Shards**: Split indices into smaller pieces for scalability. Each shard is a Lucene index.
- **Replicas**: Copies of shards for high availability and performance.

#### **Mapping & Schema**

- **Mapping**: Defines the schema of an index (data types, analyzers).
  - Example: `"title"` field as `text` (for full-text search) and `"price"` as `integer`.

---

### **3. Basic Operations**

Let’s get hands-on! First, install Elasticsearch and Kibana (its UI tool).

#### **Install Elasticsearch**

- **Docker** (simplest):

  ```bash
  docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:8.14.1
  ```

- Access: `http://localhost:9200` (check if it’s running).

#### **Basic Commands**

1. **Create an Index**:

   ```bash
   PUT http://localhost:9200/my_index
   {
     "settings": {
       "number_of_shards": 1,
       "number_of_replicas": 1
     },
     "mappings": {
       "properties": {
         "title": { "type": "text" },
         "price": { "type": "integer" }
       }
     }
   }
   ```

2. **Index a Document**:

   ```bash
   POST http://localhost:9200/my_index/_doc/1
   {
     "title": "Elasticsearch Basics",
     "price": 29
   }
   ```

3. **Search**:

   ```bash
   GET http://localhost:9200/my_index/_search
   {
     "query": {
       "match_all": {}
     }
   }
   ```

---

### **4. Querying with Query DSL**

Elasticsearch uses a **JSON-based query language**. Let’s start simple:

#### **Basic Queries**

- **Match All**:

  ```json
  { "query": { "match_all": {} } }
  ```

- **Term Query** (exact match):

  ```json
  { "query": { "term": { "price": 29 } } }
  ```

- **Range Query**:

  ```json
  {
    "query": {
      "range": {
        "price": { "gte": 20, "lte": 30 }
      }
    }
  }
  ```

#### **Full-Text Search**

- **Match Query** (analyzed search):

  ```json
  {
    "query": {
      "match": {
        "title": "Elasticsearch Basics"
      }
    }
  }
  ```

---

### **5. Aggregations**

Aggregations let you calculate metrics (e.g., averages, sums) or group data.

#### **Example: Average Price**

```json
{
  "aggs": {
    "avg_price": {
      "avg": { "field": "price" }
    }
  }
}
```

#### **Group by Category**

```json
{
  "aggs": {
    "categories": {
      "terms": { "field": "category.keyword" }
    }
  }
}
```

### **6. Advanced Topics**

Once you’re comfortable with basics, dive into:

- **Mappings**: Custom analyzers, dynamic templates.
- **Text Analysis**: How Elasticsearch processes text (tokenization, stemming).
- **Performance Tuning**: Shard sizing, caching, query optimization.
- **Security**: User authentication, encryption.
- **Integration**: Logstash (data ingestion), Kibana (visualization).

Great question! **Shards** and **replicas** are fundamental to Elasticsearch’s scalability and reliability, but they serve very different purposes. Let’s break it down:

## **Shards** and **Replicas**

### 1. Shards

- **What**: Split an index into smaller, manageable pieces called **shards**.
- **Why**:
  - **Scalability**: Distribute data across multiple nodes (servers) to handle large datasets.
  - **Performance**: Parallelize read/write operations (e.g., searching across shards simultaneously).
- **Key Points**:
  - **Fixed at creation**: You decide the number of **primary shards** when creating an index (default: 1). You can’t change this later!
  - **Each shard is a Lucene index**: Elasticsearch uses Lucene under the hood, and each shard is a full Lucene index.
  - **Example**: An index with 3 primary shards splits data into 3 parts.

### 2. Replicas

- **What**: Copies of primary shards (exact duplicates).
- **Why**:
  - **High Availability**: If a node fails, replicas ensure data isn’t lost.
  - **Read Scalability**: Serve read requests (e.g., searches) alongside primary shards.
- **Key Points**:
  - **Adjustable**: You can increase/decrease the number of replicas anytime.
  - **Each replica is a copy of a primary shard**: For example, 2 replicas for a 3-shard index means 3 primary + 3 replica shards (total 6).
  - **Replicas are never stored on the same node as their primary shard** (to avoid single points of failure).

### Key Differences

| **Feature**        | **Shards**                               | **Replicas**                             |
| ------------------ | ---------------------------------------- | ---------------------------------------- |
| **Purpose**        | Split data for scalability/performance   | Redundancy and read scalability          |
| **Creation**       | Fixed at index creation                  | Adjustable anytime                       |
| **Data Role**      | Primary (write + read)                   | Copy of primary (read-only until needed) |
| **Failure Impact** | Data loss if shard is lost (no replicas) | No data loss (replicas take over)        |

### Example

- **Index Settings**:

  ```json
  {
    "settings": {
      "number_of_shards": 3,
      "number_of_replicas": 2
    }
  }
  ```

- **Result**:
  - 3 primary shards (split your data into 3 parts).
  - Each primary shard has 2 replicas (total 3 × 2 = 6 replica shards).
  - Total shards: 3 primary + 6 replicas = 9 shards.

### How They Work Together

1. **Writes**:
   - Data is written to the **primary shard** first, then replicated to its **replicas**.
2. **Reads**:
   - Both primary and replica shards can handle read requests (load balancing).
3. **Failure**:
   - If a node holding a primary shard dies, a replica is promoted to primary, ensuring no downtime.

### When to Use Them

- **Shards**:
  - Plan based on data size and future growth (e.g., 10M documents might need 2–3 shards).
  - Too many shards can hurt performance (overhead of managing many Lucene indices).
- **Replicas**:
  - Start with `number_of_replicas: 1` for high availability.
  - Increase replicas to boost read throughput (e.g., for heavy search traffic).

### Common Pitfalls

- **Over-sharding**: Too many small shards waste resources. Aim for shards of **10–50GB** each.
- **No replicas**: Risk data loss if a node fails (always use at least 1 replica in production).

## **Data Workflow on IndexTime**

When you index data into Elasticsearch, it goes through a series of steps to ensure it’s stored, processed, and made searchable. Here’s a detailed breakdown of the flow and the "jobs" Elasticsearch performs:

### **1. Data Ingestion**

- **Step 1: Receive the Document**
  You send a document to Elasticsearch via the **Index API** (e.g., `POST /my_index/_doc/1 { ... }`).

  - Elasticsearch checks if the index exists. If not, it creates it dynamically (unless dynamic mapping is disabled).

- **Step 2: Routing**
  - The document is routed to a **specific shard** based on:
    - The `_routing` value (defaults to the document’s `_id`).
    - Formula: `shard = hash(_routing) % number_of_primary_shards`.

### **2. Indexing Process**

- **Step 3: Primary Shard Processing**
  - The document is sent to the **primary shard** responsible for that data.
  - Elasticsearch performs **analysis** (if the field is `text` type) to convert raw text into tokens for searchability.

### **3. Analysis (Text Processing)**

- **Step 4: Text Analysis**
  For `text` fields, Elasticsearch applies the **analyzer** defined in the mapping. Example steps:

  1. **Character Filters**: Remove HTML tags, replace characters.
  2. **Tokenizer**: Split text into tokens (e.g., `["Hello", "World"]`).
  3. **Token Filters**: Lowercase, remove stop words, stem words, etc.

  Example:

  ```json
  "message": "The QUICK brown FOX!"
  ```

  After analysis (using `standard` analyzer):

  ```json
  ["the", "quick", "brown", "fox"]
  ```

### **4. Storage in Lucene**

- **Step 5: Write to Lucene Index**
  - Each shard is a **Lucene index** (a low-level search engine).
  - Data is written to a **transaction log** (for durability) and a **memory buffer**.
  - Periodically, Elasticsearch **flushes** data from memory to disk as **segments** (immutable files).

### **5. Replication**

- **Step 6: Replica Shards**
  - After the primary shard commits the data, it replicates the operation to **replica shards**.
  - Replicas ensure **high availability** and improve read performance.

### **6. Refresh and Flush**

- **Step 7: Refresh (Make Searchable)**

  - By default, Elasticsearch **refreshes** indices every 1 second:
    - Creates a new segment (making new data searchable).
    - This is why Elasticsearch is "near real-time" (not immediate).

- **Step 8: Flush (Persist to Disk)**
  - Periodically, Elasticsearch **flushes** data from memory to disk:
    - Writes the transaction log to disk.
    - Clears the transaction log (to avoid infinite growth).

### **7. Search Process**

- **Step 9: Query Execution**
  When you search:
  1. The query is sent to **all relevant shards** (primary or replica).
  2. Each shard:
     - Applies the same analyzer to the search terms.
     - Searches its Lucene index for matches.
  3. Results are aggregated and returned to the user.

### **8. Background Jobs**

Elasticsearch continuously performs maintenance tasks:

- **Segment Merging**: Combines smaller segments into larger ones to improve performance.
- **Shard Balancing**: Moves shards between nodes to ensure even resource usage.
- **Garbage Collection**: Cleans up deleted documents (marked as deleted but not physically removed until segments are merged).

### **9. Cluster Coordination**

- **Master Node**: Manages cluster metadata (e.g., index mappings, shard locations).
- **Data Nodes**: Store and process data.
- **Ingest Nodes**: Preprocess data (e.g., via pipelines).

### **10. Monitoring and Maintenance**

- **Health Checks**: Tracks shard allocation, disk space, and node availability.
- **Snapshot Backups**: Periodically backs up indices to a repository (e.g., S3).

### **Example Flow**

1. You index a document:

   ```bash
   POST /blog/_doc/1
   { "title": "Elasticsearch Rocks!", "content": "It’s fast and scalable." }
   ```

2. Elasticsearch:
   - Routes the document to the correct shard.
   - Analyzes the `title` and `content` fields.
   - Writes the data to the primary shard’s transaction log.
   - Replicates the data to replica shards.
   - Refreshes the index to make the document searchable.

### **Key Takeaways**

- **Speed**: Data is searchable in ~1 second (due to refresh).
- **Durability**: Writes are stored in a transaction log before memory.
- **Scalability**: Sharding and replication enable horizontal scaling.
- **Flexibility**: Custom analyzers let you control text processing.

## Analysis (Text Processing)

### **What is Text Analysis?**

Text analysis is the process of breaking down raw text (e.g., `"The quick brown FOX!"`) into **tokens** (words/terms) and **normalizing** them for efficient storage and search. This happens **at index time** (when data is stored) and **at search time** (when queries are processed).

### **The Three Stages of Analysis**

Elasticsearch’s analysis pipeline has three components:

#### **1. Character Filters**

- **Role**: Preprocess the raw text **before tokenization**.
- **Examples**:
  - `html_strip`: Removes HTML tags (e.g., `<b>Hello</b>` → `Hello`).
  - `mapping`: Replaces characters (e.g., replace `ß` with `ss`).
  - `pattern_replace`: Use regex to replace characters (e.g., strip emojis).
- **Example**:

  ```json
  "char_filter": {
    "html_strip": {
      "type": "html_strip"
    }
  }
  ```

#### **2. Tokenizer**

- **Role**: Split text into **tokens** (words, numbers, symbols).
- **Common Tokenizers**:
  - `standard`: Splits on word boundaries (default).
  - `whitespace`: Splits on spaces only.
  - `keyword`: No splitting (entire text as one token).
  - `ngram`/`edge_ngram`: Splits into substrings for autocomplete (e.g., `"quick"` → `["q", "qu", "qui", ...]`).
  - `pattern`: Splits using regex (e.g., split on hyphens).
- **Example**:

  ```json
  "tokenizer": {
    "my_tokenizer": {
      "type": "ngram",
      "min_gram": 2,
      "max_gram": 3
    }
  }
  ```

#### **3. Token Filters**

- **Role**: Modify tokens **after tokenization**.
- **Common Filters**:
  - `lowercase`: Converts tokens to lowercase (`"FOO"` → `"foo"`).
  - `stop`: Removes stop words (e.g., `"the"`, `"and"`).
  - `stemmer`: Reduces words to their root form (`"running"` → `"run"`).
  - `synonym`: Adds synonyms (e.g., `"couch"` → `["couch", "sofa"]`).
  - `asciifolding`: Converts non-ASCII characters to ASCII (e.g., `"café"` → `"cafe"`).
- **Example**:

  ```json
  "filter": {
    "english_stop": {
      "type": "stop",
      "stopwords": "_english_"
    }
  }
  ```

### How Analysis Works in Practice

Let’s analyze the text `"The QUICK brown FOX! <b>Jumps</b>"` with a **custom analyzer**:

```json
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "type": "custom",
          "char_filter": ["html_strip"],
          "tokenizer": "standard",
          "filter": ["lowercase", "english_stop", "porter_stem"]
        }
      }
    }
  }
}
```

#### **Step-by-Step Breakdown**

1. **Character Filter** (`html_strip`):
   Input: `"The QUICK brown FOX! <b>Jumps</b>"`
   Output: `"The QUICK brown FOX! Jumps"`

2. **Tokenizer** (`standard`):
   Splits into tokens: `["The", "QUICK", "brown", "FOX", "Jumps"]`

3. **Token Filters**:
   - `lowercase`: `["the", "quick", "brown", "fox", "jumps"]`
   - `english_stop`: Removes `"the"` → `["quick", "brown", "fox", "jumps"]`
   - `porter_stem`: Stems words → `["quick", "brown", "fox", "jump"]`

**Final Tokens Stored**: `["quick", "brown", "fox", "jump"]`

### Built-in Analyzers

Elasticsearch includes preconfigured analyzers for common use cases:

| Analyzer     | Behavior                                                           |
| ------------ | ------------------------------------------------------------------ |
| `standard`   | Splits on word boundaries, lowercases, removes punctuation.        |
| `simple`     | Splits on non-letters, lowercases.                                 |
| `whitespace` | Splits on whitespace only.                                         |
| `stop`       | Removes stop words (e.g., `"the"`, `"is"`).                        |
| `keyword`    | No tokenization (entire text as one token).                        |
| `pattern`    | Splits using regex (default: `\W+`).                               |
| `language`   | Language-specific (e.g., `english` includes stemming for English). |

### Testing Analysis with `_analyze` API

Use the `_analyze` API to debug how text is processed:

```bash
POST _analyze
{
  "analyzer": "standard",
  "text": "The QUICK brown FOX! Jumps over the lazy dog."
}
```

**Response**:

```json
{
  "tokens": [
    { "token": "the", "position": 0 },
    { "token": "quick", "position": 1 },
    { "token": "brown", "position": 2 },
    { "token": "fox", "position": 3 },
    { "token": "jumps", "position": 4 },
    { "token": "over", "position": 5 },
    { "token": "the", "position": 6 },
    { "token": "lazy", "position": 7 },
    { "token": "dog", "position": 8 }
  ]
}
```

### When to Use Custom Analyzers

- **Autocomplete**: Use `ngram`/`edge_ngram` tokenizers.
- **Synonyms**: Add a `synonym` token filter.
- **Multilingual Support**: Use language-specific analyzers (e.g., `german` for compound words).
- **Special Characters**: Use `pattern_replace` or `asciifolding`.

### **Key Notes**

1. **Analysis at Index Time vs. Search Time**:

   - The same analyzer must be used for both indexing and searching to ensure consistency.
   - **Example:** If you index `"running"` as `"run"`, the search term `"runs"` should also be stemmed to `"run"`.

2. **Keyword vs. Text Fields**:

   - `keyword`: No analysis (exact matches, aggregations).
   - `text`: Full analysis (for full-text search).

3. **Performance**:
   - Complex analyzers (e.g., synonym filters) increase indexing time.
   - Use `keyword` for fields that don’t require search (e.g., IDs).

### Example: Synonym Filter

```json
{
  "settings": {
    "analysis": {
      "filter": {
        "my_synonyms": {
          "type": "synonym",
          "synonyms": ["couch, sofa, lounge", "tv, television"]
        }
      },
      "analyzer": {
        "synonym_analyzer": {
          "tokenizer": "standard",
          "filter": ["lowercase", "my_synonyms"]
        }
      }
    }
  }
}
```

**Test**:

```bash
POST _analyze
{
  "analyzer": "synonym_analyzer",
  "text": "Buy a couch and a TV"
}
```

**Output**:

```json
["buy", "a", "couch", "sofa", "lounge", "and", "a", "tv", "television"]
```

### **Summary**

- **Analysis** is the backbone of Elasticsearch’s search capabilities.
- Choose the right combination of **character filters**, **tokenizers**, and **token filters** for your use case.
- Always test your analyzer with `_analyze` to ensure it behaves as expected.

## Retrieving Relevant Data Quickly (Search Time)

### **Search Time Workflow**

When you send a query to Elasticsearch, it performs the following steps:

### **1. Query Submission**

You send a query via the **Search API** (e.g., `GET /my_index/_search { ... }`).
Example:

```bash
GET /blog/_search
{
  "query": {
    "match": {
      "content": "distributed search"
    }
  }
}
```

### **2. Key Operations at Search Time**

#### **A. Query Parsing**

- Elasticsearch parses the query JSON and determines the type of query (e.g., `match`, `term`, `range`).
- Example: `"match"` queries are analyzed, while `"term"` queries are not.

#### **B. Analysis**

- For `text` fields, Elasticsearch applies the same **analyzer** used during indexing to the query terms.
  - Example:
    - Query: `"distributed search"`
    - After analysis (using `standard` analyzer): `["distributed", "search"]`.
- This ensures consistency between indexed tokens and query terms.

#### **C. Shard Coordination**

- Elasticsearch sends the query to **all relevant shards** (primary or replica) in the index.
- Each shard independently searches its local data and returns results to the coordinating node.

### **3. Searching Lucene Segments**

- Each shard (a Lucene index) searches its **segments**:

  1. **Inverted Index Lookup**:

     - Lucene looks up query terms in the inverted index to find matching documents.
     - Example:
       - Query term: `"distributed"`
       - Inverted index:

         | Term | Document IDs |
         |--------------|--------------|
         | distributed | [1, 2] |
         | search | [1, 3] |

  2. **Combine Results**:
     - Documents matching all terms (`"distributed"` AND `"search"`) are identified.
     - Example: Document `1` matches both terms.

### **4. Scoring**

- Lucene calculates a **relevance score** for each matching document using algorithms like **BM25** (default in Elasticsearch).
- Factors affecting scoring:
    - **Term Frequency (TF)**: How often the term appears in the document.
    - **Inverse Document Frequency (IDF)**: How rare the term is across all documents.
    - **Field Length Norm**: Longer fields reduce relevance (shorter fields are more focused).

- Example:
    - Document `1`: Contains `"distributed"` twice and `"search"` once → High score.
    - Document `2`: Contains `"distributed"` once → Lower score.

### **5. Aggregation (Optional)**

- If your query includes aggregations (e.g., `avg`, `terms`), Elasticsearch computes these metrics across matching documents.
- Example:

  ```json
  {
    "aggs": {
      "avg_views": {
        "avg": { "field": "views" }
      }
    }
  }
  ```

### **6. Result Merging**

- The coordinating node gathers results from all shards, merges them, and ranks them globally by score.
- Pagination is applied if requested (e.g., `from: 0, size: 10`).

### **7. Response**

- Elasticsearch returns the final results to the user:

  ```json
  {
    "took": 5,
    "timed_out": false,
    "hits": {
      "total": {
        "value": 2,
        "relation": "eq"
      },
      "max_score": 1.23,
      "hits": [
        {
          "_index": "blog",
          "_id": "1",
          "_score": 1.23,
          "_source": {
            "title": "Elasticsearch Basics",
            "content": "A distributed search engine."
          }
        },
        {
          "_index": "blog",
          "_id": "2",
          "_score": 0.98,
          "_source": {
            "title": "Advanced Search Techniques",
            "content": "Distributed systems require advanced search."
          }
        }
      ]
    }
  }
  ```

### Key Notes

#### **A. Search Consistency**

- Elasticsearch ensures that the same analyzer is used at **index time** and **search time** for accurate results.
- Example:
    - Indexed text: `"Elasticsearch Rocks!"` → Tokens: `["elasticsearch", "rocks"]`.
    - Query: `"Rocks Elasticsearch"` → Tokens: `["rocks", "elasticsearch"]`.
    - Matches because the tokens are consistent.

#### **B. Performance**

- Searching is optimized for speed:
    - **Segments**: Immutable files allow parallel processing.
    - **Caching**: Frequently executed queries and field values are cached.
    - **Replicas**: Queries can be routed to replica shards to balance load.

#### **C. Relevance Tuning**

- You can customize scoring with:
    - **Boosting**: Increase the importance of certain fields/terms.
    - **Custom Similarity**: Replace BM25 with another scoring algorithm.
    - **Function Score**: Add custom logic (e.g., boost recent documents).

### **Search Time vs. Index Time**

| **Aspect**      | **Index Time**                         | **Search Time**                     |
| --------------- | -------------------------------------- | ----------------------------------- |
| **Purpose**     | Store and process data.                | Retrieve and rank results.          |
| **Analysis**    | Processes text into tokens.            | Processes search terms into tokens. |
| **Performance** | Can be slower due to analysis/storage. | Optimized for fast retrieval.       |
| **Scoring**     | Not applicable.                        | Calculates relevance scores.        |

### **Advanced Search Features**

Elasticsearch provides powerful tools for complex queries:

#### **1. Full-Text Search**

- Use `match`, `multi_match`, or `query_string` for flexible text queries.
- Example:

  ```json
  {
    "query": {
      "match": {
        "content": "distributed search"
      }
    }
  }
  ```

#### **2. Filters**

- Use `term`, `range`, or `bool` filters for exact matches (faster than full-text search).
- Example:

  ```json
  {
    "query": {
      "bool": {
        "filter": [
          { "term": { "status": "published" } },
          { "range": { "views": { "gte": 1000 } } }
        ]
      }
    }
  }
  ```

#### **3. Pagination**

- Use `from` and `size` for paginated results.
- Example:

  ```json
  {
    "from": 10,
    "size": 10
  }
  ```

#### **4. Highlighting**

- Highlight matching terms in the response.
- Example:

  ```json
  {
    "query": {
      "match": {
        "content": "distributed search"
      }
    },
    "highlight": {
      "fields": {
        "content": {}
      }
    }
  }
  ```

---

### Summary

At **search time**, Elasticsearch:

1. Parses and analyzes the query.
2. Searches across shards and segments.
3. Calculates relevance scores using algorithms like BM25.
4. Merges and ranks results globally.
5. Returns the final response to the user.

Understanding this process helps you optimize queries, improve relevance, and troubleshoot performance issues.
