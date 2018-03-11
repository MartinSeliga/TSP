% https://www.mathworks.com/matlabcentral/answers/122715-calculating-the-distance-between-points-using-vectorization

function dist = distance(points)
    Diff = [diff(points, 1); points(end, :)-points(1, :)];
    Dists = sqrt(sum(Diff .* Diff, 2));
    dist = sum(Dists);
end