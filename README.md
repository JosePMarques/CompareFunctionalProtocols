# CompareFunctionalProtocols

This simple MATLAB script (DemoScript.m) allows a quantitative comparison of two functional protocols 
and their sensitivity to BOLD extravascular activation in a fixed amount of time.

As an output your different functional protocols tCNR (temporal contrast to noise ratio normalized per volume) 
is output overlayed on the subjects anatomical image.
To make sure the outputs are comparable, you should introduce the relevant parameters of sequence (TR,TE,res), 
as well as the expected T2* of your tissue of interest. 
As a guideline T2* of cortical GM is 45 and 33 ms at 3 and 7T respectively.

For optimum results the functional data used as input could have been put through a motion correction pipeline 

The script uses fsl tools such as fslmaths, bet, flirt and fslview which should be on your path.

