# Power Prediciton Model
 LSTM Model to Predict the Scheduled Power Generation by taking Frequency, Scheduled Generation, and Actual Generation as inputs saved in Historical Data.
 
 My professors provided the training data, which is readily available from [Uttar Pradesh State Load Despatch Centre](https://www.upsldc.org/real-time-data).

# Power Prediction Program
 This Program Scraps the real-time data from [Uttar Pradesh State Load Despatch Centre](https://www.upsldc.org/real-time-data). It uses the Power Prediction Model to Predict the value of Scheduled Power Generation of 15-mins in the future.

 It has a UI figure displaying the graph and a table that refreshes every value. If there is any change in the value from the last (i.e., the program suggests a change in value), the corresponding row of the value is displayed in red color, and if there is no change, the corresponding row is shown in green color.
