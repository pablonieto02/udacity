
-- Slide 1 - Campẽao em Vendas! (us$)
SELECT a.Name, ROUND(SUM(il.unitPrice),2) Valor_Total
FROM Track t
INNER JOIN Genre g ON g.GenreId = t.Genreid
INNER JOIN Album alb ON alb.Albumid = t.Albumid
INNER JOIN Artist a ON a.Artistid = alb.Artistid
INNER JOIN InvoiceLine il ON il.Trackid = t.Trackid
GROUP BY a.Artistid, a.Name
ORDER BY 2 DESC
LIMIT 10

-- Slide 2 - Amantes do nosso Artista Campeão! (us$)
SELECT  FirstName || ' ' || LastName nome, AmountSpent total_gasto FROM (
SELECT SUM(il.unitPrice *  il.Quantity) AmountSpent, c.Customerid, c.FirstName, c.LastName
FROM Track t
INNER JOIN Genre g ON g.GenreId = t.Genreid
INNER JOIN Album alb ON alb.Albumid = t.Albumid
INNER JOIN Artist a ON a.Artistid = alb.Artistid
INNER JOIN InvoiceLine il ON il.Trackid = t.Trackid
INNER JOIN Invoice i ON i.Invoiceid = il.Invoiceid
INNER JOIN Customer c ON c.Customerid = i.Customerid
WHERE a.Artistid = (
					SELECT Artistid FROM (
						SELECT a.Artistid, a.Name, SUM(il.unitPrice) Valor_Total
						FROM Track t
						INNER JOIN Genre g ON g.GenreId = t.Genreid
						INNER JOIN Album alb ON alb.Albumid = t.Albumid
						INNER JOIN Artist a ON a.Artistid = alb.Artistid
						INNER JOIN InvoiceLine il ON il.Trackid = t.Trackid
						GROUP BY a.Artistid, a.Name
						ORDER BY 3 DESC
					)
					LIMIT 1
)
GROUP BY c.Customerid
ORDER BY AmountSpent DESC
LIMIT 5
)

-- Slide 3 - Vamos promover um Show!
SELECT a.Name, COUNT(t.Trackid) Songs
FROM Track t
INNER JOIN Genre g ON g.GenreId = t.Genreid
INNER JOIN Album alb ON alb.Albumid = t.Albumid
INNER JOIN Artist a ON a.Artistid = alb.Artistid
WHERE g.GenreId = 1
GROUP BY a.Artistid, a.Name
ORDER BY Songs DESC
LIMIT 10

-- Slide 4 - Campeões em Compras! (us$)
SELECT BillingCountry, FirstName || ' ' || LastName Name, sum_total FROM (
	SELECT i.BillingCountry, c.FirstName, c.LastName,c.Customerid, b.max_total, SUM(i.Total) sum_total
	FROM Invoice i
	INNER JOIN Customer c ON c.customerid = i.customerid
	INNER JOIN (	SELECT sub.BillingCountry, MAX(sub.Total) max_total FROM (
							SELECT si.BillingCountry, sc.Customerid, SUM(si.Total) total
							FROM Invoice si
							INNER JOIN Customer sc ON sc.customerid = si.customerid
							GROUP BY si.BillingCountry, sc.Customerid
								) sub
						GROUP BY BillingCountry
					) b ON b.BillingCountry = i.BillingCountry
	GROUP BY i.BillingCountry, c.FirstName, c.LastName,c.Customerid, b.max_total
)
WHERE sum_total = max_total
ORDER BY sum_total DESC
LIMIT 5
