#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Create a list of drug products with "Preismodell" from "Spezialitätenliste" and
# flag them with supplement data of SwissDRG
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Load libraries ----------------------------------------------------------

rm(list=ls(all=T))
library(tidyverse)
library(readxl)
library(stringi)
library(openxlsx)


# Define import parameters ------------------------------------------------

imports <- data.frame(
  file_names = c("./ZE.zip", "./Technisches_Begleitblatt.xlsx", "./Publications.xlsx"),
  url_names = c("https://www.swissdrg.org/download_file/view/5383/2330",
                "https://www.swissdrg.org/download_file/view/5323/2390",
                "https://www.spezialitaetenliste.ch/File.axd?file=Publications.xlsx")
)


# Download and extract files ----------------------------------------------

for (i in 1:3) {
  download.file(url = imports[i,"url_names"],
                destfile = imports[i,"file_names"],
                method = "libcurl",
                mode="wb")
}

unzip(imports[1,"file_names"], files = "ZE-EDV_V15.3_20251128-definitions.csv")


# Import data to environment ----------------------------------------------
df_supplements <- read_delim("./ZE-EDV_V15.3_20251128-definitions.csv", 
                             delim = "|", escape_double = FALSE, trim_ws = TRUE)

df_tech_begleitblatt <- read_excel(imports[2,"file_names"],
                                   sheet = 1, skip = 7, col_names = TRUE)

df_sl <- read_excel(imports[3,"file_names"], sheet = "Publications")
df_sl_pm_indication <- read_excel(imports[3,"file_names"], sheet = "PM Indikationen")


# Prepare data ------------------------------------------------------------

# Add more general supplement numbers
df_supplements$ZE <- str_split_i(df_supplements$ze, "[.]",1)
df_supplements$ZE_number <-as.numeric(str_split_i(df_supplements$ZE, "[-]",3))
# Modify version fornon technical name
df_supplements$ZE_version <- paste0(str_split_i(df_supplements$version, "[.]",1),".0")

# Filter supplements
df_supplements <- df_supplements %>% 
  filter(type == "A") %>% 
  select(ZE, ZE_number, ZE_version, atc_code = code, 
         ZE_Verabreichungsart= va,
         ZE_Zusatzangabe = za) %>% 
  unique()

# Only relevant data (Zusatzangabe)
df_tech_begleitblatt <- df_tech_begleitblatt %>% 
  select("Kürzel", ZE_Zusatzangabe_Bez = "Kürzel-Bezeichnung") %>% 
  filter(!is.na(`Kürzel`))

# Join data together to final list
sl_pm_supplements <- df_sl %>% 
  filter(!is.na(Preismodell)) %>% 
  inner_join(df_supplements, join_by(ATC == atc_code)) %>% 
  left_join(df_tech_begleitblatt, join_by(ZE_Zusatzangabe == `Kürzel`))

# Filter "PM Indikationen"
sl_pm_indication <- df_sl_pm_indication %>% 
  filter(`BAG-Dossier` %in% sl_pm_supplements$`BAG-Dossier`)


# Export data -------------------------------------------------------------

# Create Excel file
wb <- createWorkbook(title = "SL-Preismodelle und SwissDRG Zusatzentgelte")
# List of SL products
addWorksheet(wb, sheet = "SL PM und ZE")
writeData(wb, sheet = 1, x = sl_pm_supplements, startRow = 1)
conditionalFormatting(wb, sheet = 1, cols = 16, rows = 1:nrow(sl_pm_supplements), type = "duplicates")
# List of price model indications
addWorksheet(wb, sheet = "Gefilterte Indikationen")
writeData(wb, sheet = 2, x = sl_pm_indication, startRow = 1)
# Safe Excsl file
saveWorkbook(wb, "SL-Preismodelle und SwissDRG Zusatzentgelte.xlsx", overwrite = TRUE)


# Cleaning ----------------------------------------------------------------

file.remove("ZE.zip", "Technisches_Begleitblatt.xlsx", "Publications.xlsx",
            "ZE-EDV_V15.3_20251128-definitions.csv")
