# qunex_run_recipe

Repository for the QuNex recipes manuscript.

The repository has the following structure:

- `example_1`: the first example from the manuscript,
- `example_2`: the second example from the manuscript,
- `recipes`: the recipes library (see below).

## The recipes library

Under the `recipes` folder you can find ready-to-use QuNex recipes. For recipes to run, you need to set the following OS environment variables:

- `QX_RAWDATA_FOLDER`: path to the folder with raw data to be used,
- `QX_RECIPE_FOLDER`: path to this repository on the local system,
- `STUDY_FOLDER`: location of the QuNex study where the results will end up.

The recipe library containes the following recipes:

- `cnp`: the CNP dataset in BIDS format. The recipe will process a session through HCP minimal preprocessing and denoising pipelines.
- `crhd_bwh`: the CRHD BWH dataset. The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses.
- `d1_ts`: the D1 TS dataset. The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses.
- `hca`: the HCP aging dataset. The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses.
- `hca_long`: the HCP aging longitudinal dataset. The recipe will run 2 longitudinal sessions through HCP minimal preprocessing, denoising and diffusion pipelines. After that it will longitudinally process everything through the longitudinal versions of the pipelines as well.
- `hcd`: the HCP development dataset. The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses.
- `hcp_prisma`: data acquired on a Siemens Prisma 3T scanner using the HCP acquisition protocol. The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses. The recipe will also run the session through all of the QuNex diffusion processing commands.
- `hcya`: the HCP young adults dataset. The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses.
- `sb_philips`: a session acquired on a 3T Philips Achivea scanner, using a legacy acquisition protocol (no T2w). The recipe will process a session through HCP minimal preprocessing and denoising pipelines, run QC steps and prepare outputs for functional connectivity analyses.

Within each recipe's folder you will find the recipe file as well as other files that are required for processing (the mapping file for providing additional info about images and the parameters file that contains core processing parameters).
