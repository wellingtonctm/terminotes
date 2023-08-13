#!/bin/bash

. config

listar_notas() {
	clear

	notas=$(
		sqlite3 "$ARQUIVO_BD" -separator '|' <<- EOF
			SELECT n.titulo, GROUP_CONCAT(t.nome, ', ') AS tags
			FROM Nota n
			LEFT JOIN NotaTag nt ON n.id = nt.nota_id
			LEFT JOIN Tag t ON nt.tag_id = t.id
			GROUP BY n.id;
		EOF
	)

	if [[ -z "$notas" ]]; then
		echo "Nenhuma nota encontrada."
	else
		i=0

		while IFS="|" read -r titulo tags; do
			echo "$((++i)) $titulo  ($tags)"
		done <<< "$notas"
	fi
}

listar_notas