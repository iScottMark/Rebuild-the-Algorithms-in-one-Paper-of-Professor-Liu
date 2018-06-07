function I_mM = fill_the_hole(I_M,w)
% 
% Input arguments:
%     I_M -- the output of the function 'detection_rain.m' 
%       w -- the window size which must be a 2-D matrix whose row and
%            column are both odd to ensure a center pixel.(e.g. w = [7 7])
%
% Output arguments:
%    I_mM -- the image after filling the holes through substituting 
%            the value of the dynamic pixel I_M(i,j) with the mean value 
%            of non-dynamic pixels in the patch centered at I_M(i,j).
%

[M,N,K] = size(I_M);
    row = w(1);
    col = w(2);

I_mM = I_M;

for l = 1 : K
    for i = row : (M - row + 1) 
        for j = col : (N - col + 1)
          
          if I_M(i,j,l) == 0
              
              sum0 = 0;
              num0 = 0;
              
              for s = round((i - (row-1)/2)) : round((i + (row-1)/2))
                 for t = round((j - (col-1)/2)) : round((j + (col-1)/2))
                     if I_M(s,t,l) > 0 
                        sum0 = sum0 + I_M(s,t,l);
                        num0 = num0 + 1;
                     end
                 end   
              end
              
              I_M_average = sum0 / num0;
              I_mM(i,j,l) = I_M_average;
         
          end
      end
   end
end