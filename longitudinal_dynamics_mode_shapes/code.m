m = 60*1e3;
k = 10*1e6;

%CASE 1

% Define stiffness and mass matrices
K = [k/2 -k/2 0; -k/2 k -k/2; 0 -k/2 k/2];
M = [m 0 0; 0 m 0; 0 0 m];

% Solve for eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(K, M);

% Extract natural frequencies
lambda = diag(eigenvalues);
frequencies = sqrt(lambda);

% Display results
disp('Natural Frequencies (Hz):');
disp(frequencies);
disp('Mode Shapes:');
disp(eigenvectors);

%CASE 2

% Define stiffness and mass matrices
K = [k/2 -k/2 0; -k/2 k/2 0; 0 0 0];

% Solve for eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(K, M);

% Extract natural frequencies
lambda = diag(eigenvalues);
frequencies = sqrt(lambda);

% Display results
disp('Natural Frequencies (Hz):');
disp(frequencies);
disp('Mode Shapes:');
disp(eigenvectors);

%CASE 3

% Define stiffness and mass matrices
K = zeros(3,3);

% Solve for eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(K, M);

% Extract natural frequencies
lambda = diag(eigenvalues);
frequencies = sqrt(lambda);

% Display results
disp('Natural Frequencies (Hz):');
disp(frequencies);
disp('Mode Shapes:');
disp(eigenvectors);