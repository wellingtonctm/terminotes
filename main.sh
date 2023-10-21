criar_tabelas

if [[ $1 == "" ]]; then
	listar_notas
	exit 0
fi

case $1 in
	-n)
		criar_nota
		;;
	-l)
		listar_notas
		;;
	-s)
		shift
		mostrar_nota $1
		;;
	*)
		echo "Opção inválida!"
		exit 1
		;;
esac