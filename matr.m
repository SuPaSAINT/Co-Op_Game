function matri=matr(n)
i=1; c=1;
if n==2 matri=[1 0; 0 1]; 
else 
matri=zeros(2^n-1,n+1);
while i<n
    for j=c:c+nchoosek(n-1,i-1)-1
matri(j,1)=1; %maakt de eerste kolom aan
    end
c=c+nchoosek(n,i); i=i+1;
end
R=matr(n-1); t=2; k=1; r=1;
while k<n-1
matri(t:t+nchoosek(n-1,k)-1,2:n)=R(r:r+nchoosek(n-1,k)-1,1:n-1); 
matri(t+nchoosek(n-1,k):t+2*nchoosek(n-1,k)-1,2:n)=R(r:r+nchoosek(n-1,k)-1,1:n-1); 
t=t+2*nchoosek(n-1,k); r=r+nchoosek(n-1,k); k=k+1;
end
matri(2^n-2,2:n)=ones(1,n-1); matri(2^n-1,1:n)=ones(1,n); %de laatste 2 kolommen
end
g=1; c=1;
while g<=n
for j=c:c+nchoosek(n,g)-1 %bepaalt de groepsgrootte
matri(j,n+1)=g; end
c=c+nchoosek(n,g); g=g+1;
end
end
