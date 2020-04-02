# Eloquent.researcher

Detta R-paket är skapat för internt bruk inom Humlab DigiTal vid Umeå Universitet.

Paketets primära syfte är att dra in paket som användaren kommer att behöva ha tillgång till inom infrastrukturen, samt att sätta upp standardiserade globala variabler på ett sätt som gör att forskaren direkt kan arbeta mot en Emu-databas när paketet laddats.

Paketet utgår ifrån den grundläggande biblioteksstruktur som används inom Humlab DigiTal. Ett project [mittprojekt] kommer att ha följande katalogstruktur:

> mittprojekt
> mittprojekt/Data
> mittprojekt/Dokument
> mittprojekt/Program
> mittprojekt/Resultat

där var och en av dessa kataloger har en definierad funktion i vilka av projektets filer de ska innehålla. I Data läggs insamlat material, och där ska också Emu-databasen ligga. R-program ska dock skapas och köras ifrån Program-katalogen. Ett kort exempel följer här:

## Demonstration

För att förevisa paketet så skapas den grundläggande katalogstrukturen, och vi skapar också en Emu-databas. 
Den förutsätts finnas på plats när projektet ska analyseras i R & Emu.

```r
dir.create("~/Desktop/myproject/Data",recursive = TRUE)
dir.create("~/Desktop/myproject/Dokument")
dir.create("~/Desktop/myproject/Resultat")
dir.create("~/Desktop/myproject/Program")
library(emuR)
create_emuDB("myproject","~/Desktop/myproject/Data")
```
När nu paketet "eloquent.researcher" laddas så har användaren direkt tillgång till en Emu databas-referens (database handle) som kan användas för att utföra Emu-kommandon.

```r
setwd("~/Desktop/myproject/Program")
library("eloquent.researcher")
EMUDB
[1] "<emuDBhandle> (dbName = 'src', basePath = '[....]/Desktop/myproject/Data/src_emuDB')"
list_files(EMUDB)
```
som förstås i detta fall resulterar i en tom "tibble" (men inget fel). EMUDB kan nu användas för att söka i, och köra signalanalys på, en Emu-databas. 
