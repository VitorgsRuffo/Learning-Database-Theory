-- Nome: Vitor Gabriel da Silva Ruffo

-----------------------------------------------------------------------------------
-- capitulo 1

-- 1. selecionando as primeiras linhas da tabela para ver quais colunas existem...
SELECT * FROM executions LIMIT 3


-- 2. selecionando colunas especificas... 
SELECT first_name, last_name, last_statement
FROM executions
LIMIT 3


-- 3. analisando o erro da query... (o erro é o nome errado da tabela)
SELECT first_name FROM execution LIMIT 3


-- 3.1. corrigindo o nome da tabela...
SELECT first_name FROM executions LIMIT 3


-- 4. utilizando o SELECT para realizar calculos...
SELECT 50 / 2, 51 / 2


-- 5. vizualizando que SQL nao é case-sensitive para as keywords e que a quantidade de whitespaces nao importa
   SeLeCt   first_name,last_name
  fRoM      executions
           WhErE ex_number = 145


-- 6. selecionando o nome e idade de todos os executados que tinham 25 anos ou menos...
SELECT first_name, last_name, ex_age
FROM executions
WHERE ex_age <= 25

-- 7. selecionando o executado com nome Raymond Landry..

-- 7.1 nao retorna nada
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name = 'Raymond'
  AND last_name = 'Landry'

-- 7.2 nao retorna nada
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE 'Raymond'
  AND last_name LIKE 'Landry'

-- 7.3 nao retorna nada
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '_aymond'
  AND last_name LIKE '_andry'

-- 7.4 nao retorna nada
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '%mond'
  AND last_name LIKE '%dry'

-- 7.5 retorno incorreto
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '%d'
  AND last_name LIKE '%y'

-- 7.6 retorno incorreto
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '%nd'
  --AND last_name LIKE '%y'

-- 7.7. retorno correto
SELECT first_name, last_name, ex_number
FROM executions
WHERE first_name LIKE '%raymond%'
   AND last_name LIKE '%landry%'


-- 8. tentando fazer a expressao retornar 0 mudando a precedencia dos operadores
-- 8.1 retorna 1
SELECT 0 AND 0 OR 1

-- 8.2 retorna 0
SELECT 0 AND (0 OR 1)


-- 9. encontrando as ultimas palavras de Napoleon Beazley
SELECT last_statement
FROM executions 
WHERE first_name LIKE '%napoleon%'
  AND last_name LIKE '%beazley%'


-----------------------------------------------------------------------------------
-- capitulo 2

-- 1. descobrindo quantos presos deram as suas ultimas palavras...
SELECT COUNT(last_statement) FROM executions


-- 2. verificando que zero e a string vazia nao sao considerados NULL
SELECT (0 IS NOT NULL) AND ('' IS NOT NULL) 


-- 3. descobrindo o total de execuçoes
SELECT COUNT(first_name) FROM executions


-- 4. caso nenhuma das colunas seja completamente livres de valores NULL podemos usar COUNT(*) para descobrir o tamanho da tabela,
--    pois, pelo menos uma das colunas das tuplas deve ser diferente de NULL.
SELECT COUNT(*) FROM executions


-- 5. contando subgrupos de linhas da tabela separadamente...
SELECT
    COUNT(CASE WHEN county='Harris' THEN 1
        ELSE NULL END),
    COUNT(CASE WHEN county='Bexar' THEN 1
        ELSE NULL END)
FROM executions


-- 5.1 percebi que o valor depois do then nao altera a contagem, pois, o COUNT so considera a presença de valor e nao o valor em si.
SELECT
    COUNT(CASE WHEN county='Harris' THEN 2
        ELSE NULL END),
    COUNT(CASE WHEN county='Bexar' THEN 2
        ELSE NULL END)
FROM executions

SELECT
    COUNT(CASE WHEN county='Harris' THEN 112
        ELSE NULL END),
    COUNT(CASE WHEN county='Bexar' THEN 1123
        ELSE NULL END)
FROM executions


-- 6. encontrando quantos presos tinham idade superior a 50 no momento de execucao.
SELECT COUNT(*) FROM executions WHERE ex_age > 50


-- 7. numero de presos que se recusaram a dar as ultimas palavras.
-- utilizando where:
SELECT COUNT(*) FROM executions WHERE last_statement is NULL

-- utilizando case when block
SELECT COUNT(CASE WHEN last_statement is NULL THEN 1 ELSE NULL END) FROM executions

--utilizando dois COUNTs
SELECT COUNT(*)-COUNT(last_statement) FROM executions


-- 8. encontrando a idade minima, maxima e media dos presos no momento de execucao.
SELECT MIN(ex_age), MAX(ex_age), AVG(ex_age) FROM executions


-- 9. encontrando o tamanho medio (em caracteres) das ultimas palavras dos presos
SELECT AVG(length(last_statement)) FROM executions


-- 10. listar todas as counties no dataset (sem duplicações)
SELECT DISTINCT county FROM executions


-- 11. rodando uma query sem sentido para ver o resultado.  
SELECT first_name, COUNT(*) FROM executions


-- 12. encontrar a proporcao de presos que afirmaram ser inocentes em suas ultimas palavras.
SELECT COUNT(CASE WHEN last_statement LIKE '%innocent%' THEN 1 ELSE NULL END) / (COUNT(*) * 1.0) FROM executions



-----------------------------------------------------------------------------------
-- capitulo 3


-- 1. obtendo o numero de execucoes em cada county.
SELECT
  county,
  COUNT(*) AS county_executions
FROM executions
GROUP BY county


-- 2. "Modify this query so there are up to two rows per county — one counting executions with a last statement and another without."
-- nao consegui resolver

-- incorreto 
SELECT
  county,
  COUNT(last_statement) AS ex_with_last_st,
  COUNT(*)- COUNT(last_statement) AS ex_without_last_st 
FROM executions
GROUP BY county

-- incorreto 
SELECT
  county,
  COUNT(*)
FROM executions
GROUP BY county, last_statement

-- resposta certa: observa-se que na resposta atingimos o resultado com apenas um COUNT (mais eficiente) enquanto que na minha
--           primeira tentativa foi utilizada 3 COUNTS para chegar em um resultado parecido.
SELECT
  county,
  last_statement IS NOT NULL AS has_last_statement,
  COUNT(*)
FROM executions
GROUP BY county, has_last_statement


-- 3. obter numero de presos com idade 50 ou mais que foram executados em cada county

-- esqueci de incluir a coluna county :)
SELECT COUNT(*) AS count FROM executions WHERE ex_age >= 50 GROUP BY county

SELECT county, COUNT(*) AS count FROM executions WHERE ex_age >= 50 GROUP BY county


-- 4. listar as counties nas quais mais de 2 presos com idade 50 ou mais foram executados.

-- incorreto
SELECT county, COUNT(*) FROM executions WHERE ex_age >= 50 GROUP BY county HAVING COUNT(*) > 2

-- correto
SELECT county FROM executions WHERE ex_age >= 50 GROUP BY county HAVING COUNT(*) > 2


-- 5. listar todas as counties distintas.
SELECT county FROM executions GROUP BY county


-- 6. encontrar o primeiro e ultimo nome do preso com as ultimas palavras que tem mais caracteres.
SELECT first_name, last_name
FROM executions
WHERE LENGTH(last_statement) =
    (SELECT MAX(LENGTH(last_statement)) FROM executions)


-- 7. encontrar a porcentagem de execuções em cada county em relação ao total de execuções.
SELECT
  county,
  100.0 * COUNT(*) / (SELECT COUNT(*) FROM executions)
    AS percentage
FROM executions
GROUP BY county
ORDER BY percentage DESC



-----------------------------------------------------------------------------------
-- capitulo 4


-- 1. retornando a diferença (dias) entre duas datas.
SELECT julianday('1993-08-10') - julianday('1989-07-07') AS day_difference


-- 2. escrevendo uma query para retornar a "previous" table.
--incorreto
SELECT ex_number + 1 AS ex_number, ex_date AS last_ex_date FROM executions


SELECT ex_number + 1 AS ex_number, ex_date AS last_ex_date FROM executions WHERE ex_number < 553


-- 3. obtendo a diferença (dias) entre as execuçoes de modo a analisar os maiores hiatos.
SELECT
  last_ex_date AS start,
  ex_date AS end,
  JULIANDAY(ex_date) - JULIANDAY(last_ex_date)
    AS day_difference
FROM executions
JOIN (SELECT ex_number + 1 AS ex_number, ex_date AS last_ex_date FROM executions WHERE ex_number < 553) previous
  ON executions.ex_number = previous.ex_number
ORDER BY day_difference DESC
LIMIT 10



-- 4. refatorando a query 3 (anterior) utilizando SELF JOIN.
--incorreto
SELECT
  previous.ex_date AS start,
  executions.ex_date AS end,
  JULIANDAY(executions.ex_date) - JULIANDAY(previous.ex_date)
    AS day_difference
FROM executions
JOIN executions previous
  ON executions.ex_number = previous.ex_number - 1
ORDER BY day_difference DESC
LIMIT 10

--correto
SELECT
  previous.ex_date AS start,
  executions.ex_date AS end,
  JULIANDAY(executions.ex_date) - JULIANDAY(previous.ex_date)
    AS day_difference
FROM executions
JOIN executions previous
  ON executions.ex_number - 1 = previous.ex_number
ORDER BY day_difference DESC
LIMIT 10




-----------------------------------------------------------------------------------
-- capitulo 5


-- 1. Efetuando selecao para analisar as colunas da tabela
SELECT * FROM cosponsors LIMIT 3
SELECT * FROM cosponsors LIMIT 30





-- 2. encontrar o senador com maior mutualidade em apoio de bills. Ou seja, o senador que mais
--    apoiou outros que tambem o apoiaram.

-- errado.
SELECT net2.sponsor_name 
FROM (
    SELECT net.sponsor_name, COUNT(*) AS net_num
    FROM (
        SELECT DISTINCT cosponsors.sponsor_name, cosponsors.cosponsor_name
        FROM cosponsors
        JOIN cosponsors cosponsors2
            ON cosponsors.sponsor_name = cosponsors2.cosponsor_name 
           and cosponsors.cosponsor_name = cosponsors2.sponsor_name
    ) net
    GROUP BY net.sponsor_name 
    ORDER BY net_num DESC
    LIMIT 1
) net2

-- correto
SELECT net.sponsor_name, COUNT(*) AS net_num
FROM (
    SELECT DISTINCT cosponsors.sponsor_name, cosponsors.cosponsor_name
    FROM cosponsors
    JOIN cosponsors cosponsors2
        ON cosponsors.sponsor_name = cosponsors2.cosponsor_name 
       and cosponsors.cosponsor_name = cosponsors2.sponsor_name
) net
GROUP BY net.sponsor_name 
ORDER BY net_num DESC
LIMIT 1




-- 3.

--
SELECT net.sponsor_state, net.sponsor_name, COUNT(*) AS net_num
FROM (
    SELECT DISTINCT cosponsors.sponsor_state, cosponsors.sponsor_name, cosponsors.cosponsor_name
    FROM cosponsors
    JOIN cosponsors cosponsors2
        ON cosponsors.sponsor_name = cosponsors2.cosponsor_name 
       and cosponsors.cosponsor_name = cosponsors2.sponsor_name
) net
GROUP BY net.sponsor_state, net.sponsor_name 


-- errado
SELECT net2.sponsor_state, net2.sponsor_name, net2.net_num, MAX(net2.net_num) AS max_net_num
FROM (
    SELECT net.sponsor_state, net.sponsor_name, COUNT(*) AS net_num
    FROM (
        SELECT DISTINCT cosponsors.sponsor_state, cosponsors.sponsor_name, cosponsors.cosponsor_name
        FROM cosponsors
        JOIN cosponsors cosponsors2
            ON cosponsors.sponsor_name = cosponsors2.cosponsor_name 
           and cosponsors.cosponsor_name = cosponsors2.sponsor_name
    ) net
    GROUP BY net.sponsor_state, net.sponsor_name 
) net2
GROUP BY net2.sponsor_state, net2.sponsor_name
HAVING net2.net_num = max_net_num 


--errado
SELECT net2.sponsor_state, net2.sponsor_name, net2.net_num, MAX(net2.net_num) AS max_net_num
FROM (
    SELECT net.sponsor_state, net.sponsor_name, COUNT(*) AS net_num
    FROM (
        SELECT DISTINCT cosponsors.sponsor_state, cosponsors.sponsor_name, cosponsors.cosponsor_name
        FROM cosponsors
        JOIN cosponsors cosponsors2
            ON cosponsors.sponsor_name = cosponsors2.cosponsor_name 
           and cosponsors.cosponsor_name = cosponsors2.sponsor_name
    ) net
    GROUP BY net.sponsor_state, net.sponsor_name 
) net2
GROUP BY net2.sponsor_state, net2.sponsor_name
HAVING net2.net_num = max_net_num 


--errado
SELECT net.sponsor_state, net.sponsor_name, COUNT(*) AS net_num
FROM (
    SELECT DISTINCT cosponsors.sponsor_state, cosponsors.sponsor_name, cosponsors.cosponsor_name
    FROM cosponsors
    JOIN cosponsors cosponsors2
        ON cosponsors.sponsor_name = cosponsors2.cosponsor_name 
       and cosponsors.cosponsor_name = cosponsors2.sponsor_name
) net
GROUP BY net.sponsor_state, net.sponsor_name 
HAVING net_num = MAX(net_num)







-- 4.

--nao roda..
SELECT DISTINCT cosponsor_name
FROM cosponsors
WHERE NOT IN (
    SELECT DISTINCT sponsor_name
    FROM cosponsors
) 
AND IN (
    SELECT DISTINCT cosponsor_name
    FROM cosponsors
)

