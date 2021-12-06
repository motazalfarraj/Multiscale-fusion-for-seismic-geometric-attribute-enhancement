function temp = signedMax(x, dim)
a = max(x,[],dim); 
b = max(abs(x),[],dim);

temp = a.*(a==b) - b.*(a~=b); 

end 