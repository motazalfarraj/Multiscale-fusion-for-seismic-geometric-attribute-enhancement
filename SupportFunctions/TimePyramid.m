function y = TimePyramid(x,direction)

switch direction
    case 'reduce'
        for i=1:size(x,2)
        y(:,i) = impyramid(x(:,i),'reduce');      
        end 
    case 'expand'
        for i=1:size(x,2)
        y(:,i) = impyramid(x(:,i),'expand');      
        end 
 

end 