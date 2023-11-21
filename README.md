# Data visualization and storytelling

Materials for the "Data visualization and storytelling" PhD course, Fall 2023, University of Copenhagen

Teachers: Kaustubh Chakradeo, Jacob Curran-Sebastian, Neil Scheidwasser

## Setup
### Install R:
* What? A programming a language for statistical computing and graphics
* Download:
    * Windows: https://cran.r-project.org/bin/windows/base/R-4.3.1-win.exe
    * Mac (arm64; M1/M2 Macs): https://cran.r-project.org/bin/macosx/big-sur-arm64/base/R-4.3.1-arm64.pkg
    * Mac (x86): https://cran.r-project.org/bin/macosx/big-sur-x86_64/base/R-4.3.1-x86_64.pkg
    * Linux (Ubuntu): follow the instrcctions at https://cran.r-project.org/bin/linux/ubuntu/
* Follow the steps after running the executable file to install
* Check: open a terminal (in Windows, Command Prompt) and type ```R``` --> it should open an R console


### Install RStudio:
* What? An integrated development environment (IDE) for R.
* Go to the RStudio website: https://posit.co/download/rstudio-desktop/
* Scroll down and download the appropriate version depending on your OS.
* Check: open RStudio, and check that the R version is the same as the one you installed

### Install R Markdown:
* What? A framework to generate formated documents where text and code can be combined
* Installation:
    * In RStudio, type:

```R
install.packages('rmarkdown')
```
* Optional: use tinytex to generate PDFs using LaTeX
```R
install.packages('tinytex')
tinytex::install_tinytex()
```

### Install data viz packages
A basic setup with lots of packages for scientific computing and data visualisation is easy to install with the ```tidyverse``` package:

```R
install.packages('tidyverse')
```

If you prefer to keep your setup minimal, you can install all the required packages that we will use in this course:
Basic data analysis:
```R
install.packages('dplyr')
install.packages('hmisc')
```

For static visualisation
```R
install.packages('ggplot2')
install.packages('ggmap') # Maps
install.packages('daggity') # Networks
install.packages('pheatmap') # Heatmaps
install.packages('gridExtra') # Subplots
install.packages('RColorBrewer') # More colours!
```

For interactive visualisation:
```R
install.packages('plotly')
install.packages('shiny')
```