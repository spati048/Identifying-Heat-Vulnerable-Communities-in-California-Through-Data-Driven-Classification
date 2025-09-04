library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(DataExplorer)
library(corrplot)
library(readxl)


# Load the full HHI dataset
df <- read_excel("HHI_Data_2024_United_States.xlsx")  
View(df)

# Only keep rows where state(STATE) starts with 'CA'

df <- df %>% filter(STATE == "CA")

df <- df %>%
  select(STATE, ZCTA, OVERALL_RANK, 
         PR_POV, PR_UNINSUR, PR_NOHSDP, PR_ELP, PR_DISABL, PR_ODW,
         F_OBS, F_ASTHMA, F_DIABETES, F_COPD,
         PR_TREEC, PR_IMPERV, PR_MOBILE, PR_NOVEH, PR_RENT,
         PR_PM25, PR_OZONE)


# Clean missing values ONLY for numeric columns
df <- df %>%
  mutate(across(where(is.numeric), ~na_if(., -999)))

#Drop Rows with Missing Key Variables
df <- df %>%
  drop_na(PR_POV, PR_TREEC, PR_PM25, PR_OZONE)

#Create Binary Target Variables
df <- df %>%
  mutate(HIGH_RISK = ifelse(OVERALL_RANK >= 0.75, 1, 0))

#Summary Statistics for Key Features
summary(df %>% select(-STATE, -ZCTA))

# Data Visualisations

# Violin plot comparing Tree Canopy between High and Low Risk ZIP codes

ggplot(df, aes(x = factor(HIGH_RISK), y = PR_TREEC)) +
  geom_violin(fill = "lightgreen") +
  labs(
    title = "Tree Canopy Percentile by Heat Risk",
    x = "High Risk (1=Yes)",
    y = "Tree Canopy Percentile"
  ) +
  theme_minimal()

# Correlation Heatmap — Key Variables

# Select numeric predictors of interest
numeric_vars <- df %>% select(PR_POV, PR_UNINSUR, PR_TREEC, PR_IMPERV, PR_PM25, PR_OZONE)

# Correlation matrix
cor_matrix <- cor(numeric_vars, use = "complete.obs")

# Correlation heatmap
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.8,
         title = "Correlation Heatmap of Key Features")

# Density plot for PM2.5 percentile distribution
ggplot(df, aes(x = PR_PM25)) +
  geom_density(fill = "steelblue", alpha = 0.6) +
  labs(
    title = "Distribution of PM2.5 Pollution Across California ZIP Codes",
    x = "PM2.5 Pollution Percentile",
    y = "Density"
  ) +
  theme_minimal(base_size = 13)

ggplot(df, aes(x = factor(HIGH_RISK), y = PR_UNINSUR, fill = factor(HIGH_RISK))) +
  geom_boxplot(alpha = 0.7) +
  scale_fill_manual(values = c("0" = "gray70", "1" = "firebrick"), name = "High Risk") +
  labs(
    title = "Uninsured Population Percentile by Heat Risk Category",
    x = "High Risk (1 = Yes, 0 = No)",
    y = "Percentile of Uninsured Residents"
  ) +
  theme_minimal(base_size = 13)
