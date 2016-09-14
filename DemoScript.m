% you could make this into a function

%%
% protocol 1 parameters
file{1}.name='fMRI_rest_cmrr_mb8.nii';
file{1}.TR=735;
file{1}.TE=39;
file{1}.res=[2.4 2.4 2.4];
file{1}.outputname='MB8';
%% protocol 2 parameters
file{2}.name='fMRI_rest_cmrr_mb8.nii';
file{2}.TR=600;
file{2}.TE=33;
file{2}.res=[2.4 2.4 2.4];
file{2}.outputname='MB8short';
%% protocol 3 parametners

%% aantomical image of subject or some MNI T1w
AnatomicalT1w='t1_mprage_sag_p2_iso_1_0'
system(['bet ',AnatomicalT1w,' brain']);

fslviewdisplay=['fslview brain '];
for protocols=1:length(files)
    %% compute bold sensitivity per volume
    tCNRperTimeVolume(file{protocols});
    
    %% Coregister it to anatomical 
    system(['flirt -cost normmi -dof 6 -in ',file{protocols}.outputname,'_tCNR -ref brain -out ',file{protocols}.outputname,'_tCNR_anat']);
    fslviewdisplay=[fslviewdisplay,file{protocols}.outputname,'_tCNR_anat '];

end;
%% and show the BOLD sensitivity of each scan overlayed in a reference anatomical (important if you are comparing protocols with different resolution and field of view)
    
unix([fslviewdisplay,' &']);
