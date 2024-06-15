%  Tomohiko Mizutani (June 15, 2024)

function aeSet = checkRedCost(A, yMat, v, cL, para)

    zeroTol = para.zeroTol;

    aeSet = [];
    numData = size(cL, 2);

    for i = 1:numData

        idx = cL(i);
        pVec = yMat' * A(:, idx);
        val = sum(pVec(pVec >= 0)) + v;

        if val > zeroTol

            aeSet = [aeSet, idx];

        end

    end

end
