function order = swap(order, count)
    for i = 1:count
        c = randperm(length(order));
        temp = order(c(1));
        order(c(1)) = order(c(2));
        order(c(2)) = temp;
    end
end