###### Example script to run the code ######
#!/bin/sh

# model_type: Supports cnn, vggnet, googlenet, resnet20, resnet32.
# batch_size: Use batch size 64 for cnn, otherwise use 128.
# num_model:  # of models to ensemble.
# loss_type:  Supports independent, mcl, cmcl_v0, cmcl_v1.
# k:          Overlap parameter.
# beta:       Penalty parameter.
# feature_sharing: Use feature sharing if True.
COMMAND="python src/ensemble.py \
--model_type=cnn \
--batch_size=64 \
--num_model=5 \
--loss_type=cmcl_v1 \
--k=4 \
--gpu=$1 \
--beta=$2 \
--feature_sharing=True"
COMMAND_TRAIN="$COMMAND --test=False"
COMMAND_TEST="$COMMAND --test=True"

Model="run-gpu-$1-beta-$2"

# run train
echo $COMMAND_TRAIN
$COMMAND_TRAIN > "log_$MODEL"

# run test
echo $COMMAND_TEST
$COMMAND_TEST >> "log_$MODEL"
