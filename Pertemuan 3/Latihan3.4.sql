SELECT 
    Color,
    Size,
    COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Size;