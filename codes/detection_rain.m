function M_I = detection_rain(I,w)
% 
% Input arguments:
%       I -- the input image which must be a color image.
%       w -- the window size which must be a 2-D matrix whose row and
%            column must be both odd to ensure a center pixel.(e.g. w = [7 7])
%            
% Output arguments:
%     M_I -- the location map of I.
%

  [M,N,K] = size(I);
      row = w(1);
      col = w(2);
      w_k = row * col; % the number of the pixels covered by the window
      M_I = ones(M,N);
I_average = zeros(5,1);
      
for l = 1 : K
    for i = row : (M - row + 1) 
        for j = col : (N - col + 1)
            for k = 1 : 5
                
                switch k
                    case 1  %I(i,j) is located in the bottom-right of the window
                        
                        sum0 = 0;
                        for s = (i - row + 1) : i
                            for t = (j - col + 1) : j
                                sum0 = sum0 + I(s,t,l);
                            end
                        end
                        I_average(k) = sum0 / w_k;
                        
                    case 2  %I(i,j) is located in the bottom-left of the window
                        
                        sum0 = 0;
                        for s = (i - row + 1) : i
                            for t = j : (j + col -1)
                                sum0 = sum0 + I(s,t,l);                               
                            end
                        end
                        I_average(k) = sum0 / w_k;
                        
                    case 3  %I(i,j) is located in the center of the window
                    	
                        sum0 = 0;
                        for s = round((i - (row-1)/2)) : round((i + (row-1)/2))
                            for t = round((j - (col-1)/2)) : round((j + (col-1)/2))
                                sum0 = sum0 + I(s,t,l);                              
                            end
                        end
                        I_average(k) = sum0 / w_k;
                        
                    case 4  %I(i,j) is located in the top-right of the window
                        
                        sum0 = 0;
                        for s = i : (i + row - 1)
                            for t = (j - col + 1) : j
                                sum0 = sum0 + I(s,t,l);
                            end
                        end
                        I_average(k) = sum0 / w_k;
                        
                    case 5  %I(i,j) is located in the top-left of the window
                        
                        sum0 = 0;
                        for s = i : (i + row - 1)
                            for t = j : (j + col -1)
                                sum0 = sum0 + I(s,t,l);
                            end
                        end
                        I_average(k) = sum0 / w_k;
                end          
            end
            
            if (I(i,j,l) > I_average(1)) && (I(i,j,l) > I_average(2)) ...
                && (I(i,j,l) > I_average(3)) && (I(i,j,l) > I_average(4)) ...
                && (I(i,j,l) > I_average(5))
                M_I(i,j) = 0;
            else
                M_I(i,j) = 1;  
            end
          
        end
    end
end

