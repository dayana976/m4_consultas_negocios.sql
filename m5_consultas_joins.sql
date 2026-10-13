/* =====================================================================
 Consultas con JOINs para el proyecto
===========================================================*/
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
===========================================================*/
SELECT
    v.fecha_venta AS Fecha,
    c.id_cliente AS Identificacion_Cliente,
    c.email AS Mail_Cliente,
    c.ciudad AS Ciudad_Cliente,
    p.nombre_producto AS Descripcion_Producto,
    v.cantidad AS Cantidad,
    v.precio_unitario AS Precio_Unitario,
    v.cantidad * v.precio_unitario AS Total_Venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto;
===========================================================*/
-- Consulta 2 — Clientes sin ventas (LEFT JOIN) 
===========================================================*/
SELECT
    v.fecha_venta AS Fecha,
    c.fecha_registro AS Fecha_registro,
    c.nombre AS Nombre_Cliente,
    c.email AS Mail_Cliente    
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;
===========================================================*/
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
===========================================================*/
SELECT
    p.nombre_producto AS nombre_producto,
    c.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
LEFT JOIN categorias c
    ON p.id_categoria = c.id_categoria
WHERE v.id_producto IS NULL;
===========================================================*/
-- Consulta 4 — Consolidado por canal (UNION ALL)
===========================================================*/
SELECT
    p.nombre_producto AS Producto,
    c.ciudad AS Ciudad,
    SUM(v.Cantidad) AS UnidadesVendidas,
    SUM(v.Cantidad * p.precio) AS Total_facturado
FROM dbo.Ventas AS v
INNER JOIN dbo.Clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN dbo.Productos AS p
    ON v.id_producto = p.id_producto
WHERE c.ciudad = 'Rosario'
GROUP BY p.nombre_producto, c.ciudad

UNION ALL

SELECT
    p.nombre_producto AS Producto,
    c.ciudad AS Ciudad,
    SUM(v.Cantidad) AS UnidadesVendidas,
    SUM(v.Cantidad * p.precio) AS Total_facturado
FROM dbo.Ventas AS v
INNER JOIN dbo.Clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN dbo.Productos AS p
    ON v.id_producto = p.id_producto
WHERE c.ciudad = 'Buenos Aires'
GROUP BY p.nombre_producto, c.ciudad
