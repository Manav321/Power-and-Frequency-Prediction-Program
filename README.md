# Power and Frequency Prediction Models
 LSTM Model to Predict the Scheduled Power Generation by taking Frequency, Scheduled Generation, and Actual Generation as inputs saved in Historical Data. Three Models are there to predict Scheduled Power at 15mins and 45 mins and Frequency at 15 mins.
 
 Training data is readily available from [Uttar Pradesh State Load Despatch Centre](https://www.upsldc.org/real-time-data).

# Power Prediction Program
 In context, Frequency is of Electrical Grid, Scheduled Generation is the power that is to be maintained by the Plant considering Power demand and numerous other factors, Actual generation is the power that the Plant is actually generating, and Block is the number given to time periods of 15 mins starting from 00:00 hours. 
 
 The Program Scraps the real-time data from [Uttar Pradesh State Load Despatch Centre](https://www.upsldc.org/real-time-data). It uses the Power and Frequency Prediction Models to Predict the value of Scheduled Power Generation and Frequency. UI figure displays the graph and a table that refreshes every value. The Graphs displaying Frequency and Power can be interchanged by the tab group If there is any change in the value (In context to Power) from the last (i.e., the program suggests a change in value), the corresponding row of the value is displayed in red color, and if there is no change, the corresponding row is shown in green color. The Prediction value shown on top is at 45 mins.
