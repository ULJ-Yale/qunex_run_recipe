# execute the recipe
qunex_container run_recipe \
  --recipe_file="/data/qunex_run_recipe/example_2/dtifit_noddi.yaml" \
  --recipe="dtifit_noddi" \
  --nv \
  --scheduler="SLURM,time=01-00,mem=32G,gres=gpus:1,jobname=qx" \
  --container="/data/qx_containers/qunex_suite-1.3.1.sif"
