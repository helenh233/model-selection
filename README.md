# Forward Selection Algorithm in R

This forward selection algorithm allows users to perform stepwise addition of variables based on their preferences. The algorithm supports customizable options for variable selection based on adjusted R², AIC (Akaike Information Criterion), or BIC (Bayesian Information Criterion) criteria.

## Usage

Here's an example of how to use the forward selection algorithm:

```R
# Example data (replace 'crime' with your dataset)
data(crime)

# Run forward selection with AIC criteria
forwardSelection(
  criteria = "AIC",
  sample = crime,
  response = "CrimeRate",
  predictorList = c(
    "Age",
    "Southern",
    "Education",
    "Ex0",
    "LF",
    "Males",
    "Pop",
    "NW",
    "UE1",
    "UE2",
    "IncIneq"
  )
)
```

## Parameters

- **criteria**: The criteria for variable selection. Options include "adj R squared", "AIC", or "BIC".
- **sample**: The dataset to perform forward selection on.
- **response**: The name of the response variable in the dataset.
- **predictorList**: A vector containing the names of predictor variables to consider in the forward selection.
