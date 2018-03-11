% https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering

function P = next_perm(P)
k1 = find(P(2:end) > P(1:end-1), 1, 'last') ;
if isempty(k1)
    k1 = 0;
else
    k2 = find(P(k1)<P, 1, 'last');
    P([k1 k2]) = P([k2 k1]);
end
P((k1+1):end) = P(end:-1:(k1+1));