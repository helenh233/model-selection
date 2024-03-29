forwardSelection <-
  function(criteria, sample, response, predictorList) {
    # Fit the intercept-only model to initialize criterion values
    interceptModel <-
      lm(reformulate(c("1"), response), data = sample)
    bestAdjRSquared = summary(interceptModel)$adj.r.squared
    bestAIC = AIC(interceptModel)
    bestBIC = BIC(interceptModel)
    
    addedPredictors <-
      c()  # Initialize an empty list for added predictors
    
    # Iteratively add predictors based on the chosen criterion
    while (TRUE) {
      bestPredictor <-
        c()  # Initialize an empty list for the best predictor
      
      # Iterate over potential predictors
      for (x in predictorList) {
        # Fit a model with the current set of added predictors and a potential new predictor
        model <-
          lm(reformulate(c(addedPredictors, x), response), data = sample)
        
        # Evaluate the chosen criterion and update the best predictor and its criterion value
        if (criteria == "adj R squared") {
          newAdjRSquared <- summary(model)$adj.r.squared
          if (newAdjRSquared > bestAdjRSquared) {
            bestAdjRSquared <- newAdjRSquared
            bestPredictor <- c(x)
          }
        } else if (criteria == "AIC") {
          newAIC <- AIC(model)
          if (newAIC < bestAIC) {
            bestAIC <- newAIC
            bestPredictor <- c(x)
          }
        } else if (criteria == "BIC") {
          newBIC <- BIC(model)
          if (newBIC < bestBIC) {
            bestBIC <- newBIC
            bestPredictor <- c(x)
          }
        }
      }
      
      # If adding more predictors does not improve criterion, return the final model
      if (length(bestPredictor) == 0 &
          length(addedPredictors) == 0) { # Intercept-only model
        return(lm(reformulate(c("1"), response), data = sample))
      } else if (length(bestPredictor) == 0) {
        return(lm(reformulate(addedPredictors, response), data = sample))
      }
      
      # Else, update the list of added predictors and remove the chosen predictor from the list
      addedPredictors <- c(addedPredictors, bestPredictor)
      predictorList <- setdiff(predictorList, bestPredictor)
    }
  }
