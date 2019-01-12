-- Conjunto de Perguntas 1
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
ORDER BY 3 DESC

-- Agora encontre qual cliente gastou mais com o artista que você encontrou acima.
SELECT a.Name, SUM(il.unitPrice *  il.Quantity) AmountSpent, c.Customerid, c.FirstName, c.LastName
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

/*
SQL (Avançado) Pergunta 1
Queremos descobrir o gênero musical mais popular em cada país. Determinamos o gênero mais popular como o gênero com o maior número de
compras. Escreva uma consulta que retorna cada país juntamente a seu gênero mais vendido. Para países onde o número máximo de compras é
compartilhado retorne todos os gêneros.
*/
SELECT Purchases, Country, name, genreid FROM (
	SELECT COUNT(il.invoicelineid) Purchases, i.BillingCountry Country, g.name, g.genreid, max_purchases
	FROM Invoice i
	INNER JOIN InvoiceLine il ON il.Invoiceid = i.Invoiceid
	INNER JOIN Track t ON t.Trackid = il.Trackid
	INNER JOIN Genre g ON g.GenreId = t.GenreId
	INNER JOIN (	SELECT MAX(count) max_purchases, BillingCountry FROM (
						SELECT COUNT(sub_il.invoicelineid) count, sub_i.BillingCountry, sub_g.genreid
						FROM Invoice sub_i
						INNER JOIN InvoiceLine sub_il ON sub_il.Invoiceid = sub_i.Invoiceid
						INNER JOIN Track sub_t ON sub_t.Trackid = sub_il.Trackid
						INNER JOIN Genre sub_g ON sub_g.GenreId = sub_t.GenreId
						GROUP BY sub_i.BillingCountry, sub_g.genreid
					)
					GROUP BY BillingCountry
				) sub_max ON sub_max.BillingCountry = i.BillingCountry
	GROUP BY i.BillingCountry, g.name, g.genreid
)
WHERE max_purchases = purchases

/*
Pergunta 2
Retorne todos os nomes de músicas que possuem um comprimento de canção maior que o comprimento médio de canção. Embora você possa 
fazer isso com duas consultas. Imagine que você queira que sua consulta atualize com base em onde os dados são colocados no banco de dados.
Portanto, você não quer fazer um hard code da média na sua consulta. Você só precisa da tabela Track (música) para completar essa consulta. 
Retorne o Name (nome) e os Milliseconds (milissegundos) para cada música. Ordene pelo comprimento da canção com as músicas mais longas
sendo listadas primeiro.
*/
SELECT t.Name, t.Milliseconds
FROM Track t
WHERE t.Milliseconds > (SELECT AVG(sub.Milliseconds) FROM Track sub)
ORDER BY t.Milliseconds DESC

/*
Pergunta 3
Escreva uma consulta que determina qual cliente gastou mais em músicas por país. Escreva uma consulta que retorna o país junto ao principal
cliente e quanto ele gastou. Para países que compartilham a quantia total gasta, forneça todos os clientes que gastaram essa quantia.

Você só precisará usar as tabelas Customer (cliente) e Invoice (fatura).

Verifique sua solução embora existam apenas 24 países, a consulta deve retornar 25 linhas. As últimas 11 linhas são mostradas na imagem
 abaixo. Observe que o Reino Unido tem 2 clientes que compartilham o máximo.
*/
SELECT BillingCountry, sum_total, FirstName, LastName, Customerid FROM (
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
ORDER BY BillingCountry
