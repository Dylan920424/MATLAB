function [A] = reduced_echelon(A)
for ii = 1:size(A,1)-1
    pivot = find(A(ii,:),1);
    if pivot == size(A,2)
        continue
    end
    pivot_val = A(ii,pivot);
    for jj = ii+1:size(A,1)
        first_val = A(jj,pivot);
        A(jj,:) = A(jj,:) - A(ii,:)*(first_val/pivot_val);
    end
end
for ii = 1:size(A,1)
    pivot = find(A(ii,:),1);
    pivot_val = A(ii,pivot);
    if isempty(pivot)
        continue
    end
    A(ii,:) = A(ii,:)/pivot_val;
end
for ii = size(A,1):-1:2
    pivot = find(A(ii,:),1);
    if isempty(pivot)||pivot == size(A,2)
        continue
    end
    for jj = ii-1:-1:1
       A(jj,:) = A(jj,:)-A(ii,:)*A(jj,pivot);
    end
end
end

