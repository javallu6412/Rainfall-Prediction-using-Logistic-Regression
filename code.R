\# Example data

weather\_data = read.csv("C:/Users/javal/Downloads/weather\_forecast\_data.csv")



\# Convert 'rain' column to a binary variable (1 for "rain", 0 for "no rain")

weather\_data$rain\_or\_not = ifelse(weather\_data$Rain == "rain", 1, 0)



\# Assign higher weight to the "rain" class to address the imbalance

\# Higher weight for "rain" (rain\_or\_not = 1), lower weight for "no rain" (rain\_or\_not = 0)

weights = ifelse(weather\_data$rain\_or\_not == 1, 3, 1)  # Adjust weight as needed



\# Split data into training and test sets (80-20 split)

set.seed(123)  # For reproducibility

sample\_index = sample(1:nrow(weather\_data), size = 0.8 \* nrow(weather\_data))

train\_data = weather\_data\[sample\_index, ]

test\_data = weather\_data\[-sample\_index, ]



\# Train the logistic regression model with weights

logistic\_model = glm(rain\_or\_not \~ Temperature + Humidity + Wind\_Speed + Cloud\_Cover + Pressure,

&#x20;                     data = train\_data, family = binomial, weights = weights\[sample\_index])



\# Predict probabilities on the test set

predicted\_probs = predict(logistic\_model, newdata = test\_data, type = "response")



\# Use a lower threshold to increase sensitivity to the "rain" class

threshold = 0.3  # Adjust as needed based on evaluation metrics

predicted\_class = ifelse(predicted\_probs > threshold, 1, 0)



par(mfrow = c(2, 2))



\#Scatter Plot

plot(predicted\_probs, test\_data$rain\_or\_not, 

&#x20;    xlab = "Predicted Probability of Rain", 

&#x20;    ylab = "Actual Rain (0 = No, 1 = Yes)", 

&#x20;    main = "Scatter Plot: Predicted vs. Actual Rain",

&#x20;    pch = 19, 

&#x20;    col = "blue")



\# Optionally, add a horizontal line at 0.5 (for classification threshold)

abline(h = 0.3, col = "red", lty = 2)



\# Evaluate the model: Accuracy

accuracy = mean(predicted\_class == test\_data$rain\_or\_not)

cat("Accuracy:", accuracy, "\\n")



\# Display predicted rain status (Rain or No Rain)

rain\_status = ifelse(predicted\_class == 1, "Rain", "No Rain")



data.frame(rain\_status)



\# Confusion Matrix

conf\_matrix = table(Actual = test\_data$rain\_or\_not, Predicted = predicted\_class)

print("Confusion Matrix:")

print(conf\_matrix)



\# Calculate Precision, Recall, and F1-Score for evaluation

true\_positive = conf\_matrix\[2, 2]

false\_positive = conf\_matrix\[1, 2]

false\_negative = conf\_matrix\[2, 1]



precision = true\_positive / (true\_positive + false\_positive)

recall = true\_positive / (true\_positive + false\_negative)

f1\_score = 2 \* (precision \* recall) / (precision + recall)



cat("Precision:", precision, "\\n")

cat("Recall:", recall, "\\n")

cat("F1-Score:", f1\_score, "\\n")



\# Plotting the predicted probabilities and actual results for visualization



\# 1. Scatterplot for Temperature vs Predicted Probability of Rain

\# Generate a sequence of temperatures for plotting the logistic curve

temp\_seq = data.frame(Temperature = seq(min(test\_data$Temperature), max(test\_data$Temperature), length.out = 100))



\# Ensure that other variables have a default value (mean or any fixed value) in `temp\_seq`

temp\_seq$Humidity = mean(test\_data$Humidity, na.rm = TRUE)

temp\_seq$Wind\_Speed = mean(test\_data$Wind\_Speed, na.rm = TRUE)

temp\_seq$Cloud\_Cover = mean(test\_data$Cloud\_Cover, na.rm = TRUE)

temp\_seq$Pressure = mean(test\_data$Pressure, na.rm = TRUE)



\# Predict probabilities for this sequence of temperatures

temp\_seq$predicted\_prob = predict(logistic\_model, newdata = temp\_seq, type = "response")



\# Plot actual data points (temperature vs rain\_or\_not) and logistic regression line

plot(test\_data$Temperature, test\_data$rain\_or\_not, 

&#x20;    xlab = "Temperature", 

&#x20;    ylab = "Rain or No Rain (1 = Rain, 0 = No Rain)", 

&#x20;    main = "Probability of Rain vs Temperature",

&#x20;    pch = 16, col = ifelse(test\_data$rain\_or\_not == 1, "blue", "red"))



\# 2. Scatterplot for Humidity vs Predicted Probability of Rain

\# Generate a sequence of humidities for plotting the logistic curve

Hum\_seq = data.frame(Humidity = seq(min(test\_data$Humidity), max(test\_data$Humidity), length.out = 100))



\# Ensure that other variables have a default value (mean or any fixed value) in `temp\_seq`

Hum\_seq$Temperature = mean(test\_data$Temperature, na.rm = TRUE)

Hum\_seq$Wind\_Speed = mean(test\_data$Wind\_Speed, na.rm = TRUE)

Hum\_seq$Cloud\_Cover = mean(test\_data$Cloud\_Cover, na.rm = TRUE)

Hum\_seq$Pressure = mean(test\_data$Pressure, na.rm = TRUE)



\# Predict probabilities for this sequence of temperatures



Hum\_seq$predicted\_prob = predict(logistic\_model, newdata = temp\_seq, type = "response")



\# Plot actual data points (temperature vs rain\_or\_not) and logistic regression line

plot(test\_data$Humidity, test\_data$rain\_or\_not, 

&#x20;    xlab = "Humidity", 

&#x20;    ylab = "Rain or No Rain (1 = Rain, 0 = No Rain)", 

&#x20;    main = "Probability of Rain vs Humidity",

&#x20;    pch = 16, col = ifelse(test\_data$rain\_or\_not == 1, "blue", "red"))



\# 3. Confusion Matrix Plot

barplot(conf\_matrix, beside = TRUE, col = c("lightblue", "lightgreen"),

&#x20;       legend = c("Predicted No Rain", "Predicted Rain"),

&#x20;       names.arg = c("No Rain (Actual)", "Rain (Actual)"),

&#x20;       main = "Confusion Matrix", ylab = "Count")



