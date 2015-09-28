######## rfNews() to get news about this package

# sample(x, size, replace = FALSE, prob = NULL)
ind <- sample (2, 
              nrow (iris), 
              replace = TRUE,   # previously selected items can be chosen again.
              prob = c(0.7,0.3)) # prob argument can be used to give a vector of weights for obtaining the elements of the vector being sampled

# peek the value: they are 118 of '1's and '2's 
ind

trainData <- iris[ ind == 1, ]
testData <- iris[ ind == 2 , ]

library( randomForest )

# observe your data !!
iris

# predict species based on the other 4 variables in records.
iris_rf <- randomForest( Species ~ . , 
                         mtry = 4,
                         data = trainData, 
                         ntree = 130, 
                         proximity = TRUE )

# print only table
table( predict( iris_rf ), trainData$Species )

# summary of result, incl confusion matrix
print(iris_rf)

# Graph of ntree against Error, it shows you optimized ntree argument.
plot(iris_rf)

# This is the extractor function for variable importance measures as produced by randomForest
importance(iris_rf)

# Dotchart of variable importance as measured by a Random Forest
varImpPlot(iris_rf)

# Try to build random forest for testing data
irisPred <- predict ( iris_rf, newdata = testData )

table ( irisPred, testData $ Species )

# See the margin, positive / negtive 
plot ( margin( iris_rf, testData $ Species ))

### Tune RF

# display OOB Error
# See document, type '?tune.RF' in console


tune.rf <- tuneRF (iris[ , -5],    # x, matrix or data frame of predictor vars
                   iris[, 5],      # y, response vector
                   stepFactor = 0.5) # each iteration increased by

# Hold on, what is this ?
iris[ , -5]

# last column
iris[ , 5]

print(tune.rf)

plot(tune.rf) 

# mtry   OOBError
# 1.OOB    1 0.04666667
# 2.OOB    2 0.04000000
# 4.OOB    4 0.04000000

## TODO: in RStudio, right panel'environment'
# click iris_rf to view all the variables / parameters
# find clues relate to 'mtry'

# error rate: 3.77 %

