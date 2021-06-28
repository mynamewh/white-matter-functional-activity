%% Settings
load('subject176.mat')
glmpath = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM/';
% MRI scanner settings
TR = 0.5;   % Repetition time (secs)
TE = 0.0222;  % Echo time (secs)

% Experiment settings
nsubjects   = length(subject);

%% Specify DCMs (one per subject)
% A-matrix (on / off)
nregions    = 2; 
v1_c = 1; lgn_c = 2;
%% FF and FB
a = ones(nregions,nregions);

start_dir = pwd;
for subj = 1:nsubjects
    
%     name = sprintf('sub-%02d',subj);
    name = num2str(subject(subj));
    % Load SPM
    glm_dir = fullfile(glmpath,name,'GLM');
    SPM     = load(fullfile(glm_dir,'SPM.mat'));
    SPM     = SPM.SPM;
    
    % Load ROIs
    f = {fullfile(glm_dir,'VOI_V1c20200926_1.mat');
         fullfile(glm_dir,'VOI_LGNc20200928_1.mat')};     
    for r = 1:length(f)
        XY = load(f{r});
        xY(r) = XY.xY;
    end
    
    % Move to output directory
    cd(glm_dir);
    
    % Select whether to include each condition from the design matrix
    % (Task, Pictures, Words)
%     include = [1 1 1]';    
    
    % Specify. Corresponds to the series of questions in the GUI.
    s = struct();
    s.name       = 'full_FfFb20200929_c';
%     s.u          = include;                 % Conditions
    s.delays     = repmat(TR,1,nregions);   % Slice timing for each region
    s.TE         = TE;
    s.nonlinear  = false;
    s.two_state  = false;
    s.stochastic = false;
    s.centre     = true;
    s.induced    = 1;
    s.a          = a;
%     s.b          = b;
%     s.c          = c;
%     s.d          = d;
    DCM = spm_dcm_specify(SPM,xY,s);
    
    % Return to script directory
    cd(start_dir);
end

%% Collate into a GCM file and estimate

% Find all DCM files
dcms = spm_select('FPListRec','/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM','DCM_full_FfFb20200929_c.mat');

% Prepare output directory
out_dir = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/analyses_20200929/';
if ~exist(out_dir,'file')
    mkdir(out_dir);
end

% Check if it exists
if exist(fullfile(out_dir,'GCM_full_FfFb20200929_c.mat'),'file')
    opts.Default = 'No';
    opts.Interpreter = 'none';
    f = questdlg('Overwrite existing GCM?','Overwrite?','Yes','No',opts);
    tf = strcmp(f,'Yes');
else
    tf = true;
end

% Collate & estimate
if tf
    % Character array -> cell array
    GCM = cellstr(dcms);
    
    % Filenames -> DCM structures
    GCM = spm_dcm_load(GCM);
    use_parfor = true;
    % Estimate DCMs (this won't effect original DCM files)
    GCM = spm_dcm_fit(GCM, use_parfor);
    
    % Save estimated GCM
    save('/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/analyses_20200929/GCM_full_FfFb20200929_c.mat','GCM','-v7.3');
end

%% Run diagnostics
% load('/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/analyses_20200724/GCM_full_FfFb20200724_c.mat');
% spm_dcm_fmri_check(GCM);