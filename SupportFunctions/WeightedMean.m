function y = WeightedMean(x)
w = 1./[1:size(x,3)];
w = w./sum(w); 
y = zeros(size(x,1),size(x,2)); 

    for i=1:length(w)
        y = y+ w(i)*x(:,:,i);
    end 
end 