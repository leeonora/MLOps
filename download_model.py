import wandb
import torch
from src.my_project.model import this_model
import os

run = wandb.init()
artifact = run.use_artifact('s193602-danmarks-tekniske-universitet-dtu/corrupt_mnist/corrupt_mnist_model:v0', type='model')
artifact_dir = artifact.download("corrupt_mnist_model")
model = this_model()
model.load_state_dict(torch.load("corrupt_mnist_model/model.pth"))

