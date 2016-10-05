function [tSNRvol tCNRvol]=tCNRperTimeVolume(params,varargin)

%usage [tSNRvol tCNRvol]=tCNRperTimeVolume(params,varargin)
% params.name='fMRI_rest_cmrr_mb8.nii';     name of 4D file 
% params.TR=735;                            TR in ms
% params.TE=39;                             TE in ms
% params.res=[2.4 2.4 2.4];                 resolution x y z in mm
% params.outputname='MB8';                  how you want the output to be saved
%                                            can be left empty, in which case the output files are temp_
% params.T2star=45;                         T2 start of gray matter of interest at a given field and resolution
%                                            can be left empty, in which case 45 ms is used which is the 3T T2* GM           
%                                            if doing the experiments at 7T
%                                            the value shold be set to
%                                            28-33ms
%                                            
% currently varargin is not really used



unix(['fslmaths ',(params.name),' -Tmean tempMean']);
unix(['fslmaths ',(params.name),' -Tstd tempStd']);

if ~isfield(params,'outputname')
    params.outputname=['temp'];
end;

if ~isfield(params,'T2star')
    params.T2star=45; % T2 start of grey matter at 3T
end;

unix(['fslmaths tempMean -div tempStd ',params.outputname,'_tSNR.nii.gz']);
tSNRvol=load_untouch_nii([params.outputname,'_tSNR.nii.gz']);

unix('rm tempMean.nii.gz');
unix('rm tempStd.nii.gz');

tCNRvol = tSNRvol;
tCNR_perTime_perVolume = @(tSNR,TE,TR,T2star,vol) tSNR * TE * exp( -TE / T2star ) /( sqrt( TR * vol ) );

tCNRvol.img = tCNR_perTime_perVolume( tSNRvol.img , params.TE , params.TR , params.T2star , prod(params.res) );

save_untouch_nii(tCNRvol,[params.outputname,'_tCNR.nii.gz'])

