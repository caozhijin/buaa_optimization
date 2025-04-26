if problem == 21
    
    for k=1:1:n
        r = mod(k,2);
        if r == 0
            x(k,1) = 1;
        else
            x(k,1) = -1.2;
        end
    end
    
elseif problem == 25
    
    for k=1:1:n
        x(k,1) = 1 - (k/n);
    end
    
elseif problem == 28
    
    for k=1:1:n
        h = 1/(n + 1);
        t = k*h;
        x(k,1) = t*(t-1);
    end

end