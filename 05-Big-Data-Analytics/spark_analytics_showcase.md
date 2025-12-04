# 🐘 Big Data & Behavioral Analytics Showcase

## 📉 Scenario: Simulating & Diagnosing Scale

**The Context:** To test the architecture's limits, we moved beyond the small operational dataset. Since real-world "Big Data" was unavailable, we needed to simulate a high-volume e-commerce environment.

**The Solution: Synthetic Data Engineering**

We developed a **Python script using the `Faker` library** to generate over **1.1 Million synthetic events** (Clickstream, Cart Interactions, Payment Logs). This allowed us to:
1.  Stress-test the Spark cluster with massive datasets.
2.  Perform complex joins typically required in production environments.
3.  **Audit Data Integrity:** By analyzing these generated logs, we uncovered logic gaps in the simulation, serving as a perfect case study for Data Quality debugging.

---

### 1. Diagnostic Analysis: The "Broken Funnel"
We attempted to build a standard conversion funnel to measure the drop-off rate from "Product View" to "Purchase Success".

**The Spark SQL Query:**
We aggregated events from three disparate log tables using `UNION ALL`.

```sql
WITH exploracion AS (
  SELECT COUNT(*) AS eventos_exploracion
  FROM default.flujo_clicks_event
  WHERE evento = 'product_view'
),
consideracion AS (
  SELECT COUNT(*) AS eventos_carrito
  FROM default.carrito_event_1
  WHERE accion = 'add'
),
intento_pago AS (
  SELECT COUNT(*) AS eventos_pago
  FROM default.intento_pago_event_1
),
compra_exitosa AS (
  SELECT COUNT(*) AS eventos_exitosos
  FROM default.intento_pago_event_1
  WHERE resultado = 'approved'
)
SELECT '1. Vistas de Producto' AS Etapa, eventos_exploracion AS Valor FROM exploracion
UNION ALL
SELECT '2. Agregados al Carrito' AS Etapa, eventos_carrito AS Valor FROM consideracion
UNION ALL
SELECT '3. Intentos de Pago' AS Etapa, eventos_pago AS Valor FROM intento_pago
UNION ALL
SELECT '4. Pagos Exitosos' AS Etapa, eventos_exitosos AS Valor FROM compra_exitosa
ORDER BY Etapa 
```
![Final funnel_chart](./funnel_chart.png)

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
![Final cross_sell_chart](./cross_sell_chart.png)

**💡 Strategic Insight**

Customers buying Mineral Water frequently viewed Hair Care Ampoules and Pain Relief Medication but didn't add them to the cart.

**Actionable Recommendation:**

- Bundle Strategy: Create a "Wellness Bundle" (Water + Vitamins) or an "Essentials Pack" to capture this high intent.
- UX Optimization: Add a "Customers who bought Water also viewed..." carousel in the checkout flow featuring these specific high-margin items.
