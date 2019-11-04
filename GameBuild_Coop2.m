function [matrix] = GameBuild_Coop2(nc,ya1,ya2,ya3,yd,A,Cost,V)
%% Inputs: %%
%nc = # of cyber nodes
%ya1 = resource allocation for attacker 1
%ya2 = resource allocation for attacker 2
%ya3 = resource allocation for attacker 3
%yad = resource allocation for defender
%A = network connectivity
%Cost = cost matrix
%V = threshold values

La1 = length(ya1);
La2 = length(ya2);
La3 = length(ya3);
Ld = length(yd); 

%% if ya2 == 0, it is a "2-player" game
%grand coalition of attackers + 1 defender
if ya2 == 0
    ya2 = zeros(1,nc);
    ya3 = zeros(1,nc);
    La2 = 1;
    La3 = 1;
end
%% if ya3 == 0, it is a "3-player" game
%coalition of 2 attackers + 1 individual attacker + 1 defender
if ya3 == 0
    ya3 = zeros(1,nc);
    La3 = 1;
end
%% Game Build %%
p = 1; z = 0;

% For each strategy set in the defender's combinations
for jj = 1:Ld
    % For each strategy set in attacker 1's combinations 
     for oo = 1:La1
         % For each strategy set in attacker 2's combinations
         for aa = 1:La2
             % For each strategy set in attacker 3's combinations
             for bb = 1:La3
            for ll = 1:nc
                if ya1(oo,ll) + ya2(aa,ll) + ya3(bb,ll) <= yd(jj,ll)
                    H = 0;
                elseif ya1(oo,ll) + ya2(aa,ll) + ya3(bb,ll) > yd(jj,ll)
                    H = 1;
                end                
                z(ll) = H;
            end         
                  y = A*z';
            for ii = 1:length(y) % Compare nodes with threshold values
                if y(ii) >= V(ii)
                    Y(ii) = 1;
                else
                    Y(ii) = 0;
                end
        % Y now contains 1 if p-node is taken down and 0 if not
            end         
% Each player values physical nodes differently
% If player mm is an attacker, reward nodes being down.(Y(ii) = 1)
            for mm = 1:size(Cost,2)
                if sum(Cost(:,mm)) > 0
                  C(mm) = Y*Cost(:,mm); 
                else
 %  Otherwise a defender gets rewarded when cyber nodes are not successfully taken down.
                 for ii = 1:length(Y)
                    if Y(ii) == 0
                        C10(ii) = abs(Cost(ii,mm));
                    elseif Y(ii) == 1
                        C10(ii) = 0;
                    end
                end
 
                C(mm) = sum(C10);
                end
            end   

        % Build cost matrix.  
                matrix(p,:) = C;
                p = p+1;
             end
         end
     end
end
end

 