-- Pergunta 1: Quais países possuem mais faturas?
SELECT BillingCountry, COUNT(invoiceid) AS Invoices
FROM Invoice
GROUP BY BillingCountry
ORDER BY COUNT(invoiceid) DESC

-- Pergunta 2: Qual cidade tem os melhores clientes?
SELECT BillingCity, SUM(total) AS Invoices
FROM Invoice
GROUP BY BillingCity
ORDER BY SUM(total) DESC

-- Pergunta 3: Quem é o melhor cliente?
SELECT c.customerid, c.FirstName, SUM(i.total)
FROM Invoice i
INNER JOIN Customer c ON c.customerid = i.customerid
GROUP BY c.customerid, c.FirstName
ORDER BY SUM(i.total) DESC
