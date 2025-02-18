# Reporteria de tablas en R a LaTeX y Otros

# librerias

library(tidyverse)
library(stargazer)
library(fixest)
library(modelsummary)
library(palmerpenguins)

# cargar mtcars

data(mtcars)

# stargazer puede hacer una tabla de estadistica descriptiva:


stargazer(mtcars, type = "text", summary = TRUE, median = T)


stargazer(mtcars, type = "text", summary = TRUE, out = "outputs/mtcars_descriptivo.txt")


stargazer(mtcars, type = "latex", summary = TRUE, out = "outputs/mtcars_descriptivo.tex", median = T)

# para una tabla de regresion:

model1 <- lm(mpg ~ hp + am + carb, data = mtcars)

model2 <- lm(mpg ~ hp + am + am^2 + carb, data = mtcars)

summary(model1)

fe_model <- feols(mpg ~ hp + am + carb|cyl, data = mtcars)

fe_model

# tabla: 

stargazer(list(model1, model2), type = "text")

# Modelsummary ------------------------------------------------------------

# Datasummary_skim

# resumen rapido de cualquier dataset

datasummary_skim(mtcars,
                 output = "outputs/datasummary_skim_ejemplo.tex",
                 fun_numeric = list(Unique = NUnique, `Missing Pct.` = PercentMissing, Mean = Mean, SD =
                                      SD, Min = Min, Median = Median, Max = Max),
                 booktabs = T)

datasummary_df(mtcars) # solo genera una tabla de el dataframe (no tiene estadistica descriptiva)

# datasummary_correlation

datasummary_correlation(mtcars)

# crosstabs (tabulacion cruzada)

data(penguins)

datasummary_crosstab(species ~ island, data = penguins)

# datasummary

mtcars[1,1] <- NA # introducir NAs como ejemplo

# utilizaar parentesis para cambiar nombres en la tabla

datasummary(mpg + hp ~ (`Avg` = Mean) + (`Std.Dev` = SD) + Min + Median + Max, data = mtcars)

# como crear estadistica descriptiva "agrupada"

datasummary(mpg ~ (Mean + SD)*as.factor(cyl), data = mtcars,
            title = "Estadistica descriptiva de mpg por cyl",
            notes = "Calculos por LIDE",
            output = "outputs/datasummary_ejemplo_mtcars_agrupada.tex")

# Modelsummary para resultados de regresion.

modelsummary(list(model1, model2, fe_model),
             output = "outputs/ejemplo_modelsummary.tex",
             gof_omit = "AIC|BIC|RMSE")

model3 <- lm(mpg ~ cyl + disp + hp + hp^2 + drat + log(wt) + qsec + vs + am + gear +carb, data = mtcars)


modelsummary(list(model1, model2, model3,fe_model),
             gof_omit = "AIC|BIC|RMSE|r.squared|logLik|r2.within",
             coef_rename = c("hp" = "Gross horsepower", "am" = "Transmission (categorical)"),
             vcov = c("hc1", "hc1", "hc1", ~cyl),
             output = "outputs/ejemplo_modelsummary_long.tex",
             longtable = T)

