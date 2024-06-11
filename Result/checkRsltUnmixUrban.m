
disp('[preproc1]');

load('rsltUnmixUrban_preproc1.mat', 'K');
newExp_K = sort(K);


load('../../../Exp/Exp3/Unmixng/Rslt_taro/MRSA/r6/exp3_eeht_40_10.mat', 'K3');
oldExp_K = sort(K3);

newExp_K - oldExp_K



%%%%%%%%%%%%%%%%%%
disp('[preproc2]');

load('rsltUnmixUrban_preproc2.mat', 'K');
newExp_K = sort(K);

load('../../../Exp/Exp3/Unmixng/Rslt_taro/MRSA/r6/exp3_eeht_45_15.mat', 'K3');
oldExp_K = sort(K3);

newExp_K - oldExp_K


%%%%%%%%%%%%%%%%%%
disp('[preproc3]');

load('rsltUnmixUrban_preproc3.mat', 'K');
newExp_K = sort(K);


load('../../../Exp/Exp3/Unmixng/Rslt_taro/MRSA/r6/exp3_eeht_50_30.mat', 'K3');
oldExp_K = sort(K3);

newExp_K - oldExp_K



%%%%%%%%%%%%%%%%%%
disp('[preproc4]');

load('rsltUnmixUrban_preproc4.mat', 'K');
newExp_K = sort(K);


load('../../../Exp/Exp3/Unmixng/Rslt_taro/MRSA/r6/exp3_eeht_55_45.mat', 'K3');
oldExp_K = sort(K3);

newExp_K - oldExp_K


%%%%%%%%%%%%%%%%%%
disp('[preproc5]');

load('rsltUnmixUrban_preproc5.mat', 'K');
newExp_K = sort(K);


load('../../../Exp/Exp3/Unmixng/Rslt_taro/MRSA/r6/exp3_eeht_60_60.mat', 'K3');
oldExp_K = sort(K3);

newExp_K - oldExp_K

