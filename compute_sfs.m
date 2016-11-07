function [sfs] = compute_sfs(meanimg, stdimg, csf, gm, brain)
% Daniel Gomez 06.11.16
% COMPUTE_SFS computes the Signal Fluctuation Sensitivity as described in:
% DeDora 2016 - SFS: An Improved Metric for Optimizing Detection of RSNs.
% doi:10.3389/fnins.2016.00180

% meanimg, stdimg, csf, gm and brain are loaded niftis.
% I assume that meanimg and stdimg were already registered to the
% anatomical. So please, do that yourself:
% flirt -in meanimg -ref anat_bet -omat image_mat -out mean_reg
% flirt -in stdimg -ref anat_bet -applyxfm -init image_mat -out std_reg
% Apologies if the order of arguments is confusing. Blame MATLAB for not
% accepting key=value arguments, not me.


mu_global = mean_within_mask(meanimg, brain);
mu_gm = mean_within_mask(meanimg, gm);
std_gm = mean_within_mask(stdimg, gm);
std_csf = mean_within_mask(stdimg, csf);

sfs = (mu_gm ./mu_global) .* (std_gm ./std_csf);


function value = mean_within_mask(what, mask)
    value = mean(what.img(logical(mask.img)));
end

end
