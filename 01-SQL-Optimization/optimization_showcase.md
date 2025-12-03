/*
    ============================================================================
    PROJECT: Retail POS Optimization
    UNIT: 01 - SQL Performance Tuning
    DB ENGINE: PostgreSQL
    ============================================================================
*/

-- -----------------------------------------------------------------------------
-- SCENARIO 1: Querying Customer Purchase History (The Bottleneck)
-- Problem: The system was doing a Full Table Scan on the 'Venta' table.
-- -----------------------------------------------------------------------------

-- 1. Original Query (Slow)
EXPLAIN ANALYZE
SELECT * FROM Venta 
WHERE id_cliente = 145 
AND fecha_venta BETWEEN '2024-01-01' AND '2024-12-31';

/*
    Analysis Result (Before):
    - Type: Sequential Scan
    - Execution Time: ~150ms
    - Cost: High CPU usage due to scanning 1M+ rows.
*/


-- 2. Optimization: Creating B-Tree Index
-- Rationale: 'id_cliente' has high cardinality and is used in WHERE clauses frequently.
CREATE INDEX idx_venta_cliente_fecha 
ON Venta (id_cliente, fecha_venta);


-- 3. Optimized Query (Fast)
EXPLAIN ANALYZE
SELECT * FROM Venta 
WHERE id_cliente = 145 
AND fecha_venta BETWEEN '2024-01-01' AND '2024-12-31';

/*
    Analysis Result (After):
    - Type: Index Scan using idx_venta_cliente_fecha
    - Execution Time: ~2ms
    - Improvement: 98% reduction in latency.
*/
