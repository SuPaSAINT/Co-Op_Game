%% Written By Twan Burg %%
% Obtained from MATLAB File Exchange %

function Shapley=Shappie(v) 
%Calculates the Shapley value for individual a
n=log2(length(v)+1);
M=zeros(1,2^n-2);
M(1,1)=v(1)*factorial(n-1);
c=2; i=1;
while i<n
for j=c:c+nchoosek(n-1,i)-1
M(1,j)=(v(j+nchoosek(n-1,i))-v(j))*((factorial(n-1))/(nchoosek(n-1,i))); end
c=c+2*(nchoosek(n-1,i));
i=i+1;
end
Shapley=sum(M)/factorial(n);
end