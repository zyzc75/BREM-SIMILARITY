%% 模糊熵函数
function FuzEn = FuzzyEntropy(data,dim,r,n,tau)

if nargin == 4, tau = 1; end
if nargin == 3, n = 2; tau=1; end
if tau > 1, data = downsample(data, tau); end

N = length(data);
result = zeros(1,2);

for m = dim:dim+1
    count = zeros(N-m+1,1);
    dataMat = zeros(N-m+1,m);

    % 设置数据矩阵，构造成m维的矢量
    for i = 1:N-m+1
        dataMat(i,:) = data(1,i:i+m-1);
    end
    % 利用距离计算相似模式数
    for j = 1:N-m+1
        % 计算切比雪夫距离，不包括自匹配情况
        dataMat=dataMat-mean(dataMat,2);
        tempmat=repmat(dataMat(j,:),N-m+1,1);
        dist = max(abs(dataMat - tempmat),[],2);
        D=exp(-(dist.^n)/r);
        count(j) = (sum(D)-1)/(N-m);
    end
    result(m-dim+1) = sum(count)/(N-m+1);
end
    % 计算得到的模糊熵值
    FuzEn = log(result(1)/result(2));
end

