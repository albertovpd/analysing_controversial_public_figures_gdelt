-- There are a lot of "unespecified" columns in SOURCEURL.Maibe it worhts contrasting with and without this elements.

CREATE OR REPLACE TABLE
  `myproject_and_dataset.former_king_news_without_unespecified` AS
SELECT
  -- este select está solo para usar el where al final y eliminar los null que se generan en news_in_Spain
  *
FROM (
  SELECT
    (SQLDATE),
    EXTRACT (date
    FROM
      PARSE_TIMESTAMP('%Y%m%d',CAST(SQLDATE AS string))) AS Date,
    AvgTone,
    NumArticles,
    SOURCEURL,
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
      ) AS country
  FROM
    `gdelt-bq.full.events` )
WHERE
  king IS NOT NULL
  AND SOURCEURL !='unspecified'
  AND country IS NOT NULL
  AND SQLDATE >= 19790110