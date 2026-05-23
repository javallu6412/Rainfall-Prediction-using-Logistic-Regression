# Example data
weather_data = read.csv("weather_forecast_data.csv")

# Convert 'rain' column to a binary variable (1 for "rain", 0 for "no rain")
weather_data$rain_or_not = ifelse(weather_data$Rain == "rain", 1, 0)

# Display the dataset
View(weather_data) 

# Assign higher weight to the "rain" class to address the imbalance
# Higher weight for "rain" (rain_or_not = 1), lower weight for "no rain" (rain_or_not = 0)
weights = ifelse(weather_data$rain_or_not == 1, 3, 1)

# Split data into training and test sets (80-20 split)
set.seed(123)  # For reproducibility

sample_index = sample(1:nrow(weather_data),
                      size = 0.8 * nrow(weather_data))

train_data = weather_data[sample_index, ]
test_data  = weather_data[-sample_index, ]

# Train the logistic regression model with weights
logistic_model = glm(
  rain_or_not ~ Temperature + Humidity + Wind_Speed +
    Cloud_Cover + Pressure,
  data = train_data,
  family = binomial,
  weights = weights[sample_index]
)

# Predict probabilities on the test set
predicted_probs = predict(
  logistic_model,
  newdata = test_data,
  type = "response"
)

# Use a lower threshold to increase sensitivity to the "rain" class
threshold = 0.3

predicted_class = ifelse(predicted_probs > threshold, 1, 0)

par(mfrow = c(2, 2))

# Scatter Plot
plot(
  predicted_probs,
  test_data$rain_or_not,
  xlab = "Predicted Probability of Rain",
  ylab = "Actual Rain (0 = No, 1 = Yes)",
  main = "Scatter Plot: Predicted vs. Actual Rain",
  pch = 19,
  col = "blue"
)

# Add threshold line
abline(h = 0.3, col = "red", lty = 2)

# Evaluate the model: Accuracy
accuracy = mean(predicted_class == test_data$rain_or_not)

cat("Accuracy:", accuracy, "\n")

# Display predicted rain status
rain_status = ifelse(predicted_class == 1, "Rain", "No Rain")

data.frame(rain_status)

# Confusion Matrix
conf_matrix = table(
  Actual = test_data$rain_or_not,
  Predicted = predicted_class
)

print("Confusion Matrix:")
print(conf_matrix)

# Calculate Precision, Recall, and F1-Score
true_positive  = conf_matrix[2, 2]
false_positive = conf_matrix[1, 2]
false_negative = conf_matrix[2, 1]

precision = true_positive / (true_positive + false_positive)
recall    = true_positive / (true_positive + false_negative)

f1_score = 2 * (precision * recall) /
  (precision + recall)

cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F1-Score:", f1_score, "\n")

# =========================================================
# Plotting predicted probabilities and actual results
# =========================================================

# 1. Scatterplot for Temperature vs Probability of Rain

temp_seq = data.frame(
  Temperature = seq(
    min(test_data$Temperature),
    max(test_data$Temperature),
    length.out = 100
  )
)

# Assign default values to other variables
temp_seq$Humidity    = mean(test_data$Humidity, na.rm = TRUE)
temp_seq$Wind_Speed  = mean(test_data$Wind_Speed, na.rm = TRUE)
temp_seq$Cloud_Cover = mean(test_data$Cloud_Cover, na.rm = TRUE)
temp_seq$Pressure    = mean(test_data$Pressure, na.rm = TRUE)

# Predict probabilities
temp_seq$predicted_prob = predict(
  logistic_model,
  newdata = temp_seq,
  type = "response"
)

# Plot actual data points
plot(
  test_data$Temperature,
  test_data$rain_or_not,
  xlab = "Temperature",
  ylab = "Rain or No Rain (1 = Rain, 0 = No Rain)",
  main = "Probability of Rain vs Temperature",
  pch = 16,
  col = ifelse(test_data$rain_or_not == 1, "blue", "red")
)

# 2. Scatterplot for Humidity vs Probability of Rain

Hum_seq = data.frame(
  Humidity = seq(
    min(test_data$Humidity),
    max(test_data$Humidity),
    length.out = 100
  )
)

# Assign default values to other variables
Hum_seq$Temperature = mean(test_data$Temperature, na.rm = TRUE)
Hum_seq$Wind_Speed  = mean(test_data$Wind_Speed, na.rm = TRUE)
Hum_seq$Cloud_Cover = mean(test_data$Cloud_Cover, na.rm = TRUE)
Hum_seq$Pressure    = mean(test_data$Pressure, na.rm = TRUE)

# Predict probabilities
Hum_seq$predicted_prob = predict(
  logistic_model,
  newdata = Hum_seq,
  type = "response"
)

# Plot actual data points
plot(
  test_data$Humidity,
  test_data$rain_or_not,
  xlab = "Humidity",
  ylab = "Rain or No Rain (1 = Rain, 0 = No Rain)",
  main = "Probability of Rain vs Humidity",
  pch = 16,
  col = ifelse(test_data$rain_or_not == 1, "blue", "red")
)

# 3. Confusion Matrix Plot
barplot(
  conf_matrix,
  beside = TRUE,
  col = c("lightblue", "lightgreen"),
  legend = c("Predicted No Rain", "Predicted Rain"),
  names.arg = c("No Rain (Actual)", "Rain (Actual)"),
  main = "Confusion Matrix",
  ylab = "Count"
)
