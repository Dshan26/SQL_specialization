SELECT * FROM facturas;

SELECT * FROM items_facturas;

SELECT F.DNI, date_format(F.FECHA_VENTA, "%m - %Y") as MES_AÑO, IFa.CANTIDAD FROM facturas F
INNER JOIN
items_facturas IFa
ON F.NUMERO = IFa.NUMERO;

/*CANTIDAD DE VENTAS POR MES PARA CADA CLIENTE*/
SELECT F.DNI, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO,
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA FROM facturas f
INNER JOIN
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
GROUP BY 
F.DNI, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y");

/*LIMTTE DE VENTAS POR CLIENTE (volumen en decilitros)*/
SELECT * FROM tabla_de_clientes TC;

SELECT DNI, NOMBRE, VOLUMEN_DE_COMPRA FROM tabla_de_clientes TC;

SELECT F.DNI,TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO,
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA
FROM facturas f
INNER JOIN
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN tabla_de_clientes TC
ON TC.DNI = F.DNI
GROUP BY 
F.DNI,TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y");

SELECT A.DNI, A.NOMBRE, A.MES_AÑO,
A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA AS DIFERENCIA FROM(
SELECT F.DNI,TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO,
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA
FROM facturas f
INNER JOIN
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN tabla_de_clientes TC
ON TC.DNI = F.DNI
GROUP BY 
F.DNI,TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y"))A;


SELECT A.DNI, A.NOMBRE, A.MES_AÑO,
A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA AS DIFERENCIA, 
CASE
 WHEN (A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA) <= 0 THEN 'VENTA VALIDAD'
 ELSE 'VENTA INVALIDAD'
 END AS STATUS_VENTA
FROM(
SELECT F.DNI,TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO,
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA
FROM facturas f
INNER JOIN
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN tabla_de_clientes TC
ON TC.DNI = F.DNI
GROUP BY 
F.DNI,TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y"))A;


