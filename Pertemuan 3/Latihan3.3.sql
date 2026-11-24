SELECT 
    ProductID,
    SUM(OrderQty) AS TotalTerjual,
    AVG(UnitPrice) AS RataRataHarga
FROM Sales.SalesOrderDetail
GROUP BY ProductID;