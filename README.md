# Power and Frequency Prediction Models

This project involves the development of LSTM models to predict scheduled power generation and frequency based on historical data. The repository includes three models for predicting scheduled power generation at 15 minutes, scheduled power generation at 45 minutes, and frequency at 15 minutes. These models utilize inputs such as frequency, scheduled generation, and actual generation.

## Overview

In this project, we utilize LSTM neural networks to predict scheduled power generation and frequency in an electrical grid context. The models take into account factors such as frequency, scheduled generation, and actual generation to make accurate predictions. The training data is sourced from the Uttar Pradesh State Load Despatch Centre and provides historical information to train the models effectively.

## Features

- **Scheduled Power Generation Prediction**: The model predicts scheduled power generation at 15 minutes and 45 minutes intervals.

- **Frequency Prediction**: The model predicts frequency at 15 minutes intervals.

- **Real-time Data Scrapping**: The program scrapes real-time data from the Uttar Pradesh State Load Despatch Centre to make accurate predictions.

- **User Interface**: The user interface displays graphs and tables that refresh with each new value.

- **Change Indication**: Rows are color-coded to indicate changes in scheduled power values. Red indicates a change, while green indicates no change.

- **Tab Group**: Graphs can be cycled between power data and frequency data from the tab group.

## Getting Started

1. Clone the Repository:

   ```bash
   git clone https://github.com/yourusername/power-frequency-prediction.git
   cd power-frequency-prediction
   ```

2. Explore the subdirectories to access the prediction models and main program.

## Usage

1. Review the code in the `lstm_1c_train_XX.m` and `lstm_1c_test_XX.m` to understand how the LSTM models have been created and tested.

2. Review the code in the `main.m` to understand how the LSTM models are implemented.

3. Run the main program `main.m` to fetch real-time data and visualize the predictions through graphs and tables.
