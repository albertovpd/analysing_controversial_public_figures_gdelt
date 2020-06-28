-- all important found newspapers end up with ".ch", but romainde and agefi 
-- so instead of creating a swiss table in BigQuery, I just will filter by url domain.
-- This query returns 

create or replace table `myprojectmydataset.swiss_media_host_net_sourceurl`
as
SELECT 
  -- este select está solo para usar el where al final y eliminar los null que se generan en news_in_Spain
  url_domain
FROM (
  SELECT
  net.host(SOURCEURL) as url_domain,
     (CASE
       WHEN ( net.host(SOURCEURL) LIKE "%.ch" OR net.host(SOURCEURL) LIKE "%romandie.com%" OR net.host(SOURCEURL) LIKE "%agefi.com%" )THEN "swiss news"
    END
      ) AS source
  FROM
    `gdelt-bq.full.events` )
WHERE
    SOURCE IS NOT NULL
    
group by 	url_domain