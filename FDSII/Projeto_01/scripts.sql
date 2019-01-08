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

-- Conjunto de Perguntas 2
/*Pergunta 1 - Use sua consulta para retornar o e-mail, nome, sobrenome e gênero de todos os ouvintes de Rock. Retorne sua lista ordenada alfabeticamente
por endereço de e-mail, começando por A. Você consegue encontrar um jeito de lidar com e-mails duplicados para que ninguém receba vários
e-mails?*/
SELECT DISTINCT c.Email, c.FirstName, c.LastName, g.Name
FROM Invoice i
INNER JOIN Customer c ON c.customerid = i.customerid
INNER JOIN InvoiceLine il ON il.Invoiceid = i.Invoiceid
INNER JOIN Track t ON t.Trackid = il.Trackid
INNER JOIN Genre g ON g.GenreId = t.GenreId
WHERE g.GenreId = 1
ORDER BY c.Email

/*
Pergunta 2: Quem está escrevendo as músicas de rock?
Agora que sabemos que nossos clientes amam rock, podemos decidir quais músicos convidar para tocar no show.
Vamos convidar os artistas que mais escreveram as músicas de rock em nosso banco de dados. Escreva uma consulta que retorna o nome do
Artist (artista) e a contagem total de músicas das dez melhores bandas de rock.
*/
SELECT a.Artistid, a.Name, COUNT(t.Trackid) Songs
FROM Track t
INNER JOIN Genre g ON g.GenreId = t.Genreid
INNER JOIN Album alb ON alb.Albumid = t.Albumid
INNER JOIN Artist a ON a.Artistid = alb.Artistid
WHERE g.GenreId = 1
GROUP BY a.Artistid, a.Name
ORDER BY Songs DESC

/*
Pergunta 3
Primeiro, descubra qual artista ganhou mais de acordo com InvoiceLines (linhas de faturamento).
Agora encontre qual cliente gastou mais com o artista que você encontrou acima.
*/
SELECT a.Artistid, a.Name, SUM(il.unitPrice) Valor_Total
FROM Track t
INNER JOIN Genre g ON g.GenreId = t.Genreid
INNER JOIN Album alb ON alb.Albumid = t.Albumid
INNER JOIN Artist a ON a.Artistid = alb.Artistid
INNER JOIN InvoiceLine il ON il.Trackid = t.Trackid
GROUP BY a.Artistid, a.Name
ORDER BY il.unitPrice DESC

-- Agora encontre qual cliente gastou mais com o artista que você encontrou acima.
SELECT a.Name, SUM(il.unitPrice *  il.Quantity) AmountSpent, c.Customerid, c.FirstName, c.LastName
FROM Track t
INNER JOIN Genre g ON g.GenreId = t.Genreid
INNER JOIN Album alb ON alb.Albumid = t.Albumid
INNER JOIN Artist a ON a.Artistid = alb.Artistid
INNER JOIN InvoiceLine il ON il.Trackid = t.Trackid
INNER JOIN Invoice i ON i.Invoiceid = il.Invoiceid
INNER JOIN Customer c ON c.Customerid = i.Customerid
WHERE a.Artistid = 90
GROUP BY c.Customerid
ORDER BY AmountSpent DESC
