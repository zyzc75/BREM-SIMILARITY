function SSE = SingularSpectrumEntropy(EEG_signal,m,tau)

    
    % 步骤 2: 构建嵌入矩阵
    N = length(EEG_signal);
    X = zeros(N - (m-1)*tau, m);
    for i = 1:m
        X(:, i) = EEG_signal((1:N - (m-1)*tau) + (i-1)*tau);
    end
    
    % 步骤 3: 进行奇异值分解
    [U, S, V] = svd(X, 'econ');
    singular_values = diag(S);
    
    % 步骤 4: 归一化奇异值
    normalized_singular_values = singular_values / sum(singular_values);
    
    % 步骤 5: 计算奇异谱熵
    SSE = -sum(normalized_singular_values .* log(normalized_singular_values + eps));


end