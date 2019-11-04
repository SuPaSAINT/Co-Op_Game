function [CA] = ResourceCombos_Coop(na,x)
p = 1;
  %% Look ahead and see what unique sets need to be made.
  X = unique(x);
  % Each unique set will be generated.
  % The unique set will be stored in cell block equal to its unique resource
  % value.
  for jj = 1:length(X)
      % Note im finding resource combos over all sets 1:na. When the set
      % contains strategies with less nodes then our problem 0s are added
      % and all permuations are taken.
      % Im doing this to insure all combos are in our set. Without this,
      % this method is missing 10-15% of the combos and even sometimes generates no set!. This method still uses
      % a bit of a redundant method but can handle quite big matrix
      % generation fast enough.
    for ii = 1:na  
        c = nchoosek(1:X(1,jj),ii-1);
        m = size(c,1);
        A = zeros(m,ii);
        for ix = 1:m
            A(ix,:) = diff([1,c(ix,:),X(1,jj)+1]);
        end
        AA{ii} = A;
    end
    for ii = 1:size(AA,2)
        AA2{ii} = [AA{ii} zeros(size(AA{ii},1),na-size(AA{ii},2))];
    end
        combos = [AA2{1}];
    for ii = 2:size(AA2,2)
      combos = [combos;AA2{ii}];
    end
        Combos = perms(combos(1,:));
    for ii = 2:size(combos,1)
        Combos = [Combos;perms(combos(ii,:))];
    end
  % Cell CA contains strategy sets for all used resource values. 
  % To access resources 5 over nodes you look in CA{5} for ex.
  CA{X(jj)}= unique(Combos,'rows');
  
  end
 
 
end