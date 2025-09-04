# Identifying Heat Vulnerables Communities in California through Data Driven Classification

## Project Outline  
Heatwaves are among the deadliest climate-related hazards, disproportionately affecting vulnerable communities.  
This project focuses on **classifying California ZIP codes by heat vulnerability** using socio-environmental and health indicators.  

Through **machine learning models**, we:  
- Identify high-risk areas  
- Rank influential features  
- Visualize patterns to support **targeted climate resilience and public health policies**  

### Objectives  
- Develop classification models to predict high-risk ZIP codes  
- Compare model performance using evaluation metrics  
- Identify and rank influential socio-environmental factors  
- Map vulnerability patterns for better decision-making  

## Tools & Libraries  
- **Data Processing:** dplyr, tidyr, readxl  
- **Visualization:** ggplot2, corrplot, patchwork, ggrepel  
- **Modeling:** caret, randomForest, rpart, nnet, pROC  
- **Mapping:** sf, tigris  
- **Interpretability:** pdp, feature importance plots  

## Dataset  
- **Source:** HHI Data 2024 - United States  
- **Subset:** California ZIP codes  
- **Features include:**  
  - *Demographic & Socioeconomic:* Poverty, uninsured population, education, disability, rental housing, vehicle access  
  - *Environmental:* Tree canopy, impervious surfaces, air quality (PM2.5, ozone)  
  - *Health Indicators:* Asthma, diabetes, COPD, obesity  
- **Target Variable:**  
  - `HIGH_RISK` - Binary label (1 = Top 25% most vulnerable ZIPs, 0 = otherwise)  

## Prediction Models  
We applied supervised learning models for binary classification:  

1. **Logistic Regression** - baseline linear model  
2. **Decision Tree (rpart)** - interpretable splitting rules  
3. **Random Forest** - ensemble method with strong predictive performance  
4. **Neural Network (nnet)** - capturing non-linear interactions  

### Model Evaluation  
- **Metrics:** Accuracy, Precision, Recall, F1-score, ROC-AUC  
- **Validation:** 10-fold cross-validation (`caret`)  
- **Interpretability Tools:** Feature importance plots, Partial Dependence Plots (PDPs)  

## Key Features Identified  
Top predictors of heat vulnerability included:  
- **PR_POV (Poverty Rate)**  
- **PR_UNINSUR (Uninsured Population)**  
- **PR_NOHSDP (No High School Diploma)**  
- **PR_TREEC (Tree Canopy Coverage)**  
- **PR_PM25 (Fine Particulate Matter)**  
- **PR_OZONE (Ozone Levels)**  

## Insights & Findings  
- High-risk ZIP codes have **higher poverty, worse air quality, and limited tree canopy**  
- **Random Forest** outperformed other models in accuracy and interpretability  
- **Tree canopy coverage** emerged as a strong protective factor  
- Both **socioeconomic inequities** and **environmental exposures** drive vulnerability  
- Spatial maps show clusters of risk in urban areas with high impervious surfaces  
