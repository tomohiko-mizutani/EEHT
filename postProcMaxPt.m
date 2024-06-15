%  Tomohiko Mizutani (June 15, 2024)

function [K] = postProcMaxPt(A, r, ptLst)

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

    K = getBasis_maxPt(clst, r);

end

%%%%%%%%
function [K] = getBasis_maxPt(clst, r)

    K = [];

    for j = 1:r

        elemLst = clst(j).elem;
        elemPtLst = clst(j).pt;

        if isempty(elemLst) == 0

            [~, maxPtIdx] = max(elemPtLst);
            idx = elemLst(maxPtIdx);

            K = [K, idx];

        else

            K = [K, 0];

        end

    end

end
