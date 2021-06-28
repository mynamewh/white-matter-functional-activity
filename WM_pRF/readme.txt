Folder "OR_results" contains results of pRF model fitting on fMRI BOLD signals within OR. 
"make_resultsHRF.m": Script to convert pRF parameters into nifti files.
"OR_AngThrMerge_EndEnd_resample_2009c_thr_wmmask.nii.gz": OR mask used in the current research.
"pRF_OR_HRF_20200911.mat": pRF model fitting results for OR.
"OR_threshold.mat": Threshold determined by fitting a Gaussian mixture model to the distribution of the variance explained.

Folder "VOF_results" contains results of pRF model fitting on fMRI BOLD signals within VOF. 
"make_resultsHRF.m": Script to convert pRF parameters into nifti files.
"VOF_AngThrMerge_EndEnd_resample_2009c_thr_wmmask.nii.gz": VOF mask used in the current research.
"pRF_VOF_HRF_20200911.mat": pRF model fitting results for VOF.
"VOF_threshold.mat": Threshold determined by fitting a Gaussian mixture model to the distribution of the variance explained.

Folder "WholeBrain_WM_results" contains results of pRF model fitting on fMRI BOLD signals within whole brain white matter. 
"make_resultsHRF.m": Script to convert pRF parameters into nifti files.
"wmmask_178subj_frac0.9.nii.gz": Whole brain white matter mask used in the current research. It was obtained from the 90% overlap of all subjects' whole brain white matter mask.
"pRF_WholeBrainWM_HRF_20201208.mat": pRF model fitting results.

Nifti files are in ICBM152 2009c space.

Folder "DCM-PEB" contains scripts to perform DCM-PEB analysis.
