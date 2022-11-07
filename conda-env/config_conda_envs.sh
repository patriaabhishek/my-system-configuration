conda activate

conda env create -f ./py-env.yml
conda env create -f ./snowflake-env.yml

PYENV_LOCATION=$(conda env list | grep 'py-env' | grep -o '/.*$')
cp py-env-condarc ${PYENV_LOCATION}"/.condarc"

SNOWFLAKEENV_LOCATION=$(conda env list | grep 'snowflake-env' | grep -o '/.*$')
cp snowflake-env-condarc ${SNOWFLAKEENV_LOCATION}"/.condarc"

