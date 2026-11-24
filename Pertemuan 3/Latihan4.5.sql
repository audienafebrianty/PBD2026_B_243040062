SELECT Color
FROM Production.Product
GROUP BY Color
HAVING MAX(ListPrice) > 3000;