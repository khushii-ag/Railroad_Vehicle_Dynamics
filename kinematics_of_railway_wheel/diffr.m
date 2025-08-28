function dy_dx = diffr(f, x_val, L, y)
    % f is a function handle for the function to differentiate
    % x_val is the point at which to evaluate the derivative

    % Define a small perturbation
    h = 1e-6;  % Perturbation size
    
    % Compute the numerical derivative using finite difference
    dy_dx = (f(x_val + h, L, y) - f(x_val - h, L , y)) / (2 * h);
end