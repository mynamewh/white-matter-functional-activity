load('subject176.mat')
glmpath = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM/';
lgnmask = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM/mask_files/LGN_mask_20200923/';
% lgn
for i = 1:length(subject)
    matlabbatch{1}.spm.util.voi.spmmat = {[glmpath num2str(subject(i,1)) '/GLM/SPM.mat']};
    matlabbatch{1}.spm.util.voi.adjust = NaN;
    matlabbatch{1}.spm.util.voi.session = 1;
    matlabbatch{1}.spm.util.voi.name = 'LGNc20200928';
    matlabbatch{1}.spm.util.voi.roi{1}.mask.image = {[lgnmask num2str(subject(i,1)) '_lgn_pz_c_mask_WarpedLGNMask.nii,1']};
    matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0;
    matlabbatch{1}.spm.util.voi.roi{2}.mask.image = {[glmpath num2str(subject(i,1)) '/GLM/mask.nii,1']};
    matlabbatch{1}.spm.util.voi.roi{2}.mask.threshold = 0;
    matlabbatch{1}.spm.util.voi.expression = 'i1&i2';
    spm_jobman('run', matlabbatch);
end

for i = 1:length(subject)
    matlabbatch{1}.spm.util.voi.spmmat = {[glmpath num2str(subject(i,1)) '/GLM/SPM.mat']};
    matlabbatch{1}.spm.util.voi.adjust = NaN;
    matlabbatch{1}.spm.util.voi.session = 1;
    matlabbatch{1}.spm.util.voi.name = 'LGNp20200928';
    matlabbatch{1}.spm.util.voi.roi{1}.mask.image = {[lgnmask num2str(subject(i,1)) '_lgn_pz_c_mask_WarpedLGNMask.nii,1']};
    matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0;
    matlabbatch{1}.spm.util.voi.roi{2}.mask.image = {[glmpath num2str(subject(i,1)) '/GLM/mask.nii,1']};
    matlabbatch{1}.spm.util.voi.roi{2}.mask.threshold = 0;
    matlabbatch{1}.spm.util.voi.expression = 'i1&i2';
    spm_jobman('run', matlabbatch);
end