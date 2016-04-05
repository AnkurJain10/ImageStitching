function image_stitching(J, K, A)
    
    temp = A(1,3);
    A(1,3) = A(2,3);
    A(2,3) = temp;
    sizeJ = size(J);
    sizeK = size(K);
    
    xy(:,1) = round(A * [0; 0; 1]);
    xy(:,2) = round(A * [size(K,1); 0; 1]);
    xy(:,3) = round(A * [0; size(K,2); 1]);
    xy(:,4) = round(A * [size(K,1); size(K,2); 1]);
    minx = min(xy(1,:));
    miny = min(xy(2,:));
    c10 = 0;
    c01 = 0;
    if minx < 0
        c10 = minx;
    end    
    if miny < 0
        c01 = miny;
    end
    
    for i = 1:sizeJ(1)
        for j = 1:sizeJ(2)
            newI(i-c10, j-c01) = J(i,j);
        end
    end
    
    for i = 1:sizeK(1)
        for j = 1:sizeK(2)
            
            xy = round(A * [i; j; 1]);
            if xy(1) < sizeJ(1) && xy(2) < sizeJ(2)
                newI(xy(1)-c10, xy(2)-c01) = (newI(xy(1)-c10, xy(2)-c01)+K(i, j))/2;
            else
                newI(xy(1)-c10, xy(2)-c01) = K(i, j);
            end
            
        end
    end
    
    sizeI = size(newI);
   
    imshow(newI, [])
end
            
    
    
    
       