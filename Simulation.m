%% MCE 512 Vibrations Group 10
% 2-DOF Vibration Isolation System (using Passive & Active Controls)
% Marine Vibration Mitigation

% CONCEPT DEVELOPED, MODELLED, DESIGNED AND ANAYLYZED BY PARTICIPATING
% GROUP MEMBERS:
% 2021/1/79838ET - Christian Owoicho-Oche Ameh
% 2021/1/81010ET - Chioma Favour Chukwu
% 2022/2/85570ET - Richard Chidubem Aniekwe
% 2021/1/79587ET - Abdulrahman Abubakar

clear; clc; close all;

%% --- 1. Define System Parameters ---
m1 = 100; % Sprung Mass
m2 = 400; % Unspring Mass
c1 = 800; % Suspension Damping
c2 = 3000; % Tyre Damping
k1 = 200000; % Original suspension stiffness
k2 = 800000; % Tyre Stiffness


%% --- 2. Original Plant Transfer Function ---
num = [60, 31000, 4000000];
den = [1, 17.5, 4560, 31000, 4000000];
G = tf(num, den);
disp('Original Plant G(s):'); % Show transfer function of original system
G

isstable(G) % Check for stability
damp(G) % Check damping, poles, natural frequency and time constant

% --- Root Locus and Bode for Original System ---
figure('Name', 'Root Locus - Original Uncontrolled System'); rlocus(G); grid on;
figure('Name', 'Bode Plot - Original Uncontrolled System'); bode(G); grid on;


%% --- 3. Input Signal (Wave Excitation) ---
t = 0:0.01:10;
A = 0.05;
omega = 25;
u = A * sin(omega * t);

% --- 3B. ORIGINAL SYSTEM RESPONSE ONLY  ---
y_original_only = lsim(G, u, t);
figure('Color','w');
plot(t, u, 'k--','LineWidth',1.5); hold on;
plot(t, y_original_only, 'r','LineWidth',2);
title(['Original System Response to Sinusoidal Input (\omega = ', num2str(omega), ' rad/s)']);
xlabel('Time (s)');
ylabel('Displacement (m)');
legend('Oceanic sinusoidal wave (Input)','Original System Response');
grid on;


%% --- 4. PASSIVE ISOLATION DESIGN ---
k1_ = 10595;   % Redesigned stiffness
num_passive = [c1*c2, (c2*k1_ + c1*k2), k1_*k2];
den_passive = [ ...
    m1*m2, ...
    (m1*(c1+c2) + m2*c1), ...
    (m1*(k1_+k2) + m2*k1_ + c1*c2), ...
    (c1*k2 + c2*k1_), ...
    k1_*k2 ...
];
G_passive = tf(num_passive, den_passive);
disp('Passively Controlled Isolation Transfer Function:');  % Show transfer function of Passive Isolation system
G_passive

isstable(G_passive) % Check for stability
damp(G_passive) % Check damping, poles, natural frequency and time constant

% --- Root Locus and Bode for Passive System ---
figure('Name', 'Root Locus - Passive Controlled System'); rlocus(G_passive); grid on;
figure('Name', 'Bode Plot - Passive Controlled System'); bode(G_passive); grid on;


%% --- 5. SIMULATION: PASSIVE vs ORIGINAL ---
y_passive = lsim(G_passive, u, t);
y_original = lsim(G, u, t);
figure('Color','w');
plot(t, u, 'k--','LineWidth',1.2); hold on;
plot(t, y_original, 'r','LineWidth',1.5);
plot(t, y_passive, 'g','LineWidth',2);
title(['Passively Controlled Isolation Response (\omega = ', num2str(omega), ' rad/s)']);
xlabel('Time (s)');
ylabel('Displacement (m)');
legend('Oceanic sinuoisal wave (Input)','Original System','Passively Controlled Isolation');
grid on;


%% --- 6. ACTIVE (PID) ISOLATION DESIGN ---
Kp = 0.186;
Ki = 2.853;
Kd = 0.0030318;
PID = pid(Kp, Ki, Kd);
% Closed-loop system
sys_cl = feedback(PID * G, 1);
disp('PID Controlled System:');  % Show transfer function of Active isolated system
sys_cl

isstable(sys_cl) % Check for stability
damp(sys_cl) % Check damping, poles, natural frequency and time constant

% --- Root Locus and Bode for Active (PID) System ---
figure('Name', 'Root Locus - Active (PID) Controlled System'); rlocus(PID * G); grid on;
figure('Name', 'Bode Plot - Active (PID) Controlled System'); bode(sys_cl); grid on;


%% --- 7. SIMULATION: ACTIVE CONTROL ---
y_pid = lsim(sys_cl, u, t);
figure('Color','w');
plot(t, u, 'k--','LineWidth',1.2); hold on;
plot(t, y_original, 'r','LineWidth',1.5);
plot(t, y_pid, 'b','LineWidth',2);
title(['Actively (PID) Controlled Isolation Response (\omega = ', num2str(omega), ' rad/s)']);
xlabel('Time (s)');
ylabel('Displacement (m)');
legend('Oceanic sinuoisal wave (Input)','Original System','Actively (PID) Controlled Isolation');
grid on;


%% --- 8. COMBINED COMPARISON (BEST PLOT) ---
figure('Color','w');
plot(t, u, 'k--','LineWidth',1.2); hold on;
plot(t, y_original, 'r','LineWidth',1.5);
plot(t, y_passive, 'g','LineWidth',2);
plot(t, y_pid, 'b','LineWidth',2);
title(['Passive vs. Actively Controlled Isolation System Comparison (\omega = ', num2str(omega), ' rad/s)']);
xlabel('Time (s)');
ylabel('Displacement (m)');
legend('Oceanic sinuoisal wave (Input)','Original','Passively Controlled Isolation','Actively (PID) Controlled Isolation');
grid on;

% --- Combined Bode Comparison ---
figure('Name', 'Combined Bode Comparison');
bode(G, 'r', G_passive, 'g', sys_cl, 'b');
legend('Original Uncontrolled', 'Passive Controlled', 'Active (PID) Controlled');
grid on;

%% --- 9. DISPLACEMENT REDUCTION ANALYSIS ---
% This displayes the displaces reduction for both Passive and Active
% Control
max_original = max(abs(y_original));
max_passive = max(abs(y_passive));
max_pid = max(abs(y_pid));
fprintf('Passively Controlled Reduction: %.2f%%\n', ...
    (max_original - max_passive)/max_original*100);
fprintf('Actively (PID) Controlled Reduction: %.2f%%\n', ...
    (max_original - max_pid)/max_original*100);