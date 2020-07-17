# Credit-Default_Multiple-Logistic-Regression

# Project summary:
Predict whether an individual will default on his/her credit card, based on his/her annual income, outstanding balance, and status.
Determine the factors which influence the likelihood of default.
Calculate the probability of default of each individual.

# Data:
Using simulated data "default" from the ISLR package.
This dataset has 10,000 observations and 4 parameters:
  1. default: whether or not this observation has defaulted on his/her credit card.
  2. student: whether or not this observation is a student.
  3. balance: the outstanding balance of this observation.
  4. income: the annual income of this observation.
  
# Method & Technique:
Visualization techniques: Scatter Plot and Boxplot.
Analytical technique: Logistic Regression.
  1. The results only fall into two categories: Default/Yes/1 or NonDefault/No/0
  2. The number of observations is large comparing to parameters.
  3. Interpretable.

# Result:
After testing several thresholds, the "higher than 50%" yield the highest accuracy rate:
  1. Very low error rate on False Positive (Observations which did not default but incorrectly labeled as default): approximately 0.41%.
  2. Very high error rate on False Negative (Observation which did default, but incorrectly labeled as nondefault): approximately 68.47%
  3. High Overall accuracy: 97.32%; Low overall error rate: 2.68%
  4. Credit companies want to identify the high-risk individuals -> The high False Negative error rate of this model is unacceptable, despite the high overall accuracy.
