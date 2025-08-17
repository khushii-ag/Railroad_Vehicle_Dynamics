function [solution, fval] = solve_system(L_wheel_eta_zeta,y_shift_w_contact,L_rail_eta_zeta, y_shift_r_contact, uy, guess)

    y0 = 0;
    r0 = 450;
    l = 1350/2;

   function F = equations(x)
        % Define the unknowns
        eta_wr = x(1);
        eta_rr = x(2);
        eta_wl = x(3);
        eta_rl = x(4);
        zeta_wr = x(5);
        zeta_rr = x(6);
        zeta_wl = x(7);
        zeta_rl = x(8);
        uz = x(9);
        phi = x(10);

        % Define the equations based on the problem statement
        eq1 = uy - y0 - r0*phi - eta_wr + eta_rr;
        eq2 = uz + l*phi + zeta_wr - zeta_rr;
        eq3 = phi - atan(diffr(@rightwheel,eta_wr, L_wheel_eta_zeta, y_shift_w_contact)) + atan(diffr(@rightrail,eta_rr, L_rail_eta_zeta, y_shift_r_contact));

        eq4 = uy - y0 - r0*phi + eta_wl - eta_rl;
        eq5 = uz - l*phi + zeta_wl - zeta_rl;
        eq6 = phi + atan(diffr(@rightwheel,-eta_wl, L_wheel_eta_zeta, y_shift_w_contact)) - atan(diffr(@rightrail,-eta_rl, L_rail_eta_zeta, y_shift_r_contact));
        
        eq7 = zeta_wr - (-1)*rightwheel(-eta_wr, L_wheel_eta_zeta, y_shift_w_contact);
        eq8 = zeta_rr - (-1)*rightrail(-eta_rr, L_rail_eta_zeta, y_shift_r_contact);
        eq9 = zeta_wl - (-1)*rightwheel(-eta_wl, L_wheel_eta_zeta, y_shift_w_contact);
        eq10 = zeta_rl - (-1)*rightrail(-eta_rl, L_rail_eta_zeta, y_shift_r_contact);

        % Return the system of equations
        F = [eq1; eq2; eq3; eq4; eq5; eq6; eq7; eq8; eq9; eq10];
   end

    % Initial guess for the unknowns [eta_wr, eta_rr, eta_wl, eta_rl, zeta_wr, zeta_rr, zeta_wl, zeta_rl, uz, phi]
    x0 = guess; % Starting guesses can be any reasonable value

    % Solve using fsolve
    [solution, fval] = fsolve(@equations, x0);

    eta_wr = solution(1);
    eta_rr = solution(2);
    eta_wl = solution(3);
    eta_rl = solution(4);
    zeta_wr = solution(5);
    zeta_rr = solution(6);
    zeta_wl = solution(7);
    zeta_rl = solution(8);
    uz = solution(9);
    phi = solution(10);

%     Display if equations are satisfied
    disp(uy - y0 - r0*phi - eta_wr + eta_rr)
    disp(uz + l*phi + (-1)*rightwheel(-eta_wr, L_wheel_eta_zeta, y_shift_w_contact) - (-1)*rightrail(-eta_rr, L_rail_eta_zeta, y_shift_r_contact))
    disp(phi - atan(diffr(@rightwheel,-eta_wr, L_wheel_eta_zeta, y_shift_w_contact)) + atan(diffr(@rightrail,-eta_rr, L_rail_eta_zeta, y_shift_r_contact)))
    disp(uy - y0 - r0*phi + eta_wl - eta_rl)
    disp(uz - l*phi + (-1)*rightwheel(-eta_wl, L_wheel_eta_zeta, y_shift_w_contact) - (-1)*rightrail(-eta_rl, L_rail_eta_zeta, y_shift_r_contact))
    disp(phi + atan(diffr(@rightwheel,-eta_wl, L_wheel_eta_zeta, y_shift_w_contact)) - atan(diffr(@rightrail,-eta_rl, L_rail_eta_zeta, y_shift_r_contact)))

%     Display results
%     fprintf('eta_wr = %.6f\n', solution(1));
%     fprintf('eta_rr = %.6f\n', solution(2));
%     fprintf('eta_wl = %.6f\n', solution(3));
%     fprintf('eta_rl = %.6f\n', solution(4));
%     fprintf('uz = %.6f\n', solution(5));
%     fprintf('phi = %.6f\n', solution(6));

end