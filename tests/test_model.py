from my_project.model import this_model
import torch
import pytest

def test_model():
    model = this_model()
    x = torch.randn(1, 1, 28, 28)
    y = model(x)
    assert y.shape == (1, 10)

def test_error_on_wrong_shape():
    model = this_model()
    with pytest.raises(ValueError, match='Expected input to a 4D tensor'):
        model(torch.randn(1,2,3))
    with pytest.raises(ValueError, match='Expected each sample to have shape [1, 28, 28]'):
        model(torch.randn(1,1,28,29))

# to run this test, use the following command:
# pytest tests/
# to run this test with coverage, use the following command:
# coverage run -m pytest tests/
# to see the coverage report, use the following command:
# coverage report