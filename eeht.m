%  Tomohiko Mizutani (June 15, 2024)

function [K1, K2, K3, optVal] = eeht(A, r, para)

    A = rankRed(A, r);
    [K1, ptLst, optVal, ~, ~] = rce(A, r, para);
    K2 = postProcMaxPt(A, r, ptLst);
    K3 = postProcCentroid(A, r, ptLst);

end
