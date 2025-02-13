# Reporteria de tablas en R a LaTeX y Otros

# librerias

library(tidyverse)
library(stargazer)

# cargar mtcars

data(mtcars)

# stargazer puede hacer una tabla de estadistica descriptiva:


stargazer(mtcars, type = "text", summary = TRUE)


stargazer(mtcars, type = "text", summary = TRUE, out = "outputs/mtcars_descriptivo.txt")


stargazer(mtcars, type = "latex", summary = TRUE, out = "outputs/mtcars_descriptivo.tex")
