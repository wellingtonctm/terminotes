function mostrar_nota() {
	id=$1

	if [[ $id == "" ]]; then
	    clear
		echo "Visualizar/Editar uma nota"
		echo "-------------------------"

		declare -A notas

		# Listar IDs e títulos das notas
		eval "notas=( $(sqlite3 "$ARQUIVO_BD" "SELECT '[' || id || ']=\"' || titulo || '\"' FROM Nota") )"

		for key in "${!notas[@]}"; do
			echo "$key) ${notas[$key]}"
		done

		read -p "#?) " id
	fi;

	if [[ "$id" == "0" || ! -v notas[$id] ]]; then
		return 1
	fi

	conteudo=$(sqlite3 "$ARQUIVO_BD" "SELECT conteudo FROM Nota WHERE id = $id")
	temp_file=$(mktemp "/tmp/${notas[$id]}.XXXXXX")
	echo "$conteudo" > "$temp_file"

	# Abrir o editor Vim para visualizar/editar a nota
	vim "$temp_file"

	# Atualizar o conteúdo da nota no banco de dados
	novo_conteudo=$(cat "$temp_file")
	sqlite3 "$ARQUIVO_BD" "UPDATE Nota SET conteudo = '$novo_conteudo' WHERE id = $id"

	rm "$temp_file"
}