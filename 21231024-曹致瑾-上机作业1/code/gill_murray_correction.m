%函数，对当前x的hesse矩阵进行gill-murry修正，返回gill_murry修正后的当前点的hesse矩阵

function result = gill_murray_correction(G,n) %G为该点以及代值进去的矩阵,该函数适用于二阶矩阵的情况
    D = zeros(n,n);
    L = eye(n,n);
    C = ones(n,n);
    
    r = max(diag(G));%取G对角元的最大值
    
    u = 1e-16;%机器精度
    
    max_nodiag = G(1,2);%取G非对角元的最大值
    for c = 1:1:n
        for d = 1:1:n
            if (c ~= d) && G(c,d) > max_nodiag
                max_nodiag = G(c,d);
            end
        end    
    end
    
    beta_2 = max([r,max_nodiag/sqrt(n^2 -1),u]);
    beta = sqrt(beta_2);
    delta = u*max(r + beta,1); %修正gill_murray参数
    
    for c=1:1:n
        if c == 1
            D(1,1) = max(G(1,1),delta);
        else
            a = 0;
            for d=1:1:c-1
                a =  a + C(c,d)*L(c,d);
            end 
            D(c,c) = max(G(c,c) - a,delta);
        end
        
        if c ~= n
            if c == 1
                for k=2:1:n
                    C(k,c) = G(k,c);
                end
            else
                for k=c+1:1:n
                    b = 0;
                    for t=1:1:c-1
                        b = b + G(k,t)*L(c,t);
                    end
                    C(k,c) = G(k,c) - b;
                end
            end
            
            theta(c) = max(abs(C(c+1:n,c)));
            D(c,c) = max(D(c,c),(theta(c)/beta)^2);
            
            for d=c+1:1:n
                L(d,c) = C(d,c)/D(c,c);
            end
        end
    end  
    result = L*D*(L');
end