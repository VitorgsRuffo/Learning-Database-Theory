-- Nome: Vitor Gabriel da Silva Ruffo


-- 1. obtendo os nomes das tabelas presentes no banco.
SELECT name 
  FROM sqlite_master
 where type = 'table'


-- 2. obtendo a estrutura da tabela "crime_scene_report"
SELECT sql 
  FROM sqlite_master
 where name = 'crime_scene_report'


-- 3. o texto fala para começar pela tabela de relatorios de cenas de crime. Tambem deixa
--    em negrito a data, o tipo e a cidade do crime. Logo vou tentar obter linhas que batem
--    com essa descricao.

SELECT * FROM crime_scene_report WHERE city = "SQL City" AND type = "murder" AND date = "20180115"


-- 4. o relatorio do crime mostrou que houveram duas testemunhas. Portanto, a proxima etapa é selecionar as testemunhas
--    juntamente com as intrevistas que as mesmas forneceram. 

--obs: A consulta nao retornou uma tupla para a annabel, assim vamos focar na outra testemunha.
SELECT *
FROM interview
JOIN (SELECT * 
      FROM person 
  	  WHERE name LIKE '%Annabel%' AND 
		    address_street_name LIKE '%Franklin Ave%'

  	  UNION

	  SELECT * 
	  FROM person 
	  WHERE address_street_name LIKE '%Northwestern Dr%'
	  ORDER BY address_number DESC
	  LIMIT 1) witnesses
ON person_id = id


-- 5. com as informaçoes passadas pela testemunha (i.e, id da academia iniciando com 48Z e placa do carro contendo H42W)
--    é possivel juntar as tabelas de pessoa, carteira de habilitacao e membros da academia e filtrar por essas duas informacoes
--    para encontrar um possivel suspeito.

-- suspeito -> Jeremy Bowers

SELECT *
FROM (drivers_license
      JOIN person
        ON drivers_license.id = person.license_id)
     JOIN get_fit_now_member
       ON get_fit_now_member.person_id = person.id
WHERE plate_number LIKE '%H42W%' AND
      get_fit_now_member.id LIKE '48Z%'



-- 6. checando a solucao... 
INSERT INTO solution VALUES (1, 'Jeremy Bowers');        
SELECT value FROM solution;


-- 7. obtendo as palavras de Jeremy Bowers em seu enterrogatorio com a policia...
SELECT transcript FROM interview WHERE person_id = '67318'
--obs: segundo Jeremy Bowers, ele foi contratado para efetuar o assasinato... devemos encontrar quem o contratou
--     utilizando as informacoes que ele forneceu na enterrogatorio.


-- 8. ele deu informacoes sobre caracteristicas fisicas do seu contratante, sobre o carro que usava e sobre o evento
--    que participou. Assim podemos juntar as tabelas de pessoa, carteira de habilitacao e eventos e filtrar por essas 
--    informacoes para encontrar a pessoa que o contratou.

SELECT *
FROM (drivers_license
      JOIN person
        ON drivers_license.id = person.license_id)
     JOIN facebook_event_checkin
       ON facebook_event_checkin.person_id = person.id
WHERE gender = 'female' AND 
      height IN (64, 65, 66, 67, 68) AND
      hair_color = 'red' AND
      car_make LIKE '%Tesla%' AND
      car_model LIKE '%Model S%' AND
      event_name = 'SQL Symphony Concert' AND
      date >= 20171201 AND date <= 20171231

-- obs: a query retorna 3 tuplas que correspondem a mesma pessoa 
--      (lembra que ele disse que o seu contratante foi 3 vezes neste evento ?).
--      Assim nosso segundo criminoso é a mulher Miranda Priestly.


-- 9. checando a solucao... 
INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;

