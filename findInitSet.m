%  Tomohiko Mizutani (June 15, 2024)

function L = findInitSet(A, r, para)

    lambda = para.lambda;
    mu = para.mu;
    seed_initSet = para.seed_initSet;

    n = size(A, 2);

    I = spa(A, r);

    L = [];

    for i = 1:r

        aVec = A(:, I(i));

        D = A - repmat(aVec, 1, n);

        distLst = sum(D .^ 2);
        [~, J] = sort(distLst, 'ascend');

        nbrIdxSet = J(1:lambda);

        L = [L, nbrIdxSet];

    end

    L = unique(L);

    rng(seed_initSet);
    cL = setdiff([1:n], L);
    L = [L, randsample(cL, mu)];

end
