CREATE OR REPLACE TABLE
  `myproject.mydataset.former_king_all` AS
SELECT
  -- este select está solo para usar el where al final y eliminar los null que se generan en news_in_Spain
  *
FROM (
  SELECT
    (SQLDATE),
    --EXTRACT (date
      --FROM
      --PARSE_TIMESTAMP('%Y%m%d',CAST(SQLDATE AS string))) AS Date,
    AvgTone,
    NumArticles,
    net.host(SOURCEURL) AS media,
    GoldsteinScale AS affecting_country_stability,
    (CASE
        WHEN Actor1Name ='KING JUAN CARLOS' THEN "Rey Juan Carlos"
    END
      ) AS king,
  FROM
    `gdelt-bq.full.events` )
WHERE
  king IS NOT NULL
  AND SQLDATE >= 19790110 -- oldest news founded about our matters