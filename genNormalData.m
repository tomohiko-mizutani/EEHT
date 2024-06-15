%  Tomohiko Mizutani (June 15, 2024)

function [A, Ktrue] = genNormalData(d, n, r, delta, seed)

    rng(seed, 'twister');

    W = abs(rand(d, r));
    W = getNormalMat(W);

    alpha = rand(r, 1);
    barH = dirRnd(alpha, n - r);
    H = [eye(r, r), barH];

    R = randn(d, n);
    normR = norm(R, 1);

    N = (delta / normR) * R;

    V = W * H;
    A = V + N;

    perm = randperm(n);
    A = A(:, perm);

    [~, idxLst] = sort(perm);
    K = idxLst(1:r);

    Ktrue = K;

end

%%%%%%%%
function [P] = dirRnd(alpha, n)

    r = size(alpha, 1);
    P = zeros(r, n);

    for i = 1:r

        P(i, :) = gamrnd(alpha(i), 1, 1, n);

    end

    sumLst = sum(P);
    P = P ./ repmat(sumLst, r, 1);

end

%%%%%%%%
function [A] = getNormalMat(A)

    n = size(A, 2);

    isVec = (1 ./ sum(A))';
    A = A * spdiags(isVec, 0, n, n);

end
