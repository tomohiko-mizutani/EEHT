%  Tomohiko Mizutani (June 15, 2024)

function [K] = postProcCentroid(A, r, ptLst)

    n = size(A, 2);
    clst = struct('elem', [], 'pt', [], 'diam', []);

    for j = 1:r

        minDiam = inf;
        elemLst = [];

        for i = 1:n

            aVec = A(:, i);
            [disLst, ordDatLst] = sort(sum(abs(A - repmat(aVec, 1, n))));

            sumLst = cumsum(ptLst(ordDatLst));

            I = [1:n];
            I(sumLst <= r / (r + 1)) = [];

            if isempty(I) == 0

                minIdx = min(I);
                diam = disLst(1, minIdx);

                if diam < minDiam

                    elemLst = ordDatLst([1:minIdx]);
                    minDiam = diam;

                end

            end

        end

        clst(j).elem = elemLst;
        clst(j).pt = ptLst(elemLst);
        clst(j).diam = minDiam;

        ptLst(elemLst) = 0;

    end

    K = getBasis_aveMrsa(A, clst, r);

end

%%%%%%%%
function [K] = getBasis_aveMrsa(A, clst, r)

    d = size(A, 1);

    K = [];

    for j = 1:r

        elemLst = clst(j).elem;

        if isempty(elemLst) == 0

            centroid = mean(A(:, elemLst), 2);
            centroid_mr = getL2Normal(centroid - repmat(mean(centroid), d, 1));

            B = A(:, elemLst);
            B_mr = getL2Normal(B - repmat(mean(B), d, 1));

            mrsaLst = acos(min(centroid_mr' * B_mr, 1));
            [~, minErrIdx] = min(mrsaLst);

            idx = elemLst(minErrIdx);
            K = [K, idx];

        else

            K = [K, 0];

        end

    end

end

%%%%%%%%
function [A] = getL2Normal(A)

    n = size(A, 2);

    isVec = (1 ./ sqrt(sum(A .^ 2)))';
    A = A * spdiags(isVec, 0, n, n);

end
