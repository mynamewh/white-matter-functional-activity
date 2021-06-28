load('subject176.mat')
glmpath = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_GLM/';
datapath = '/home/boyden/NeuroRaid/DataStorage/Data2017/White_matter_pRF/HCP_resting/DCM_REST1/DCM_Data/';
for i = 1:length(subject)
    matlabbatch{1}.spm.stats.fmri_spec.dir = {[glmpath num2str(subject(i,1)) '/GLM']};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    niifiles = dir([datapath num2str(subject(i,1)) '/*.nii']);
    for j = 1:size(niifiles,1)
        matlabbatch{1}.spm.stats.fmri_spec.sess.scans{j,1} = [niifiles(j,1).folder '/' niifiles(j,1).name ',1'];
    end
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
    matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {''};
    matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.3;
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
%     spm_jobman('run', matlabbatch{1});
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {[glmpath num2str(subject(i,1)) '/GLM/SPM.mat']};
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    spm_jobman('run', matlabbatch);
end