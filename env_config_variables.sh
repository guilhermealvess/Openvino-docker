echo "Digite o path do Open VINO"
read open_vino_path
echo "" >> ~/.bashrc
echo "####################### OPEN VINO VARIABLES CONFIG #############################" >> ~/.bashrc
echo "# OPEN VINO PATH" >> ~/.bashrc
echo "export OPEN_VINO_PATH=$open_vino_path" >> ~/.bashrc
cat ./variables.txt >> ~/.bashrc
echo "" >> ~/.bashrc
echo "####################### END OFFOPEN VINO VARIABLES CONFIG #############################" >> ~/.bashrc
source ~/.bashrc
echo Concluido