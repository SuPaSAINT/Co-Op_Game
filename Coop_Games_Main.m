%% Cooperative Model of Colonel Blotto Games %%
% Written By Matthew Dunn and Victoria Kim %

clear variables;

%% System Description %%
np = 2; % Physical Nodes
nc = 4; % Cyber Nodes
% Network connectivity
A = [1 1 1 0; 0 1 1 1];
% How many cyber nodes must be down for each physical node to be down
V = [1;1];

%% Player Description %%
% How each player values the physical nodes
cost1 = [1;.25];
cost2 = [.25;1];
cost3 = [.5;.5];
costd = [-.75;-.75];
Cost = [cost1 cost2 cost3 costd];

% Player resources
xa1 = 2;
xa2 = 2; 
xa3 = 2;
xd = 4;
X = [xa1 xa2 xa3 xd];

%% Coalitons %%
% Combined resources for each coalition
% 7 total coalitions (2^N - 1)
r = [xa1 xa2 xa3 xa1+xa2 xa1+xa3 xa2+xa3 xa1+xa2+xa3];

% resource combos(nc,X) nc: # of cyber nodes, X: resources
CA = ResourceCombos_Coop(nc,r);
CA = [CA(2) CA(4) CA(6)];
y2 = CA{1,1}; % 2 resources (no coalition)
y4 = CA{1,2}; % 4 resources (coalition of 2 players)
y6 = CA{1,3}; % 6 resources (grand coalition)

yd = y4; % defender has 4 resources

%% Find payoff matricies for each coalition type %%
% no coalition
ya1 = y2;
ya2 = y2;
ya3 = y2;
coalition_1 = GameBuild_Coop2(nc,ya1,ya2,ya3,yd,A,Cost,V);

% partial coalition
ya1 = y4;
ya2 = y2; 
ya3 = 0;

% coalition of 2 attackers: {AB}
Cost = [1.25 .5 -.75; 1.25 .5 -.75];
coalition_2a = GameBuild_Coop2(nc,ya1,ya2,ya3,yd,A,Cost,V);

% coalition of 2 attackers: {BC}
Cost = [.75 1 -.75; 1.5 .25 -.75];
coalition_2b = GameBuild_Coop2(nc,ya1,ya2,ya3,yd,A,Cost,V);

% coalition of 2 attackers: {AC}
Cost = [1.5 .25 -.75; .75 1 -.75];
coalition_2c = GameBuild_Coop2(nc,ya1,ya2,ya3,yd,A,Cost,V);

% grand coalition
ya1 = y6; 
ya2 = 0;
ya3 = 0;
Cost = [1.75 -.75; 1.75 -.75];
coalition_3 = GameBuild_Coop2(nc,ya1,ya2,ya3,yd,A,Cost,V);

%% Nash Solver %%

C1 = [length(y2) length(y2) length(y2) length(yd)];
[A1,payoff1,iterations1,err1] = npg2(C1,coalition_1);

C2a = [length(y4) length(y2) length(yd)];
[A2a,payoff2a,iterations2a,err2a] = npg2(C2a,coalition_2a);

C2b = [length(y4) length(y2) length(yd)];
[A2b,payoff2b,iterations2b,err2b] = npg2(C2b,coalition_2b);

C2c = [length(y4) length(y2) length(yd)];
[A2c,payoff2c,iterations2c,err2c] = npg2(C2c,coalition_2c);

C3 = [length(y6) length(yd)];
[A3,payoff3,iterations3,err3] = npg2(C3,coalition_3);

%% Shapley Value Solver %%
%v_2a = [a b ab]
%v_2b = [b c bc]
%v_2c = [a c ac]
%v_3 = [a b c ab ac bc abc]

%partial coalition 2a {AB},{C}
v_2a = [payoff1(1) payoff1(2) payoff2a(1)];
ShapleyValue2a = ComputingShapleyvalue(v_2a);

%partial coalition 2b {BC},{A}
v_2b = [payoff1(2) payoff1(3) payoff2b(1)];
ShapleyValue2b = ComputingShapleyvalue(v_2b);

%partial coalition 2c {AC},{B}
v_2c = [payoff1(1) payoff1(3) payoff2b(1)]; 
ShapleyValue2c = ComputingShapleyvalue(v_2c);

%grand coalition {ABC}
v_3 = [payoff1(1) payoff1(2) payoff1(3) payoff2a(1) payoff2b(1) payoff2b(1) payoff3(1)]; %%grand coalition
ShapleyValue3 = ComputingShapleyvalue(v_3);


