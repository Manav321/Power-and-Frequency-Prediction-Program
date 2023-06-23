clc;
clear all;
close all;
raw = readtable('Historical_Data.xlsx', 'Sheet','Sheet1', 'VariableNamingRule','preserve');
times = raw(:,1).Variables;
times = rmmissing(times);
data = raw(:,2:4).Variables;
%data = str2double(rmmissing(data));
data = data';


% Creating the datetime array
startTime = datetime('2021-10-01 00:00:00');
endTime = datetime('2023-06-16 23:45:00');
timeData = startTime:minutes(15):endTime;
timeData = timeData';


figure;
subplot(3, 1, 1)
plot(data(1,:));
xlabel("Time Stamp")
ylabel("Frequency")
title("Frequency data")

subplot(3, 1, 2)
plot(timeData(:,1),data(2,:), 'color', 'red');
xlabel("Time Stamp")
ylabel("Scheduled Generation")
title("Scheduled Generation Data")

subplot(3, 1, 3)
plot(timeData(:,1),data(3,:), 'color', 'green');
xlabel("Time Stamp")
ylabel("Actual Generation")
title("Actual Generation Data")



numInput = 3;
colOutput = 2;
numChannels = size(data,1);

%%% partition dataset into training and testing set -- 80%:10% of the data
numTimeStepsTrain = floor(0.8*size(data,2));
dataTrain = data(:,1:numTimeStepsTrain);
dataTest = data(:,numTimeStepsTrain+1:end);
%timeDataTest = timeData(numTimeStepsTrain+1:end,:);

%%% mean and std of training dataset
muX = mean(dataTrain(:,1:end-3),2);
sigX = std(dataTrain(:,1:end-3),0,2);
muY = mean(dataTrain(colOutput,4:end),2);
sigY = std(dataTrain(colOutput,4:end),0,2);

%%% normalization of training set

XTrain = (dataTrain(:,1:end-3)-muX)./sigX;
YTrain = (dataTrain(colOutput,4:end)-muY)./sigY;                             

%% configuring the NN
layers = [
    sequenceInputLayer(numChannels)
    lstmLayer(256)
    fullyConnectedLayer(1)
    regressionLayer];

options = trainingOptions("adam",...      
    MaxEpochs=200,...
    InitialLearnRate=0.005,...
    ExecutionEnvironment="gpu",...
    SequencePaddingDirection="left", ...
    Shuffle="every-epoch", ...
    Plots="training-progress", ...
    Verbose=1);

%%% training
net = trainNetwork(XTrain,YTrain,layers,options);

save("lstm_45-min_nnet.mat", "net");
