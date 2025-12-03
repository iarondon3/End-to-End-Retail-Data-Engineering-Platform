# ⚡ SQL Optimization Showcase

## 📉 Scenario: Customer 360° Dashboard
**The Problem:** The Marketing team uses a CRM dashboard to view the profitability of specific  customers. As the transaction history grew, loading a single customer's profile caused high latency because the database was performing **Sequential Scans** on both the Sales (`venta`) and Sales Detail (`detalle_venta`) tables.

---

### 1. The Business Query (Slow)
We want to analyze the **Profitability by Category** for a specific customer (`id_cliente = 389`).

```sql
EXPLAIN ANALYZE
SELECT 
    c.nombre || ' ' || c.apellido AS nombre_cliente,
    cat.nombre_categoria,
    COUNT(DISTINCT v.id_venta) AS total_transacciones,
    SUM(dv.cantidad_vendida * p.precio_unitario) AS total_gastado
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto p ON dv.id_producto = p.id_producto
JOIN categoria cat ON p.id_categoria = cat.id_categoria
WHERE v.id_cliente = 389
GROUP BY c.id_cliente, cat.nombre_categoria
ORDER BY total_gastado DESC;
```

🔴 **Execution Plan** *(Before Optimization)*

Key bottlenecks identified: Seq Scan on detalle_venta and Seq Scan on venta.

| EXPLIAN ANALYZED | 
| ------------- | 
       Sort  (cost=95.89..95.91 rows=6 width=112)
        Sort Key: (sum(((dv.cantidad_vendida)::numeric * (p.precio_unitario)::numeric))) DESC
        ->  GroupAggregate  (cost=95.62..95.81 rows=6 width=112)
              ->  Nested Loop  (cost=24.08..95.54 rows=6 width=72)
                    ->  Hash Join  (cost=23.52..84.96 rows=6 width=28)
                          Hash Cond: (dv.id_venta = v.id_venta)
                          ->  Seq Scan on detalle_venta dv  (...)
                          ->  Hash
                                ->  Seq Scan on venta v  (...)
                                      Filter: (id_cliente = 389)
      Planning Time: 1.346 ms
      Execution Time: 0.567 ms 


### 2. The Solution: Indexing Foreign Keys
We identified two missing indexes critical for filtering and joining:

 - Filtering Sales by Customer (id_cliente).
 - Joining Sales Details by Sale ID (id_venta).

```sql
-- Index 1: To quickly find sales for a specific customer
CREATE INDEX idx_venta_cliente ON venta (id_cliente);

-- Index 2: To quickly join details without scanning the whole table
CREATE INDEX idx_id_venta_detventa ON detalle_venta (id_venta);
```

### 3. Optimized Query Results
After applying the indexes, we executed the exact same query.

🟢 **Execution Plan** *(After Optimization)*

The engine switched to Bitmap Index Scan and Index Scan, eliminating the full table reads.

| EXPLIAN ANALYZED | 
| ------------- | 
      Sort  (cost=37.37..37.39 rows=6 width=112)
        Sort Key: (sum(((dv.cantidad_vendida)::numeric * (p.precio_unitario)::numeric))) DESC
        ->  GroupAggregate  (cost=37.10..37.29 rows=6 width=112)
              ->  Nested Loop  (cost=5.12..37.02 rows=6 width=72)
                    ->  Nested Loop  (cost=4.56..18.07 rows=2 width=30)
                          ->  Index Scan using cliente_pkey on cliente c
                                Index Cond: (id_cliente = 389)
                          ->  Bitmap Heap Scan on venta v
                                Recheck Cond: (id_cliente = 389)
                                ->  Bitmap Index Scan on idx_venta_cliente
                                      Index Cond: (id_cliente = 389)
                    ->  Index Scan using idx_id_venta_detventa on detalle_venta dv
                          Index Cond: (id_venta = v.id_venta)
      Planning Time: 0.446 ms
      Execution Time: 0.160 ms

### 🚀 Performance Impact
The results from the `EXPLAIN ANALYZE` output confirm the effectiveness of the indexing strategy, even on a smaller staging dataset.

* **Latency Reduction:** Execution time dropped from **0.567 ms** to **0.160 ms**, representing a **72% improvement** in speed.
* **Optimizer Efficiency:** The PostgreSQL query planner **naturally preferred** the Index Scan over the Sequential Scan without requiring forced hints (`enable_seqscan=off`). This indicates that the index correctly drastically reduced the cost of retrieval.
* **Scalability:** The execution plan shifted from linear complexity **O(N)** (reading all rows) to logarithmic complexity **O(log N)** (tree traversal). This ensures that even as the database grows to millions of rows, the lookup for a specific customer will remain virtually instantaneous.

### 🏁 Conclusion
By analyzing the query execution plan, we identified that joining transactional tables (`venta`, `detalle_venta`) was the primary bottleneck due to repeated full table scans. 

Implementing targeted B-Tree indexes on the foreign keys (`id_cliente` and `id_venta`) allowed the database engine to perform precise **Bitmap Index Scans** and **Index Scans**, eliminating unnecessary I/O overhead. This optimization is critical for the scalability of the Customer 360° Dashboard.
