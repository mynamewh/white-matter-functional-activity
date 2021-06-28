load('subject176.mat')
glmpath = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM/';
lgnmask = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM/mask_files/V1_mask_20200926/'; % not LGN, V1
% lgn
for i = 1:length(subject)
    matlabbatch{1}.spm.util.voi.spmmat = {[glmpath num2str(subject(i,1)) '/GLM/SPM.mat']};
    matlabbatch{1}.spm.util.voi.adjust = NaN;
    matlabbatch{1}.spm.util.voi.session = 1;
    matlabbatch{1}.spm.util.voi.name = 'V1c20200926';
    matlabbatch{1}.spm.util.voi.roi{1}.mask.image = {[lgnmask num2str(subject(i,1)) '_benson14_eccen_v1_warped_normto1.6mm_thr_04.nii,1']};
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
    matlabbatch{1}.spm.util.voi.name = 'V1p20200926';
    matlabbatch{1}.spm.util.voi.roi{1}.mask.image = {[lgnmask num2str(subject(i,1)) '_benson14_eccen_v1_warped_normto1.6mm_thr_4.nii,1']};
    matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0;
    matlabbatch{1}.spm.util.voi.roi{2}.mask.image = {[glmpath num2str(subject(i,1)) '/GLM/mask.nii,1']};
    matlabbatch{1}.spm.util.voi.roi{2}.mask.threshold = 0;
    matlabbatch{1}.spm.util.voi.expression = 'i1&i2';
    spm_jobman('run', matlabbatch);
end