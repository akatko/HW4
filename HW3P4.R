if (!requireNamespace("googledrive", quietly = TRUE)) install.packages("googledrive")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("lubridate", quietly = TRUE)) install.packages("lubridate")

library(googledrive)
library(ggplot2)
library(dplyr)
library(lubridate)


options(gargle_oauth_cache = TRUE)


drive_auth()


file_id <- "1b4nj83usmc3X1urhEkrbJTWkqvy8ABLF"
drive_download(as_id(file_id), path = "preprint_growth.rda", overwrite = TRUE)


file_path <- "preprint_growth.rda"


if (exists("preprint_growth")) {
  print(head(preprint_growth))
  
  biorxiv_growth <- preprint_growth %>%
    filter(archive == "bioRxiv") %>%
    filter(count > 0)
  
  preprints <- preprint_growth %>%
    filter(archive %in% c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")) %>%
    filter(count > 0) %>%
    mutate(archive = factor(archive, levels = c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")))
  
  preprints_final <- preprints %>% filter(date == ymd("2017-01-01"))
  

  ggplot(preprints) +
    aes(date, count, color = archive, fill = archive) +
    geom_line(linewidth = 1) +
    scale_y_continuous(
      limits = c(0, 600), expand = c(0, 0),
      name = "preprints / month",
      sec.axis = dup_axis(
        breaks = preprints_final$count,
        labels = c("arXiv q-bio", "PeerJ Preprints", "bioRxiv"),
        name = NULL
      )
    ) +
    scale_x_date(name = "year", 
                 limits = c(ymd("2014-01-01"), ymd("2017-01-01"))) +
    scale_color_manual(values = c("orchid", "slateblue", "gold"), 
                       name = NULL) +
    theme(legend.position = "none") +
    ggtitle("Preprint Growth Over Time")
} else {
  cat("preprint_growth object not found. Unable to create the plot.\n")
}

