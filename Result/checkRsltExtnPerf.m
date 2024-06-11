load('rsltExtnPerf_dataset1.mat', 'algo');
load('../../../Exp/Exp2/Rslt_taro/jasper/exp2_jasper_aveMrsa.mat','aveMrsaLst');

disp('[Dataset1]');
max(algo(1).aveMrsaLst - aveMrsaLst(1,:))
max(algo(2).aveMrsaLst - aveMrsaLst(2,:))
max(algo(3).aveMrsaLst - aveMrsaLst(3,:))

clear;

load('rsltExtnPerf_dataset2.mat', 'algo');
load('../../../Exp/Exp2/Rslt_taro/samson/exp2_samson_aveMrsa.mat','aveMrsaLst');

disp('[Dataset2]');
max(algo(1).aveMrsaLst - aveMrsaLst(1,:))
max(algo(2).aveMrsaLst - aveMrsaLst(2,:))
max(algo(3).aveMrsaLst - aveMrsaLst(3,:))

clear;


