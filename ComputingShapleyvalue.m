%% Written By Twan Burg %%
% Obtained from MATLAB File Exchange %

% As input give the values for all 2^n-1 coalitions in lexicographic order.
% The file ComputingShapleyvalue.m makes use of the 2 other files. So enter
% after v=[ your game. For example, when a game consists of 3 players, v=[0
% 1 2 3 4 3 9] means v(a)=0, v(b)=1, v(c)=2, v(ab)=3, v(ac)=4, v(bc)=3,
% v(abc)=9. The function Shappie.m computes the Shapley value for
% individual a. With help of the function matr.m the lexicographic order is
% changed, after which Shappie can compute the Shapley value for all
% individuals. The file which all does this is ComputingShapleyvalue.m

function [Shapleyvalue] = ComputingShapleyvalue(v)

n=log2(length(v)+1);
A=[matr(n) v'];
Shapleyvalue=zeros(1,n);
for i=1:n
G=sortrows(A,[n+1 -i]);
Shapleyvalue(i)=Shappie(G(:,n+2)');
end
Shapleyvalue
sum(Shapleyvalue);
