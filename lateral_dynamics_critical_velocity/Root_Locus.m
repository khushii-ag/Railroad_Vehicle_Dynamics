% Given parameters
m = 1486;                % mass (kg)
g = 9.81;                % gravitational acceleration (m/s^2)
Iy = 166;                % moment of inertia about the y-axis (kg.m^2)
Iz = 1034;               % moment of inertia about the z-axis (kg.m^2)
W = 25000;               % Mass
ky = 1.561 * 10^6;       % lateral stiffness (N/m)
k_sai = 2.12 * 10^6;     % yaw stiffness (Nm/rad)
f11 = 7.44 * 10^6;       % lateral damping coefficient (N)
f22 = 6.79 * 10^6;       % yaw damping coefficient (N)
f23 = 13.7 * 10^3;       % coupling damping coefficient (N)
r0 = 0.5;                % reference radius (m)
l = 0.838;               % wheelbase (m)
lambda0 = 0.1174;        % model parameter (unitless)
delta0 = 0.02754;        % model parameter (unitless)
eps0 = 6.423;            % model parameter (unitless)

% N0, kappa, Ky, and K_sai calculations
N0 = W * g /4; % Normal force
kappa = delta0 * (1 - f23 / (N0 * r0));
Ky = ky + (2 * N0 * eps0 / l) * (1 - f23 / (N0 * r0));
K_sai = k_sai + (2 * N0 * l) * (-delta0 + f23 / (N0 * l));

% Set velocity range to analyze
V_range = linspace(20, 150, 100);  % Velocity range (1 to 150 m/s)
critical_velocity = 0;            % To store the critical velocity
unstable_found = false;           % Flag to stop when critical velocity is found

pole_array = [];
% Loop over the velocity range and calculate the transfer function
figure;
for V = V_range
    
    %calculations
    a1 = m;
    a2 = 2*f22/V;
    a3 = (2*f23/V - Iy*kappa*V/(r0*l));
    a4 = 2*f22;
    a5 = Ky;
    b1 = Iz;
    b2 = 2*f11*(l^2)/V;
    b3 = (2*f23/V - Iy*delta0*V/(r0*l));
    b4 = 2*f11*lambda0*l/r0 ;
    b5 = K_sai;
    
    p4 = a1*b1;
    p3 = (a1*b2 + a2*b1);
    p2 = (a1*b5 + a2*b2 + a5*b1 + a3*b3);
    p1 = (a2*b5 + a5*b2 - a3*b4 - a4*b3);
    p0 = (a5*b5 + a4*b4);
    din = [p4,p3,p2,p1,p0];
    transfer_function = tf(1,din);

    % Get the poles of the transfer function
    poles = pole(transfer_function);
    
    pole_array = [pole_array poles];
   

    % Check if any pole has a positive real part (instability condition)
    if any(real(poles) > 0)
        critical_velocity = V;  % Store the velocity at which instability occurs
        unstable_found = true;
        break;  % Exit the loop once instability is found
    end
end
% Plot the poles on the complex plane (real and imaginary axes)
plot(real(pole_array), imag(pole_array),'.');  %for poles
hold on

xlabel('Real Axis');
    ylabel('Imaginary Axis');
    title('Poles of the Transfer Function on the Complex Plane');
    grid on;

% Display the critical velocity
if unstable_found
    fprintf('The system becomes unstable at a critical velocity of: %.2f m/s\n', critical_velocity);
else
    fprintf('The system remains stable within the analyzed velocity range.\n');
end