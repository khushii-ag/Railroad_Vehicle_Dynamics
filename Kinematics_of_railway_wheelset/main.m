
%Initial configuration

L_rail = 1500/2; %1676/2 + 75;
L_wheel = 1350/2; %1600/2;
y_shift_r = -172;
y_shift_w = -420;

%Contact configuration
x_guess = 721.5; %900 %Initial guess for "y"-coordinate of contact point
x_contact = newton(@contact_pt, x_guess, L_wheel, y_shift_w, L_rail, y_shift_r); %x is same for both in the central position
y_contact_wheel = rightwheel(x_contact, L_wheel, y_shift_w);
y_contact_rail = rightrail(x_contact, L_rail, y_shift_r);
%Shifting axis to match "z" of contact point
y_shift_r_contact = -y_contact_rail + y_shift_r; 
y_shift_w_contact = -y_contact_wheel + y_shift_w; 

%Plot to check
%plot_profile(L_rail,L_wheel,y_shift_r_contact,y_shift_w_contact);

%Motion
%Current way of defining frames is very confusing - Use frame
%where contact point is at 0,0

%eta_zeta axis required for both rail (stationary) and wheel (moving)
L_rail_eta_zeta = L_rail - x_contact;
L_wheel_eta_zeta = L_wheel - x_contact;
%Now we are at 0,0 of both profiles

%Plot to check contact
figure
plot_profile(L_rail_eta_zeta,L_wheel_eta_zeta,y_shift_r_contact,y_shift_w_contact);
hold off

data = [];
guess1 = [0,0,0,0,0,0,0,0,0,0];
guess2 = [0,0,0,0,0,0,0,0,0,0];
for uy = 0:0.00001:5
    [solutions, fval] = solve_system(L_wheel_eta_zeta,y_shift_w_contact,L_rail_eta_zeta, y_shift_r_contact, uy, guess2 + (guess2 - guess1)/2);
    guess1 = guess2;
    guess2 = solutions;
    data = [data ; uy, solutions]; 
    disp(uy);
end

data_neg = [];
guess1 = [0,0,0,0,0,0,0,0,0,0];
guess2 = [0,0,0,0,0,0,0,0,0,0];
for uy = 0:-0.00001:-5
    [solutions, fval] = solve_system(L_wheel_eta_zeta,y_shift_w_contact,L_rail_eta_zeta, y_shift_r_contact, uy, guess2 + (guess2 - guess1)/2);
    guess1 = guess2;
    guess2 = solutions;
    data_neg = [uy, solutions; data_neg]; 
    disp(uy);
end

data = [data_neg;data];

x = data(:, 1); % X-axis data

% Extracting individual columns for plotting
eta_wr = data(:, 2);
eta_rr = data(:, 3);
eta_wl = data(:, 4);
eta_rl = data(:, 5);
zeta_wr = data(:, 6);
zeta_rr = data(:, 7);
zeta_wl = data(:, 8);
zeta_rl = data(:, 9);
uz = data(:, 10);
phi = data(:, 11);

% Plot 1: eta_w
figure;
subplot(3, 2, 1);
plot(x, eta_wr, x, eta_wl);
title('eta\_w');
xlabel('uy');
ylabel('eta\_w');
legend('eta\_wr','eta\_wl')

% Plot 2: eta_r
subplot(3, 2, 2);
plot(x, eta_rr, x, eta_rl);
title('eta\_r');
xlabel('uy');
ylabel('eta\_r');
legend('eta\_rr','eta\_rl')

% Plot 3: zeta_w
subplot(3, 2, 3);
plot(x, zeta_wr, x, zeta_wl);
title('zeta\_w');
xlabel('uy');
ylabel('zeta\_w');
legend('zeta\_wr','zeta\_wl')

% Plot 4: zeta_r
subplot(3, 2, 4);
plot(x, zeta_rr, x, zeta_rl);
title('zeta\_r');
xlabel('uy');
ylabel('zeta\_r');
legend('zeta\_rr','zeta\_rl')

% Plot 5: uz
subplot(3, 2, 5);
plot(x, uz);
title('uz');
xlabel('uy');
ylabel('uz');

% Plot 10: phi
subplot(3, 2, 6);
plot(x, phi);
title('phi');
xlabel('uy');
ylabel('phi');

