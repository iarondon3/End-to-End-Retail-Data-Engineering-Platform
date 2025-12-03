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

Filtering Sales by Customer (id_cliente).

Joining Sales Details by Sale ID (id_venta).

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
   - Latency Reduction: Dropped from 0.567 ms to 0.160 ms (72% improvement).
   - Scalability: By removing the Sequential Scans, the query complexity dropped from Linear O(N) to Logarithmic O(log N), ensuring stability even if the database grows to millions of rows.
