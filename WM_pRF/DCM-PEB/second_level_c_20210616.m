addpath('/home/boyden/spm12/')
GCM_fffb = load('/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/analyses_20200929/GCM_full_FfFb20200929_c.mat');
GCM_fffb = spm_dcm_load(GCM_fffb.GCM);
DCM_template = GCM_fffb{1,1};
a = DCM_template.a;
b = DCM_template.b;
c = DCM_template.c;
d = DCM_template.d;
options = DCM_template.options;

DCM = struct();
DCM.a       = a;
DCM.b       = b;
DCM.c       = c;
DCM.d       = d;
DCM.options = options;
DCM.name    = 'FfFb';                    
GCM_templates{1,1} = DCM;

dm = load('/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/analyses_20200929/MakeDesignMatrix/design_matrix_ORactivity_c_wmparc_PRF.mat');
X        = dm.X;
X(:,2)   = X(:,2) - mean(X(:,2));
X_labels = dm.labels;

% PEB settings
M = struct();
M.Q      = 'all';
% M.X      = X;
M.X      = X(:,2);
% M.Xnames = X_labels;
M.Xnames = {'ORactivity'};
M.maxit  = 256;

%% Build PEB (A)
% for i = 1:176
%     GCM{i,1} = GCM_all{i,1};
% end

GCM = GCM_fffb;
GCM_templates{1,2}=GCM_templates{1,1};
GCM_templates{1,2}.a(1,2)=0;
GCM_templates{1,3}=GCM_templates{1,1};
GCM_templates{1,3}.a(2,1)=0;
[PEB_A,RCM_A] = spm_dcm_peb(GCM,M,{'A'});
save('PEB_A_c_full.mat','PEB_A','RCM_A');
%% Search-based analysis (A)
% load('PEB_A_c1.mat');
BMA_A = spm_dcm_peb_bmc(PEB_A);
save('BMA_search_A_c_full.mat','BMA_A');
% save('BMA_search_A_c_inStimFreq_norm.mat','BMA_A');
[BMA, BMR] = spm_dcm_peb_bmc(PEB_A, GCM_templates);
save('BMA_3models_A_c_full.mat','BMA','BMR');
% save('BMA_3models_A_c_inStimFreq_norm.mat','BMA','BMR');
spm_dcm_peb_review(BMA_A,GCM);
spm_dcm_peb_review(BMA,GCM);
% clear BMA_A