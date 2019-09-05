echo "Digite o path do Open VINO"
echo "" >> ~/.bashrc
echo "/opt/intel/openvino" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "####################### OPEN VINO VARIABLES CONFIG #############################" >> ~/.bashrc
echo "# OPEN VINO PATH" >> ~/.bashrc
echo "export OPEN_VINO_PATH=/opt/intel/openvino" >> ~/.bashrc
echo cat ./variables.txt >> ~/.bashrc
echo "" >> ~/.bashrc
echo "####################### END OFFOPEN VINO VARIABLES CONFIG #############################" >> ~/.bashrc
source ~/.bashrc
echo Concluido