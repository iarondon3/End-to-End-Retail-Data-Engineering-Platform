# 🐘 Big Data & Behavioral Analytics Showcase

## 📉 Scenario: Beyond the Transaction
**The Problem:** Our SQL transactional database recorded sales perfectly, but it was blind to "lost opportunities." We didn't know how many customers were visiting, adding items to carts, and *failing* to buy.

**The Solution:** We ingested massive event logs (Clicks, Carts, Payments) into **Databricks** to analyze the full Customer Journey using Spark SQL.

---

### 1. Diagnostic Analysis: The "Broken Funnel"
We attempted to build a standard conversion funnel to measure the drop-off rate from "Product View" to "Purchase Success".

**The Spark SQL Query:**
We aggregated events from three disparate log tables using `UNION ALL`.

```sql
SELECT '1. Product Views' AS Stage, COUNT(*) AS Value FROM default.flujo_clicks_event
UNION ALL
SELECT '2. Added to Cart', COUNT(*) FROM default.carrito_event_1
UNION ALL
SELECT '3. Payment Attempts', COUNT(*) FROM default.intento_pago_event_1
UNION ALL
SELECT '4. Successful Payments', COUNT(*) FROM default.intento_pago_event_1 WHERE resultado = 'approved'
ORDER BY Stage;
```

**🚨 Critical Discovery:** *The 75% Failure Rate*

The analysis revealed a massive anomaly at the bottom of the funnel.

- Payment Attempts: 150,000
- Successful Payments: 37,293
- Success Rate: Only 24.86%

**Strategic Insight**: 

Three out of four customers who click "Pay" are failing to complete the transaction. This is not a marketing problem; it is a technical or gateway infrastructure failure. Prioritizing this fix is the highest ROI action for the company

### 2. Prescriptive Analysis: Cross-Sell Opportunities
We wanted to move from reporting to recommending. The business question was: "What do customers view but NOT buy when they are buying low-margin staples like Mineral Water?"

**The Spark SQL Query (Anti-Join Pattern):**

We isolated customers who bought Mineral Water and analyzed their viewing history vs. their purchase history.

```sql
WITH Clientes_Producto_Clave AS (
  SELECT DISTINCT cliente_id
  FROM carrito_event_1
  WHERE producto_id = 102 AND accion = 'add' AND cliente_id IS NOT NULL
),
Productos_Vistos_Por_Grupo AS (
  SELECT
    v.cliente_id,
    v.producto_id AS producto_visto_id
  FROM flujo_clicks_event v
    JOIN Clientes_Producto_Clave c 
    ON v.cliente_id = c.cliente_id
  WHERE v.evento = 'product_view' AND v.producto_id != 102 
),
Productos_Agregados_Por_Grupo AS (
  SELECT DISTINCT cliente_id, producto_id AS producto_agregado_id
  FROM carrito_event_1
  WHERE accion = 'add' 
)
SELECT
  p.nombre AS producto_oportunidad,
  COUNT(v.producto_visto_id) AS veces_visto_y_no_comprado
FROM Productos_Vistos_Por_Grupo v
  JOIN producto p 
  ON v.producto_visto_id = p.id_producto
  LEFT JOIN Productos_Agregados_Por_Grupo a 
  ON v.cliente_id = a.cliente_id
  AND v.producto_visto_id = a.producto_agregado_id
WHERE a.producto_agregado_id IS NULL
GROUP BY p.nombre
ORDER BY veces_visto_y_no_comprado DESC
LIMIT 10;
```
**💡 Strategic Insight**

Customers buying Mineral Water frequently viewed Hair Care Ampoules and Pain Relief Medication but didn't add them to the cart.

**Actionable Recommendation:**

- Bundle Strategy: Create a "Wellness Bundle" (Water + Vitamins) or an "Essentials Pack" to capture this high intent.
- UX Optimization: Add a "Customers who bought Water also viewed..." carousel in the checkout flow featuring these specific high-margin items.
