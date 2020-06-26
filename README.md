# K project.

Disclaimer: **This is not political propaganda of any kind**. I am just an analytic person who have questions and love researching instead of blindly believing rumors.

# Introduction.

I like reading "alternative" sources, like reddit, hackernews on meneame, and once in a while I read some news about delicate matters involving the former king of Spain. This articles always express a deep frustration about how this news are not being published in his country.
So, this are the questions: 
Is the spanish news saying the same than the rest of world news, about our former king?
Do we have a method to impartially contrast it?

The second question is clear for me: Yes. The first question: It needs some research, and that is precisely what I did with the Gdelt database and BigQuery. 
Gdelt is a huge database, ingesting news of the whole planet every 15 minutes. It is not just the crazy ingestion pipeline, you also can find all the information processed and classified, by themes, by people, by country, by media source…By sentiment of the news. Certainly Asimov would be proud.



# Methodology.


1. Filtering by Actor1Name:

As many important people, "King Juan Carlos" is an entity itself in the Gdelt Project. With the simple query below, you can find all news in the world in which he is mentioned or attached:

        SELECT
            (CASE
                WHEN Actor1Name ='KING JUAN CARLOS' THEN "Rey Juan Carlos"
            END
            )
        FROM
        `gdelt-bq.full.events`

2. Filtering by ulr:

My knowledge domain of most important newspapers in Switzerland is quite limited, and it is even harder due to their multilingual culture. Nevertheless it looks like the main ones always have the .ch domain, so I filtered by .ch in the SourceURL column of this dataset.
As said above, many important spanish newspapers have a different domain than .es, so I created my table, contrasting against it, and also filtering in gdelt by spanish domain. This is how to:

        SELECT 
        (
            CASE
                WHEN net.host(SOURCEURL) LIKE "%.ch" THEN "periódico Suizo"
                WHEN ( net.host(SOURCEURL) LIKE "%.es"
            OR 
                -- this are my private tables  
                net.host(SOURCEURL) IN (
                SELECT
                spanish_newspapers
                FROM
                `myproject_and_dataset.spanish_newspapers_SourceCommonName_160620`)
                
            OR 
                net.host(SOURCEURL) IN (
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


# 3. Results.

# 4. Conclusion.


# 5. Bibliography.

- https://www.reddit.com/r/gdelt/comments/g7tiyw/results_filtering_actorcountrycode/

- https://www.gdeltproject.org/


-------------------------
-------------------------


If it is of interest:
 
Automated ETL in Google Cloud Monitoring Google Searches, Twitter and news media in Spain:

![alt](pics/automated_dashboard_preview.gif)

- Repo => https://github.com/albertovpd/automated_etl_google_cloud-social_dashboard

- Dashboard => https://datastudio.google.com/u/0/reporting/755f3183-dd44-4073-804e-9f7d3d993315/page/LrATB


