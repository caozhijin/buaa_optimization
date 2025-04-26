%脚本，加载所需要求解的问题函数及其初值

if problem == 1
    n = 2;
    m = 2;
    
    a=sym('a',[n,1]);
    f = sym('f',[n,1]);
    f(1) = 10*(a(2) - a(1)^2);
    f(2) = 1-a(1);
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a); %给出f，g，h
    
    x = zeros(n,1000);
    x(:,1) = [-1.2;1]; %初始点，第一行表示a1，第二行表示a2，列数表示迭代次数
    d = zeros(n,1000);
elseif problem == 2
    n = 2;
    m = 2;
    
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    f(1) = -13 + a(1) + ((5 - a(2))*a(2) - 2)*a(2);
    f(2) = -29 + a(1) + ((a(2) + 1)*a(2) - 14)*a(2);
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);

    x = zeros(n,1000);
    x(:,1) = [0.5;-2];
    d = zeros(n,1000);
elseif problem == 3
    n = 2;
    m = 2;
    
    a = sym('a',[n,1]);
    f = sym('f',[m,1]);
    f(1) = (10^4)*a(1)*a(2) - 1;
    f(2) = exp(-a(1)) + exp(-a(2)) - 1.0001;
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);

    x = zeros(n,1000);
    x(:,1) = [0;1];
    d = zeros(n,1000);
elseif problem == 4
    n = 2;
    m = 3;
    
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    f(1) = a(1) - 10^6;
    f(2) = a(2) - 2*10^(-6);
    f(3) = a(1)*a(2) - 2;
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);

    x = zeros(n,1000);
    x(:,1) = [1;1];
    d = zeros(n,1000);
elseif problem == 5
    n = 2;
    m = 3;
    
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    f(1) = 1.5 - a(1)*(1 - a(2));
    f(2) = 2.25 - a(1)*(1 - a(2)^2);
    f(3) = 2.625 - a(1)*(1 - a(2)^3);
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    x(:,1) = [1;1];
    d = zeros(n,1000);
elseif problem == 6
    n = 2;
    m = 10;
    
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    for k=1:1:m
        f(k) = 2 + 2*k - (exp(k*a(1)) + exp(k*a(2)));
    end
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    x(:,1) = [0.3;0.4];
    d = zeros(n,1000);

elseif problem == 21
    n = 10;
    m = 10;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    for k=1:1:m
        r = mod(k,2);
        if (r == 1)
            f(k) = 10*(a(k + 1) - a(k)^2);
        else
            f(k) = 1 - a(k - 1);
        end
    end
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    for k=1:1:n
        r = mod(k,2);
        if r == 0
            x(k,1) = 1;
        else
            x(k,1) = -1.2;
        end
    end
    d = zeros(n,1000);
elseif problem == 22
    n = 12;
    m = 12;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    for k=1:1:m
        r = mod(k,4);
        if r == 1
            f(k) = a(k) + 10*a(k+1);
        elseif r == 2
            f(k) = (5^0.5)*(a(k+1) - a(k+2));
        elseif r == 3
            f(k) = (a(k-1) - 2*a(k))^2;
        else
            f(k) = (10^0.5)*(a(k-3) - a(k))^2;
        end
    end
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    for k=1:1:n
        r = mod(k,4);
        if r == 1
            x(k,1) = 3;
        elseif r == 2
            x(k,1) = -1;
        elseif r == 3
            x(k,1) = 0;
        else
            x(k,1) = 1;
        end
    end
    d = zeros(n,1000);
elseif problem == 23
    n = 10;
    m = n + 1;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    for k=1:1:n
        c = 10^(-5);
        f(k) = (c^0.5)*(a(k) - 1);
    end
    t = 0;
    for k=1:1:n
        t = t + a(k)^2;
    end
    f(n + 1) = t - 0.25;
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    for k=1:1:n
        x(k,1) = k;
    end
    d = zeros(n,1000);
elseif problem == 26
    n = 8;
    m = 8;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    t = 0;
    for k=1:1:n
        t = t + cos(a(k));
    end
    for k=1:1:n
        f(k) = n - t + k*(1 - cos(a(k))) - sin(a(k));
    end
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    x(:,1) = ones(n,1)./n;
    d = zeros(n,1000);
elseif problem == 32
    n = 10;
    m = 10;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    t = 0;
    for k=1:1:n
        t = t + a(k);
    end
    for k=1:1:n
        f(k) = a(k) - 2*t/m - 1;
    end
    for k=n+1:1:m
        f(k) = - 2*t/m - 1;
    end
    
    f(a) = (norm(f))^2;
    g(a) = gradient(f,a);
    h(a) = hessian(f,a);
    
    x = zeros(n,1000);
    x(:,1) = ones(n,1);
    d = zeros(n,1000);
end
% 这里记一下绘图的方法
% [X,Y] = meshgrid(-0.5:0.01:0.5,-10:0.01:20);
% Z = (exp(-X) + exp(-Y) - 10001/10000)^2 + (10000*X*Y - 1)^2;
% surf(X,Y,Z);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');