mask=load_nii('wmmask_178subj_frac0.9.nii.gz');
load('pRF_WholeBrainWM_HRF_20201208.mat')
% [threshold,~] = ggmm_threshold_prf(results.R2,results.R2);
threshold = 0;
% load('VOF_threshold.mat')
pxtodeg = 16.0/200;
dim=size(mask.img);
tmp=zeros(dim(1)*dim(2)*dim(3),1);
mask.hdr.dime.datatype=64;
mask.hdr.dime.bitpix=64;
tmp1=mask; %tmp2=mask1;
tmp1.img=uint16(tmp);
results.ang(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))=results.ang;
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
% save_nii(tmp1,'angHRF.nii.gz')

tmp1.img=tmp;
results.ecc(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))=results.ecc*pxtodeg;
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
% save_nii(tmp1,'eccHRF.nii.gz')

tmp1.img=tmp;
results.rfsize(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))=results.rfsize*pxtodeg;
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
% save_nii(tmp1,'rfsizeHRF.nii.gz')

tmp1.img=tmp;
results.gain(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))=results.gain;
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
% save_nii(tmp1,'gainHRF.nii.gz')

tmp1.img=tmp;
results.expt(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))=results.expt;
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
% save_nii(tmp1,'exptHRF.nii.gz')

numinhrf = 50;
nTimeHRF = 1.*( 0 : numinhrf-1 ); % TR = 1 sec
fHRF2 = @(nPara,nTime) vflatten(((nTime.^(nPara(1)-1).*nPara(2).^(nPara(1)).*exp(-nPara(2).*nTime))./gamma(nPara(1)))- ...
        ((nTime.^(nPara(3)-1).*nPara(4).^(nPara(3)).*exp(-nPara(4).*nTime))./(nPara(5)*gamma(nPara(3))))); % double gamma hrf from SPM
paramsA = [results.a1 results.b1 results.a2 results.b2 results.c]; 
% paramsA(results.R2<threshold) = nan(1,5);
for ihrf = 1:length(paramsA)
    hrfdata(ihrf,:) = fHRF2(paramsA(ihrf,:),nTimeHRF);
    [~,ttp(ihrf)] = max(hrfdata(ihrf,:));
end
tmp1.img=tmp;
ttp(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))= ttp';
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
save_nii(tmp1,'ttpHRF.nii.gz')

tmp1.img=tmp;
results.R2(results.R2<threshold) = nan;
tmp1.img(find(mask.img>0))=results.R2;
tmp1.img=reshape(tmp1.img,dim(1),dim(2),dim(3));
save_nii(tmp1,'R2HRF.nii.gz')