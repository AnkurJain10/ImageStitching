clear;
clc;
run('D:\Softwares\vlfeat-0.9.20-bin\vlfeat-0.9.20\toolbox\vl_setup');

I1 = imread('C:\Users\ANKUR\Pictures\Perception\mosaic1.png');
I1 = single(rgb2gray(I1)) ;
[f1,d1] = vl_sift(I1) ;
d1 = double(d1);

I2 = imread('C:\Users\ANKUR\Pictures\Perception\mosaic2.png');

I2 = single(rgb2gray(I2)) ;
[f2,d2] = vl_sift(I2) ;
d2 = double(d2);

ssd= zeros(size(f1,2),1);
feature = zeros(size(f2,2),5);
for i = 1:size(f2,2)
    min = 100000000;
    number = 10;
    for j = 1:size(f1,2)
        sum = 0;
        for k = 1:128
        	sum = sum + ((d1(k,j)-d2(k,i))*(d1(k,j)-d2(k,i)));
        end
        if sum < min
            min = sum;
            number = j;
        end
    end
    feature(i, 1)= f2(1, i);
    feature(i, 2)= f2(2, i);
    feature(i, 3)= f1(1, number);
    feature(i, 4)= f1(2, number);
    feature(i, 5)= min;
end

Y = sortrows(feature,5);
Y = transpose(Y);

X1 = Y(3:4, :);
X2 = Y(1:2, :);
X2(3, :) = 1;

max = 0;
Abest = zeros(2,3);
sum = zeros(1,1000);
for j = 1:300
    r = randi([1 size(f2,2)],1,3);
    p1 = Y(3:4, r);
    p2 = Y(1:2, r);
    A = affine_transformation(p1,p2);
    for i = 1:size(f2,2)
        newp1 = A*X2(:,i);
        Ap = norm(X1(:,i) - newp1);
        if Ap < 2
            sum(j) = sum(j) + 1 ;
        end
    end
    if sum(j)> max
        max = sum(j);
        Abest = A;
    end
end

for j = 1:300
    r = randi([1 size(f2,2)],1,3);
    p1 = Y(3:4, r);
    p2 = Y(1:2, r);
    A = affine_transformation(p1,p2);
    for i = 1:size(f2,2)
        newp1 = A*X2(:,i);
        Ap = norm(X1(:,i) - newp1);
        if Ap < 2
            sum(500+j) = sum(500+j) + 1 ;
        end
    end
    if sum(500+j)> max
        max = sum(500+j);
        Abest = A;
    end
end

max
Abest
sum = sort(sum, 'descend');
image_stitching(I1, I2, Abest)