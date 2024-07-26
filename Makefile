PYENV_VERSION=3.11.1
PROJECT_NAME=pytorch-translation-recipes
BINARIES = $(HOME)/.pyenv/versions/${PROJECT_NAME}/bin

setup_env:
	pyenv virtualenv ${PYENV_VERSION} ${PROJECT_NAME}
	pyenv local ${PROJECT_NAME}
	pip install pip==24.0
	pip install --no-cache-dir -r requirements.txt
	
teardown_env:
	# pyenv deactivate ${PROJECT_NAME}
	pyenv uninstall ${PROJECT_NAME}

download_data:
	@echo "[Start]: download MNIST"
	${BINARIES}/python -m src.pipelines.download_images
	@echo "[Done]: download MNIST"
	
train_step:
	@echo "[Start]: training workflow"
	${BINARIES}/python -m src.pipelines.train
	@echo "[Done]: training workflow"

eval_step:
	@echo "[Start]: eval workflow"
	${BINARIES}/python -m src.pipelines.eval -t 20240604T175223
	@echo "[Done]: eval workflow"

setup: setup_env
teardown: teardown_env

ingest: download_data
train: train_step
eval: eval_step

wf: ingest train

remove: teardown_env

greet: 
	sh ./scripts/greet.sh