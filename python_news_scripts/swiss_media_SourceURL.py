import pandas as pd

#http://www.onlinenewspapers.com/switzerl.htm

# Googling, I realized the most important newspapers in Switzerland have the .ch domain. So I just will filter by that in Gdelt 
# and stop working on this list

swiss_list=[
    "https://www.20min.ch/",
    "https://www.24heures.ch/",
    "https://www.aargauerzeitung.ch/",
    "http://www.agefi.com",
    "https://www.andelfinger.ch/",
    "https://wn.com/Anglo_swiss/news",
    "https://www.appenzell24.ch/news.html",
    "https://www.bzbasel.ch/",
    "https://www.bazonline.ch/",
    "https://www.bauernzeitung.ch/",
    "https://www.beobachter.ch/",
    "https://www.bernerlandbote.ch/",
    "http://www.onlinenewspapers.com/switzerl.htm",
    "https://www.nzz.ch/",
    "https://www.tdg.ch/",
    "https://www.bernerzeitung.ch/",
    "https://www.aargauerzeitung.ch/",
    "https://www.bazonline.ch/",
    "https://www.24heures.ch/",
    "https://www.luzernerzeitung.ch/",
    "https://www.suedostschweiz.ch/",
    "https://www.lenouvelliste.ch/",
    "https://www.20min.ch/",
    "https://www.tagesanzeiger.ch/",
    "https://www.blick.ch/",
    "https://www.letemps.ch/",
    "https://www.lematin.ch/",
    "https://www.tagblatt.ch/",
    "https://www.derbund.ch/",
    "https://www.cdt.ch/",
    "https://www.woz.ch/",
    "https://lecourrier.ch/",
    "https://www.zsz.ch/",
    "https://www.bzbasel.ch/",
    "https://www.laliberte.ch/",
    "https://www.laregione.ch/",
    "https://www.bielertagblatt.ch/",

]

swiss_media=set(swiss_list)


newspapers=pd.DataFrame(swiss_list, columns=["swiss_media"])
newspapers.to_csv('../output/swiss_media_SourceURL.csv')