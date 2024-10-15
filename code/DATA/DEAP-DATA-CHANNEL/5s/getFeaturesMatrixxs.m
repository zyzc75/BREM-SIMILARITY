% 切割长度未 splitSize 秒的信号所提取的特征。 

length = 7680;
splitSize = 5;  % 代表切片时间为5s
FS = 128;
N = length / (splitSize * FS);
% featuresMatrixSplit = cell(1,N);
for m = 1 : N
    data = splitdata{1,m};
    featuresMatrix = cell(1,32);
    for i = 1 : 32
        % 遍历32个人
        for j = 1 : 40 
        % 遍历每个人的每次实验
           eeg_channels = data{i,j};
           parfor k = 1 : 32
           % 遍历32个通道   
               eeg = eeg_channels(:,k)'; 
               featuresMatrixTemp{j,k} = getFeatures(eeg); 
           end
        end
    
        featuresMatrix{1,i} = featuresMatrixTemp;
    end
    featuresMatrixSplit{1,m} = featuresMatrix;
end


