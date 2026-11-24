SELECT 
    Color,
    Name,
    COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Name;