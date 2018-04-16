% https://www.mathworks.com/matlabcentral/answers/122715-calculating-the-distance-between-points-using-vectorization
% check manhattan distance it is faster to compute than euclidean distance
% https://www.thesisscientist.com/docs/GeorgeReynolds/d46d3a4b-e5c1-4eb7-a8cf-b6e2abde45ca.pdf
% pdf page 4
function dist = distance(points, metric)
    if (metric == 'e')
        Diff = [diff(points, 1); points(end, :)-points(1, :)];
        Dists = sqrt(sum(Diff .* Diff, 2));
    elseif (metric == 'm')
        Diff = abs([diff(points, 1); points(end, :)-points(1, :)]);
        Dists = sum(Diff(:,1:2),2);
    end
    dist = sum(Dists);
end