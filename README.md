# Project transcripnomics J2P4
Transcriptomics inzetten om genetische aanwijzingen te vinden voor vroegtijdige herkenning van reumatoïde artritis


## Inhoud

- `data/raw/` – fictionele datasets voor de analyse van spreuk effectiviteit, gevaar en welke spreuken het beste samengaan met verschillende types staf.
- `data/processed` - verwerkte datasets gegenereerd met scripts 
- `scripts/` – scripts om prachtige onzin te genereren
- `resultaten/` - grafieken en tabellen
- `bronnen/` - gebruikte bronnen 
- `README.md` - het document om de tekst hier te genereren
- `assets/` - overige documenten voor de opmaak van deze pagina
- `data_stewardship/` - Voor de competentie beheren ga je aantonen dat je projectgegevens kunt beheren met behulp van GitHub. In deze folder kan je hulpvragen terugvinden om je op gang te helpen met de uitleg van data stewardship. 

## Inleiding

Reumatoïde artritis (RA) is een chronische, auto-immuunziekte die ontsteking veroorzaakt in gewrichten en kan leiden tot kraakbeen- en botbeschadiging. Symptomen zijn onder andere pijn, stijfheid en zwelling, met name bij seropositieve patiënten die auto-antilichamen zoals reumafactor (RF) en anti-CCP hebben. Seropositiviteit onderstreept het auto-immuunkarakter, maar verklaart niet volledig waarom RA ontstaat.

Genetische factoren spelen een belangrijke rol bij het ontstaan van RA. Erfelijkheid heeft invloed op het risico om de ziekte te ontwikkelen, waarbij bij seropositieve RA genetische aanleg vaak een grotere rol speelt dan bij seronegatieve RA. Daarnaast kunnen omgevingsfactoren, zoals roken, infecties en blootstelling aan chemische stoffen, het risico verhogen door het immuunsysteem te beïnvloeden.

Een vroege diagnose is essentieel om blijvende gewrichtsschade te voorkomen, maar huidige methoden herkennen vaak pas ontsteking als deze al sterk aanwezig is. Behandeling richt zich op het onderdrukken van symptomen en ontsteking, maar biedt geen genezing.

Om meer kennis over RA te ontwikkelen en uiteindelijk tot vroegere diagnose en behandeling te komen wordt er transcriptomics in dit onderzoek. Hiermee wordt bepaald welke genen afwijkend tot expressie komen bij RA-patiënten en welke metabole routes anders functioneren.

## Methode

In dit onderzoek werden RNA-seq data geanalyseerd van synoviumbiopten afkomstig van vier RA-patiënten (ACPA-positief, diagnose >12 maanden) en vier gezonde controles (ACPA-negatief), gebaseerd op de dataset van Platzer et al. (2019). De ruwe sequencingdata werden uitgepakt en ingelezen in R.

Eerst werd een referentie-index opgebouwd met behulp van het Rsubread package en het humane referentiegenoom GRCh38 (Homo_sapiens.GRCh38.dna.toplevel_1.fa). De reads werden vervolgens gemapt met de align() functie van Rsubread, waarna de BAM-bestanden werden gesorteerd met Rsamtools. Het tellen van reads per gen werd uitgevoerd met featureCounts(), waarbij gebruik werd gemaakt van de GTF-annotatie (Homo_sapiens.GRCh38.114.gtf).

Voor de differentiële genexpressieanalyse werd het DESeq2 package toegepast. Genen met een significante adjusted p-waarde < 0.05 en een absolute log2 fold change ≥ 1 werden verder onderzocht. Visualisatie van de resultaten werd gedaan met het EnhancedVolcano package.

Vervolgens werden de significant gereguleerde genen onderworpen aan een Gene Ontology (GO) analyse met het goseq package. Tot slot werd KEGG pathway-analyse uitgevoerd met behulp van het pathview package, waarbij specifiek pathway hsa04612 (Antigen processing and presentation) werd gevisualiseerd.

## Resultaten

## Conclusie

