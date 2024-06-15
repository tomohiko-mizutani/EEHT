%  Tomohiko Mizutani (June 15, 2024)

function Ar = rankRed(A, r)

    [~, S, V] = svds(A, r, 'largest');
    Ar = S * V';

end
