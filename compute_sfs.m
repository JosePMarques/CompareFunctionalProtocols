function [sfs, sfs_img] = compute_sfs(meanimg, stdimg, csf, gm)
% meanimg, stdimg, csfmask and gmmask are loaded niftis.
% I assume that meanimg and stdimg were already registered to the
% anatomical. So please, do that yourself.
% flirt -in meanimg -ref anat_bet -omat image_mat -out mean_reg
% flirt -in stdimg -ref anat_bet -applyxfm -init image_mat -out std_reg


mu_global = mean(single(meanimg.img(:)));
mu_gm = meanimg.img .* single(gm.img);
std_gm = stdimg.img .* single(gm.img);
std_csf = mean(isfinite(single(stdimg.img(:)) .*single(csf.img(:))));

sfs_img = (mu_gm ./mu_global) .* (std_gm ./std_csf);
sfs = mean(sfs_img(logical(gm.img)));

