function C = Curvature2DAtt(Dipx, Dipy)


















% Z1 Z2 Z3
% Z4 Z4 Z6 
% Z7 Z8 Z9
% 
% ha = 1/12*[1 -2 1; 1 -2 1; 1 -2 1]; 
% hb = 1/12*[1 1 1; -2 -2 -2; 1 1 1];
% hc = 1/4*[-1 0 1;0 0 0;1 0 -1]; 
% hd = 1/6*[-1 0 1;-1 0 1;-1 0 1]; 
% he = 1/6*[1 1 1; 0 0 0; -1 -1 -1]; 
% hf = 1/9*[-1 2 -1; 2 5 2; -1 2 -1]; 
% 
% a = conv2(X,ha,'valid');
% b = conv2(X,hb,'valid');
% c = conv2(X,hc,'valid');
% d = conv2(X,hd,'valid');
% e = conv2(X,he,'valid');
% f = conv2(X,hf,'valid');


%C = atan(sqrt(d.^2+e.^2)); 

% C = (a.*(1+e.^2)+b.*(1+d. n^2)-c.*d.*e)./(1+d.^2+e.^2).^(3/2); 

end 