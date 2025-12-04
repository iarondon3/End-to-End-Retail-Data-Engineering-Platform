# 🍃 NoSQL Modeling & Analytics Showcase

## 📉 Scenario: Customer Behavior Analytics
**The Problem:** Retrieving a customer's full purchase history in the SQL database required joining 5 tables (`Venta`, `Detalle`, `Producto`, `Factura`, `Sucursal`). This was efficient for writing but slow for reading complex profiles.

**The Solution:** We migrated to **MongoDB** using a **Document-Oriented Model**.

---

### 1. Data Modeling: The "Embedding" Strategy
Instead of normalizing data into separate collections, we **embedded** related information directly into the `Sales` document. This allows us to retrieve a complete transaction snapshot in a **single read operation**.

#### ✅ The `Sales` Document Schema
Notice how `Client`, `Branch` (Sucursal), and `Invoice` (Factura) details are embedded within the sale.

```json
{
  "_id": "68eed9d870f4f9352bcef4a6",
  "fecha": "2025-08-07T08:31:06.000Z",
  "canalVenta": "TIENDA",
  "ptosGenerados": 49,
  "cliente": {
    "idCliente": 147,
    "nombre": "Victoriano",
    "afiliado": false
  },
  "detalleVentas": [
    {
      "cantidad_vendida": 9,
      "producto": {
        "marca": "Maybelline",
        "nombre": "Rímel Volumen Extra",
        "precio_unitario": 8.90,
        "categoria": "Maquillaje y Cosméticos"
      }
    }
  ],
  "sucursal": {
    "idSucursal": 27,
    "ciudad": "Bucaramanga",
    "pais": "Colombia"
  }
}
```

![Evidence of mongo_squema](./mongo_squema.png)
