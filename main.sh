#!/bin/bash

. config

criar_nota() {
	clear
	echo "Criar uma nova nota"
	echo "-------------------"
	
	read -p "Título da nota: " titulo
	temp=$(mktemp)

	vim "$temp"
	
	conteudo=$(cat "$temp")
	rm "$temp"

	read -p "Tags (separadas por vírgulas): " tags_input
	tags=($(echo "$tags_input" | tr ',' ' '))
	
	data_utc=$(date +"%Y-%m-%d %H:%M:%S");

	nota_id=$(
		sqlite3 "$ARQUIVO_BD" <<- EOF
			INSERT INTO Nota (titulo, conteudo, data_criacao) VALUES ('$titulo', '$conteudo', '$data_utc');
			SELECT last_insert_rowid();
		EOF
	)

	for tag in "${tags[@]}"; do
		sqlite3 "$ARQUIVO_BD" <<- EOF
			INSERT INTO Tag (nome) VALUES ('$tag');
			INSERT INTO NotaTag (nota_id, tag_id) VALUES ('$nota_id', last_insert_rowid());
		EOF
	done
	
	echo "Nota criada e salva com sucesso!"
}

criar_tabelas;
criar_nota;