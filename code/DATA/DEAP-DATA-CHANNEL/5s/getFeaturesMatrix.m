featuresMatrix = cell(1,32);
featuresMatrixTemp = cell(40,32);    % 32个人，40次实验，32个通道
for i = 1 : 1
    % 遍历32个人
    for j = 1 : 1 
    % 遍历每个人的每次实验
       eeg_channels = data{i,j};
       for k = 1 : 1
       % 遍历32个通道   
           eeg = eeg_channels(:,k)'; 
           featuresMatrixTemp{j,k} = getFeatures(eeg,128); 
       end
    end

    featuresMatrix{1,i} = featuresMatrixTemp;
end


