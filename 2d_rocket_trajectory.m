% Basic 2D Rocket Trajectory Simulation

% Constants
g = 9.81;        % Acceleration due to gravity (m/s^2)
m = 50;          % Mass of the rocket (kg)
Thrust = 500;    % Constant thrust (N)
Cd = 0.2;        % Drag coefficient
A = 0.1;         % Cross-sectional area of the rocket (m^2)
rho = 1.2;       % Air density (kg/m^3)

% Initial conditions
y0 = 0;          % Initial height (m)
v0 = 0;          % Initial velocity (m/s)
dt = 0.1;        % Time step (s)
T = 30;          % Total simulation time (s)
time = 0:dt:T;   % Time vector
N = length(time);

% Variables to hold the simulation results
y = zeros(1, N);
v = zeros(1, N);
y(1) = y0;
v(1) = v0;

% Main simulation loop
for i = 2:N
    % Drag force
    Drag = 0.5 * Cd * A * rho * v(i-1)^2;
    
    % Net force (Thrust upward minus drag and gravity)
    F_net = Thrust - Drag - m * g;
    
    % Acceleration
    a = F_net / m;
    
    % Update velocity and position using simple Euler integration
    v(i) = v(i-1) + a * dt;
    y(i) = y(i-1) + v(i-1) * dt;
    
    % Stop simulation if rocket hits the ground
    if y(i) < 0
        y(i) = 0;
        v(i) = 0;
        break;
    end
end

% Plotting the results
figure
subplot(2,1,1);
plot(time, y)
xlabel('Time (s)')
ylabel('Height (m)')
title('Rocket Height vs Time')
grid on

subplot(2,1,2);
plot(time, v)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Rocket Velocity vs Time')
grid on
