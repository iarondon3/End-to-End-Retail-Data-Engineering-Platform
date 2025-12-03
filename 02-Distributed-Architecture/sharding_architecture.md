# 🌐 Distributed Sharding Showcase

## Scenario: Scaling for High Throughput
**The Problem:** The single-node database was becoming a bottleneck. Writing thousands of transactions per second from 100+ stores caused lock contention and slow response times. Vertical scaling (adding more RAM/CPU) was no longer cost-effective.

---

### 1. The Strategy: Horizontal Sharding
We moved to a **Shared-Nothing Architecture** using the Citus extension for PostgreSQL. The critical decision was choosing the **Shard Key**.

* **Selected Key:** `id_sucursal` (Branch ID).
* **Rationale:** Most queries are local to a specific store (e.g., "Show me sales for Store #5"). By sharding by Store ID, we route queries to a single node, minimizing network overhead.

### 2. Implementation Code
Converting standard tables into distributed tables required defining the distribution column.

```sql
-- 1. Enable the Citus Extension
CREATE EXTENSION citus;

-- 2. Distribute the 'Venta' (Sales) table by 'id_sucursal'
-- This physically moves data from the Coordinator node to Worker nodes.
SELECT create_distributed_table('Venta', 'id_sucursal');

-- 3. Co-locate related tables (Details) to allow local joins
-- This ensures that sale details live on the same node as the sale header.
SELECT create_distributed_table('Detalle_Venta', 'id_sucursal', colocate_with => 'Venta');
