create table `myproject_and_dataset.former_king_news`
as
SELECT
  
  *
FROM (
  SELECT
     (SQLDATE),
     EXTRACT (date
    FROM
      PARSE_TIMESTAMP('%Y%m%d',CAST(SQLDATE AS string))) AS Date,
  
    AvgTone,
    NumArticles,
    SOURCEURL AS noticia,
    GoldsteinScale AS affecting_country_stability,
    (CASE
        WHEN Actor1Name ='KING JUAN CARLOS' THEN "Rey Juan Carlos"
    END
      ) AS king,
    (CASE
        WHEN net.host(SOURCEURL) LIKE "%.ch" THEN "periódico Suizo"
        WHEN ( net.host(SOURCEURL) LIKE "%.es"
        OR net.host(SOURCEURL) IN (
        SELECT
          spanish_newspapers
        FROM
          `myproject_and_dataset.spanish_newspapers_SourceCommonName_160620`)
        OR net.host(SOURCEURL) IN (
        SELECT
          spanish_media
        FROM
          `myproject_and_dataset.spanish_media_SourceURL`) ) THEN "periódico español"
      ELSE
      "otros países"
    END
      ) AS source
  FROM
    `gdelt-bq.full.events` )
WHERE
  king IS NOT NULL
  -- AND noticia != 'unespecified'
  AND SOURCE IS NOT NULL
  AND SQLDATE >= 19790110