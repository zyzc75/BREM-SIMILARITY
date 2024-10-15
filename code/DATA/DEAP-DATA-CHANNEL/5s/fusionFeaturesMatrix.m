N = 12;
for i = 1 : N
    for j = 1 : 32
        for k = 1 : 40
            
            for m = 1 : 32
                featuresMatrixSplit{1,i}{1,j}{k,m}(:,5) =  featuresMatrixSplit1{1,i}{1,j}{k,m}(:,5);
                featuresMatrixSplit{1,i}{1,j}{k,m}(:,6) =  featuresMatrixSplit1{1,i}{1,j}{k,m}(:,6);
            end
        
        end
    end
end