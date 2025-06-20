# Project transcripnomics J2P4 - Jasmijn Slager - BM2B
Transcriptomics inzetten om genetische aanwijzingen te vinden voor vroegtijdige herkenning van reumatoïde artritis


## Inhoud

- `Bronnen/` – Gebruikte bronnen
- `Data_RA_raw/` - De verkregen ruwe data van de casus patiënten
- `Figuren van R/` – De figuren die zijn verkregen uit de R analyse
- `Output bestanden van R/` - De bestanden die zijn verkregen uit de R analyse
- `CASUS in R` - Het gebruikte script in R 
- `Overzicht patiënten casus` - Overzicht info van patiënten van de casus in een tabel
- `README.md` - Het document om de tekst hier te genereren
- `flowschema` - Een flowschema van de gebruikte methode


## Inleiding

Reumatoïde artritis (RA) is een chronische, auto-immuunziekte die ontsteking veroorzaakt in gewrichten en kan leiden tot kraakbeen- en botbeschadiging. Symptomen zijn onder andere pijn, stijfheid en zwelling, met name bij seropositieve patiënten die auto-antilichamen zoals reumafactor (RF) en anti-CCP hebben. Seropositiviteit onderstreept het auto-immuunkarakter, maar verklaart niet volledig waarom RA ontstaat. [(bron.)](https://github.com/Jaroslager/transcripnomics/blob/main/Bronnen/Immunopathogenesis%20of%20rheumatoid%20arthritis.pdf).

Genetische factoren spelen een belangrijke rol bij het ontstaan van RA. Erfelijkheid heeft invloed op het risico om de ziekte te ontwikkelen, waarbij bij seropositieve RA genetische aanleg vaak een grotere rol speelt dan bij seronegatieve RA. Daarnaast kunnen omgevingsfactoren, zoals roken, infecties en blootstelling aan chemische stoffen, het risico verhogen door het immuunsysteem te beïnvloeden. [(bron.)](https://github.com/Jaroslager/transcripnomics/blob/main/Bronnen/Genetics%20of%20rheumatiod%20arthritis.pdf)

Een vroege diagnose is essentieel om blijvende gewrichtsschade te voorkomen, maar huidige methoden herkennen vaak pas ontsteking als deze al sterk aanwezig is. Behandeling richt zich op het onderdrukken van symptomen en ontsteking, maar biedt geen genezing. [(bron.)](https://github.com/Jaroslager/transcripnomics/blob/main/Bronnen/Management%20of%20RA%20An%20overview.pdf)

Om meer kennis over RA te ontwikkelen en uiteindelijk tot vroegere diagnose en behandeling te komen wordt er transcriptomics in dit onderzoek gebruikt. Hiermee wordt bepaald welke genen afwijkend tot expressie komen bij RA-patiënten.

## Methode

In dit onderzoek werd RNA-seq data geanalyseerd van synoviumbiopten afkomstig van vier RA-patiënten (ACPA-positief, diagnose >12 maanden) en vier gezonde controles (ACPA-negatief), gebaseerd op de dataset van Platzer et al. (2019). [(dataset)](https://github.com/Jaroslager/transcripnomics/blob/main/Bronnen/dataset.pdf) De ruwe sequencingdata werd uitgepakt en ingelezen in R.

Eerst werd een referentie-index opgebouwd met behulp van het Rsubread (2.20.0) package en het humane referentiegenoom GRCh38 (Homo_sapiens.GRCh38.dna.toplevel_1.fa). De reads werden vervolgens gemapt met de align() functie van Rsubread, waarna de BAM-bestanden werden gesorteerd met Rsamtools (2.22.0). Het tellen van reads per gen werd uitgevoerd met featureCounts(), waarbij gebruik werd gemaakt van de GTF-annotatie (Homo_sapiens.GRCh38.114.gtf).

Voor de differentiële genexpressieanalyse werd het DESeq2 (1.46.0) package toegepast. Genen met een significante adjusted p-waarde (< 0.05) en een absolute log2 fold change (≥ 1) werden verder onderzocht. Visualisatie van de resultaten werd gedaan met het EnhancedVolcano (1.24.0) package.

Vervolgens werden de significant gereguleerde genen onderworpen aan een Gene Ontology (GO) analyse met het goseq (1.58.0) package. Tot slot werd KEGG pathway-analyse uitgevoerd met behulp van het pathview (1.46.0) package, waarbij specifiek pathway hsa04612 (Antigen processing and presentation) werd gevisualiseerd.

<p align="center">
  <img src="flowschema .png" alt="flowschema" width="600"/> <p> 
</p>

## Resultaten

Door te kijken naar de transcripnomics in R werden er 29.407 genen geanalyseerd. Van de genen vertoonden 1.292 genen een significante expressieverandering (adjusted p-waarde < 0.05). Van deze genen waren er 270 significant verhoogd (log2FoldChange > 1) en 171 significant verlaagd (log2FoldChange < -1). De genen met de sterkste expressieveranderingen toonden een duidelijk onderscheid tussen RA-patiënten en controles.

<p align="center">
  <img src="Figuren van R/Volcano plot.png" alt="Volcano plot" width="500"/> <p> Figuur 1 : Volcano plot van differentiële genexpressie tussen RA-patiënten en gezonde controles. De x-as toont de log2 fold change en de y-as de –log10 van de adjusted p-waarde. Genen rechts zijn significant verhoogd tot expressie, genen links verlaagd. Kleuren geven significante regulatie aan (padj < 0.05).
</p>

In de volcano plot (Figuur 1) zijn de resultaten van de differentiële genexpressie-analyse weergegeven. Genen met een hogere expressie in RA-patiënten bevinden zich rechts, terwijl genen met een lagere expressie links staan. De hoogte van de punten geeft de mate van statistische significantie weer. Er waren zowel up- als down-gereguleerde genen met hoge significantie zichtbaar

<p align="center">
  <img src="Figuren van R/GO analyse enrichment analyse.png" alt="GO analyse" width="500"/> <p>Figuur 2 : Bubble plot van de top 15 verrijkte Gene Ontology (GO) termen. De x-as geeft de –log10 van de p-waarde weer, de y-as toont de GO-termen. Puntgrootte geeft het aantal betrokken genen aan, kleur representeert het type ontologie.
</p>

De Gene Ontology (GO) analyse identificeerde meerdere biologische processen die geassocieerd zijn met RA (Figuur 2). Hieruit kwamen vooral immuun-gerelateerde processen naar voren, zoals leukocyte migration, activation of immune response, adaptive immune response en antibody-dependent cellular cytotoxicity. 

<p align="center">
  <img src="Figuren van R/hsa04612.pathview.png" alt="KEGG pathview analyse" width="500"/> <p>Figuur 3 : KEGG pathway-visualisatie van "Antigen processing and presentation". De rood gemarkeerde genen hebben verhoogde expressie bij RA, en bij groen is dit verlaagd. Deze pathway speelt een centrale rol in de presentatie van antigenen aan het immuunsysteem.
</p>

De KEGG pathway-analyse van "Antigen processing and presentation" (hsa04612) liet zien dat meerdere genen binnen dit immuunproces differentieel tot expressie kwamen tussen RA-patiënten en gezonde controles (Figuur 3). Hierbij waren zowel verhoogd als verlaagd tot expressie komende genen zichtbaar.

## Conclusie

In dit onderzoek is met behulp van transcriptomics onderzocht welke genen en biologische processen afwijkend tot expressie komen bij RA-patiënten. Analyse van RNA-sequencing data uit synoviumbiopten van vier RA-patiënten en vier gezonde controles resulteerde in 1.292 genen met een significante expressieverandering. Van deze genen waren er 270 verhoogd en 171 verlaagd tot expressie.

De Gene Ontology-analyse identificeerde voornamelijk immuun-gerelateerde processen, waaronder leukocytenmigratie, activatie van immuuncellen en antilichaam-afhankelijke cytotoxiciteit. Daarbij werden zowel onderdelen van het aangeboren als adaptieve immuunsysteem in verhoogde mate tot expressie gebracht. Ook de KEGG pathway-analyse bevestigde dit patroon, met differentiële genactiviteit binnen het pathway “Antigen processing and presentation”, wat een centrale route in de immuunrespons is.

Deze resultaten bieden waardevolle moleculaire inzichten in de pathogenese van RA. Ze laten zien welke genen en immuunroutes betrokken zijn bij de ziekte en vormen een basis voor toekomstig onderzoek naar vroegtijdige diagnostiek en gerichte behandelingen.
