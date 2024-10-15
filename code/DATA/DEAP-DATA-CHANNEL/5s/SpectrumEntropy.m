function spectral_entropy = SpectrumEntropy(EEG_signal,Hz)

    % 步骤 2: 计算功率谱密度 (PSD)
    % 使用 pwelch 方法计算 PSD
    [pxx, f] = pwelch(EEG_signal, [], [], [], Hz); % 1 表示采样频率
    
    % 步骤 3: 归一化功率谱密度
    pxx = pxx / sum(pxx);
    
    % 步骤 4: 计算频谱熵
    spectral_entropy = -sum(pxx .* log(pxx + eps)); % 加上 eps 以避免 log(0)


end

