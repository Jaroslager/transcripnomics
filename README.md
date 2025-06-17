# Project transcripnomics J2P4
Transcriptomics inzetten om genetische aanwijzingen te vinden voor vroegtijdige herkenning van reumatoïde artritis


## Inhoud

- `Bronnen/` – Gebruikte bronnen
- `Data_RA_raw/` - De verkregen ruwe data van de casus patiënten
- `Figuren van R/` – De figuren die zijn verkregen uit de R analyse
- `Output bestanden van R/` - De bestanden die zijn verkregen uit de R analyse
- `CASUS in R` - Het gebruikte script in R 
- `Overzicht patiënten casus` - Overzicht info van patiënten van de casus in een tabel
- `README.md` - Het document om de tekst hier te genereren


## Inleiding

Reumatoïde artritis (RA) is een chronische, auto-immuunziekte die ontsteking veroorzaakt in gewrichten en kan leiden tot kraakbeen- en botbeschadiging. Symptomen zijn onder andere pijn, stijfheid en zwelling, met name bij seropositieve patiënten die auto-antilichamen zoals reumafactor (RF) en anti-CCP hebben. Seropositiviteit onderstreept het auto-immuunkarakter, maar verklaart niet volledig waarom RA ontstaat. [(bron.)](Bronnen/Immunopathogenesis-of-rheumatoid-arthritis.pdf)

Genetische factoren spelen een belangrijke rol bij het ontstaan van RA. Erfelijkheid heeft invloed op het risico om de ziekte te ontwikkelen, waarbij bij seropositieve RA genetische aanleg vaak een grotere rol speelt dan bij seronegatieve RA. Daarnaast kunnen omgevingsfactoren, zoals roken, infecties en blootstelling aan chemische stoffen, het risico verhogen door het immuunsysteem te beïnvloeden. [(bron.)](Bronnen/Genetics-of-rheumatiod-arthritis.pdf)

Een vroege diagnose is essentieel om blijvende gewrichtsschade te voorkomen, maar huidige methoden herkennen vaak pas ontsteking als deze al sterk aanwezig is. Behandeling richt zich op het onderdrukken van symptomen en ontsteking, maar biedt geen genezing. [(bron.)](Bronnen/Management-of-RA-An-overview.pdf)

Om meer kennis over RA te ontwikkelen en uiteindelijk tot vroegere diagnose en behandeling te komen wordt er transcriptomics in dit onderzoek. Hiermee wordt bepaald welke genen afwijkend tot expressie komen bij RA-patiënten en welke metabole routes anders functioneren.

## Methode

In dit onderzoek werden RNA-seq data geanalyseerd van synoviumbiopten afkomstig van vier RA-patiënten (ACPA-positief, diagnose >12 maanden) en vier gezonde controles (ACPA-negatief), gebaseerd op de dataset van Platzer et al. (2019). [(dataset)](Bronnen/dataset) De ruwe sequencingdata werden uitgepakt en ingelezen in R.

Eerst werd een referentie-index opgebouwd met behulp van het Rsubread package en het humane referentiegenoom GRCh38 (Homo_sapiens.GRCh38.dna.toplevel_1.fa). De reads werden vervolgens gemapt met de align() functie van Rsubread, waarna de BAM-bestanden werden gesorteerd met Rsamtools. Het tellen van reads per gen werd uitgevoerd met featureCounts(), waarbij gebruik werd gemaakt van de GTF-annotatie (Homo_sapiens.GRCh38.114.gtf).

Voor de differentiële genexpressieanalyse werd het DESeq2 package toegepast. Genen met een significante adjusted p-waarde < 0.05 en een absolute log2 fold change ≥ 1 werden verder onderzocht. Visualisatie van de resultaten werd gedaan met het EnhancedVolcano package.

Vervolgens werden de significant gereguleerde genen onderworpen aan een Gene Ontology (GO) analyse met het goseq package. Tot slot werd KEGG pathway-analyse uitgevoerd met behulp van het pathview package, waarbij specifiek pathway hsa04612 (Antigen processing and presentation) werd gevisualiseerd.

## Resultaten

Door te kijken naar de transcripnomics in R werden er 25.396 genen geanalyseerd. Van de genen vertoonden 1.292 genen een significante expressieverandering (adjusted p-waarde < 0.05). Van deze genen waren er 270 significant verhoogd (log2FoldChange > 1) en 171 significant verlaagd (log2FoldChange < -1). De genen met de sterkste expressieveranderingen toonden een duidelijk onderscheid tussen RA-patiënten en controles.

<p align="center">
  <img src="Figuren van R/Volcano plot.png" alt="Volcano plot" width="100"/> <p>Figuur 1: Volcano plot, een differentiële genexpressie-analyse
</p>

In de volcano plot (Figuur 1) zijn de resultaten van de differentiële genexpressie-analyse weergegeven. Genen met een hogere expressie in RA-patiënten bevinden zich rechts, terwijl genen met een lagere expressie links staan. De hoogte van de punten geeft de mate van statistische significantie weer. Er waren zowel up- als down-gereguleerde genen met hoge significantie zichtbaar

De Gene Ontology (GO) analyse identificeerde meerdere biologische processen die geassocieerd zijn met RA (Figuur 2). Hieruit kwamen vooral immuun-gerelateerde processen naar voren, zoals leukocyte migration, activation of immune response, adaptive immune response en antibody-dependent cellular cytotoxicity. 

De KEGG pathway-analyse van "Antigen processing and presentation" (hsa04612) liet zien dat meerdere genen binnen dit immuunproces differentieel tot expressie kwamen tussen RA-patiënten en gezonde controles (Figuur 3). Hierbij waren zowel verhoogd als verlaagd tot expressie komende genen zichtbaar.

## Conclusie

In dit onderzoek werd met behulp van transcriptomics onderzocht welke genen en biologische processen betrokken zijn bij reumatoïde artritis (RA). Analyse van RNA-sequencing data uit synoviumbiopten van RA-patiënten en gezonde controles toonde 1.292 genen met een significante expressieverandering, waarbij zowel op- als neer-regulatie werd waargenomen. Vooral immuun-gerelateerde processen, zoals leukocytenmigratie, activatie van de immuunrespons en antilichaam-afhankelijke cytotoxiciteit, kwamen sterk naar voren. De KEGG pathway-analyse liet zien dat ook het "Antigen processing and presentation" pathway betrokken is, wat aansluit bij de bekende auto-immuunmechanismen bij RA.

Binnen de significant differentieel tot expressie komende genen viel op dat zowel adaptieve als aangeboren immuunprocessen betrokken waren. Hierbij lijken verschillende onderdelen van de antigeenpresentatie, T-celactivatie en ontstekingsregulatie versterkt actief in RA-patiënten. De combinatie van verhoogde expressie van immuunactivatiegenen en verstoring van immuunregulatie wijst op dysregulatie  van het immuunsysteem bij RA.
