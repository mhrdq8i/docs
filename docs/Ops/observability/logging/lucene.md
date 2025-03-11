# Apache Lucene

## **What is Apache Lucene?**

- **Definition**: Lucene is a high-performance, full-text search library written in Java.
- **Role in Elasticsearch**:
  - Each **shard** in Elasticsearch is essentially a **Lucene index**.
  - Elasticsearch uses Lucene for storing, indexing, and searching data.

## **Core Concepts of Lucene**

### **1. Documents**

- A **document** in Lucene is a collection of **fields** (key-value pairs).
- Example:

  ```json
  {
    "id": "1",
    "title": "Elasticsearch Basics",
    "content": "A distributed search engine."
  }
  ```

  - `id`, `title`, and `content` are fields.
  - Fields can be stored or indexed (or both).

### **2. Fields**

- Fields have two main properties.
    - **Stored**: Whether the field’s value is stored for retrieval (e.g., to display in search results).
    - **Indexed**: Whether the field’s value is indexed for searching.

- Field types:
    - **Text**: Analyzed for full-text search (e.g., `"content"`).
    - **Keyword**: Not analyzed, used for exact matches (e.g., `"id"`).

### **3. Inverted Index**

- The **inverted index** is Lucene’s core data structure for fast text search.
- It maps **terms** (tokens) to the **documents** that contain them.

- Example:

    | Term          | Document IDs |
    | ------------- | ------------ |
    | elasticsearch | [1, 2]       |
    | basics        | [1]          |
    | distributed   | [1]          |

- **How it works**:
    - At **index time**, Lucene tokenizes text fields and builds the inverted index.
    - At **search time**, Lucene looks up terms in the inverted index to find matching documents.

### **4. Segments**

- A Lucene index is divided into **segments** (immutable files on disk).

- **Why segments matter**:
    - Each segment is a mini-index containing a subset of the data.
    - Segments improve performance by allowing parallel processing during searches.
    - New documents are added to new segments; old segments remain unchanged (immutable).

- **Segment Lifecycle**:
    1. **Create**: New segments are created when data is flushed from memory to disk.
    2. **Merge**: Smaller segments are periodically merged into larger ones to optimize performance.
    3. **Delete**: Deleted documents are marked in the segment but not physically removed until a merge occurs.

### **5. Tokenization**

- Tokenization splits text into **tokens** (words/terms) for indexing.
- Example:

    - Input: `"The quick brown fox jumps over the lazy dog."`
    - Tokens: `["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"]`

- **Customization**:
  - Use different tokenizers (e.g., `standard`, `whitespace`, `ngram`) to control how text is split.

### **6. Scoring**

- Lucene assigns a **relevance score** to each document based on how well it matches the query.
- Scoring is based on:
    - **TF-IDF (Term Frequency-Inverse Document Frequency)**:
        - Measures how important a term is in a document relative to the entire corpus.
    - **BM25** (default in Elasticsearch):
        - A modern scoring algorithm that improves relevance for long documents.

- Example:
    - Query: `"elasticsearch"`
    - Documents with more mentions of `"elasticsearch"` will score higher.

## **Lucene Internals**

### **1. Index Structure**

- A Lucene index consists of:
    - **Segments**: Immutable files containing subsets of the data.
    - **Commit Points**: Metadata about which segments belong to the index.
    - **Transaction Log (Translog)**: Ensures durability by logging changes before they’re flushed to disk.

### **2. Write Process**

- When you index a document:
    1. Data is written to the **transaction log** (for durability).
    2. Data is buffered in memory.
    3. Periodically, the buffer is flushed to disk as a new **segment**.

### **3. Read Process**

- When you search:
    1. Lucene queries all relevant segments.
    2. Results from each segment are merged and ranked.
    3. The top results are returned to the user.

## **Performance Optimization in Lucene**

### **1. Segment Merging**

- Smaller segments are periodically merged into larger ones to:
    - Reduce the number of files on disk.
    - Improve search performance (fewer segments = fewer lookups).
- Controlled by the **merge policy** (e.g., `TieredMergePolicy`).

### **2. Caching**

- Lucene uses caches to speed up searches:
    - **Query Cache**: Caches frequently executed queries.
    - **Field Cache**: Caches field values for sorting and aggregations.

### **3. Deletes**

- Deleted documents are marked in the segment but not physically removed until a merge occurs.
- This ensures deletes are fast but requires periodic cleanup.

## **Lucene vs. Elasticsearch**

| **Feature**            | **Lucene**               | **Elasticsearch**                         |
| ---------------------- | ------------------------ | ----------------------------------------- |
| **Scope**              | Low-level search library | Distributed search and analytics engine   |
| **Sharding**           | Single index             | Splits indices into shards across nodes   |
| **Replication**        | No built-in replication  | Handles replication for high availability |
| **REST API**           | None                     | Provides REST APIs for easy interaction   |
| **Cluster Management** | None                     | Manages nodes, shards, and cluster health |

### **Key Takeaways**

- Lucene is the foundation of Elasticsearch’s search capabilities.
- Understanding Lucene helps you optimize indexing and search performance.
- Key concepts include **documents**, **fields**, **inverted index**, **segments**, and **scoring**.
