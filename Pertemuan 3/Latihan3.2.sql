SELECT 
    Color,
    COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;