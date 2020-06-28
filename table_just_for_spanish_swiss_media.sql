CREATE OR REPLACE TABLE
  `myproject.mydataset.former_king_news_swiss_spa` AS
SELECT
  *
FROM (

  SELECT
    (SQLDATE),
    --EXTRACT (date
      --FROM
      --PARSE_TIMESTAMP('%Y%m%d',CAST(SQLDATE AS string))) AS Date,
    AvgTone,
    --NumArticles,
    SOURCEURL AS media,
    GoldsteinScale AS affecting_country_stability,
    (CASE
        WHEN Actor1Name ='KING JUAN CARLOS' THEN "Rey Juan Carlos"
    END
      ) AS king,
        WHEN ( net.host(SOURCEURL) LIKE "%.ch" OR net.host(SOURCEURL) LIKE "%romandie.com%" OR net.host(SOURCEURL) LIKE "%agefi.com%" )THEN "swiss news"
    (CASE
        WHEN ( net.host(SOURCEURL) LIKE "%.es"
        OR net.host(SOURCEURL) IN (
        SELECT
          spanish_newspapers
        FROM
          `myproject.mydataset.spanish_newspapers_SourceCommonName_160620`)
        OR net.host(SOURCEURL) IN (
        SELECT
          spanish_media
        FROM
          `myproject.mydataset.spanish_media_SourceURL`) ) THEN "spanish news"
     -- ELSE
     -- "other"
    END
      ) AS country
  FROM
    `gdelt-bq.full.events` )
WHERE
  king IS NOT NULL
  -- AND noticia != 'unespecified'
  AND country IS NOT NULL
  AND SQLDATE >= 19790110