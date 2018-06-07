clear
clc
close all

%% Input the test rain image
I = imread('test_rain3.jpg');
figure
subplot(2,2,1)
imshow(I)
title('The Origin Image')

%% Firstly detect rain
  I = double(I);
  w = [5 5];
M_I = detection_rain(I,w);
% w_k = w(1) * w(2);  %the number of the pixels covered by the window 

subplot(2,2,2)
imshow(M_I)
title('The Location Map of I')

%% I_M = I ¡ð M_I
[M N K] = size(I);
    I_M = zeros(M,N,K);
    
for l = 1 : K
    I_M(:,:,l) = I(:,:,l) .* M_I(:,:); 
end

I_M0 = uint8(I_M);
subplot(2,2,3)
imshow(I_M0)
title('The Hadamard Product of I and M_I')

%% Fill the holes of the I_M
I_mM = fill_the_hole(I_M,w);

I_mM0 = uint8(I_mM);
subplot(2,2,4)
imshow(I_mM0)
title('I_M')

%% Guided filter
I_L = imguidedfilter(I_mM0);
figure
imshowpair(I_mM0,I_L,'montage');


%%
I_L = double(I_L);
I_H = I - I_L;
I_H = uint8(I_H);
figure
imshow(I_H)











