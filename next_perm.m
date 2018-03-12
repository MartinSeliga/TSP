% https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering

function P = next_perm(P)
x = find(P(2:end) > P(1:end-1), 1, 'last') ;
if isempty(x)
    x = 0;
else
    y = find(P(x)<P, 1, 'last');
    P([x y]) = P([y x]);
end
P((x+1):end) = P(end:-1:(x+1));