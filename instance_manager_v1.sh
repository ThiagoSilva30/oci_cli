#!/bin/bash
## Oracle Cloud Infrastructure
## Instance Manager - Version 1.0 - Date - 29/03/2020
## Autor: Thiago Gama da Silva
## Cloud Specialist - OCI
## E-mail: t.gama.silva@gmail.com 
## Objetivo: Script para gerenciar instancias de Maquinas virtuais na OCI


function mostramenu()
{
   clear
   echo "===================================================================="   
   echo " Menu Principal - Instance Manager - OCI"
   echo "===================================================================="   
   echo ""
   echo "1. Listar Instancias"
   echo "2. Iniciar Instancia"
   echo "3. Parar Instancia"
   echo "4. Load Balance"
   echo "5. Banco de dados"
   echo "6. Informações de usuarios"
   echo "7. Sair"
   echo ""
   if [ "$1" ]; then echo -n "Escolha a opção:" ; fi
}

function _menu()
{
	clear
	while true
	do
		mostramenu normal 
		read escolha
		case "$escolha" in
			1) Listarinstancias ;;
			2) IniciarInstancia ;;
			3) PararInstancia ;;
			4) LoadBalance ;;
			5) DB ;;
			6) Usuarios ;;
			7) Sair ;;
		*) Desconhecida ;;
		esac
	done
}

function Listarinstancias()
{
read -p "Digite o ID do seu compartment: " OCID	
oci compute instance list -c $OCID --output table --query "data [*].{Name:\"display-name\",OCID:id, Status:\"lifecycle-state\", Created_in: \"time-created\"}"
echo ""
echo "Pressione ENTER para continuar..."
read _ENTER
}

function IniciarInstancia()
{
read -p "Digite o ID do seu compartment: " OCID
oci compute instance list -c $OCID --output table --query "data [*].{Name:\"display-name\",OCID:id, Status:\"lifecycle-state\", Created_in: \"time-created\"}"
echo ""
read -p "Digite o ID da instancia que deseja iniciar: " INS_OCID
oci compute instance action --action start --instance-id $INS_OCID --wait-for-state RUNNING
echo ""
echo "Pressione ENTER para continuar..."
read _ENTER
}

function PararInstancia()
{
read -p "Digite o ID do seu compartment: " OCID
oci compute instance list -c $OCID --output table --query "data [*].{Name:\"display-name\",OCID:id, Status:\"lifecycle-state\", Created_in: \"time-created\"}"
echo ""
read -p "Digite o ID da instancia que deseja parar: " INS_OCID
oci compute instance action --action softstop --instance-id $INS_OCID --wait-for-state STOPPED 
echo ""
echo "Pressione ENTER para continuar..."
read _ENTER
}

function Usuarios()
{
oci iam user list --output table  --query "data[*].{Name:\"name\", Status:\"lifecycle-state\",ID:id}"
echo ""
echo "Pressione ENTER para continuar..."
read _ENTER
}

function Sair()
{
	echo -e "Obrigado por usar o Instance Manager!"
	read -t 2
	clear
	exit
}

function Desconhecida()
{
	echo -n "Opção inexistente. Escolha de 1 a 7"
	read -t 5
}

function main()
{
   _menu # Menu principal
}

main "${@#}"
 
exit
