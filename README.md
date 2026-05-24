# Rainfall Prediction using Logistic Regression

<p>
  <img src="https://img.shields.io/badge/R-Programming+-blue">
  <img src="https://img.shields.io/badge/RStudion-IDE-red">
  <img src="https://img.shields.io/badge/DistilBERT-NLP-green">
  <img src="https://img.shields.io/badge/Machine_Learing-Logistic_Regression-yellow">
  <img src="https://img.shields.io/badge/Weather-Forecasting-blue">
  <img src="https://img.shields.io/badge/Data-Visualization-red">
  <img src="https://img.shields.io/badge/License-MIT-green">
</p>

> ### Probability and Statistics — VIT Chennai, November 2024
> **Joseph Alex Valluvassery**

---

## The Problem

Most traditional rainfall prediction systems rely on meteorological calculations, historical observations, or manual weather analysis. These approaches often struggle to accurately predict rainfall due to changing climate conditions and complex atmospheric patterns.

Rainfall forecasting is extremely important across agriculture, flood prevention, disaster management, and environmental monitoring systems. The real challenge is not just analyzing weather conditions — it is predicting rainfall occurrence accurately using weather parameters and historical data.

This project answers a different question than traditional forecasting systems:

> Not *“What does the weather look like?”*  
> But *“Based on weather conditions, will rainfall occur?”*

---

## What This Project Does

This project is a machine learning-based rainfall prediction system that:

1. Collects and analyzes historical weather data
2. Processes weather parameters using data preprocessing techniques
3. Uses Logistic Regression for rainfall classification
4. Predicts whether rainfall will occur based on weather conditions
5. Generates rainfall probability predictions from environmental data
6. Evaluates model performance using Accuracy, Precision, Recall, and F1-Score
7. Visualizes prediction results using scatter plots and confusion matrix analysis
8. Produces a complete rainfall prediction workflow using RStudio and Machine Learning

---

## How It Works

```text
Weather Dataset
        ↓
Data Preprocessing
(Missing Values + Binary Conversion)
        ↓
Feature Selection
(Temperature, Humidity, Wind Speed,
 Cloud Cover, Pressure)
        ↓
Train/Test Split (80:20)
        ↓
Logistic Regression Model
(Rainfall Classification)
        ↓
Rainfall Probability Prediction
        ↓
Threshold Adjustment
(0.3 Classification Threshold)
        ↓
Model Evaluation & Visualization
```

The system works using a machine learning workflow with multiple processing stages:

- **Data Collection Stage** — Loads historical weather data from CSV datasets

- **Preprocessing Stage** — Cleans the dataset and converts rainfall values into binary classes

- **Training Stage** — Trains the Logistic Regression model using weather parameters

- **Prediction Stage** — Generates rainfall probability predictions for testing data

- **Evaluation Stage** — Calculates Accuracy, Precision, Recall, F1-Score, and Confusion Matrix

The architecture enables efficient rainfall prediction using historical weather patterns and statistical machine learning techniques.

---
