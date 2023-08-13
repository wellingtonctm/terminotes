#!/bin/bash

. config;

criar_tabelas() {
	sqlite3 "$ARQUIVO_BD" <<- EOF
		-- Tabela de Nota
		CREATE TABLE IF NOT EXISTS Nota (
			id INTEGER PRIMARY KEY,
			titulo TEXT NOT NULL,
			conteudo TEXT NOT NULL,
			data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		);

		-- Tabela de Tag
		CREATE TABLE IF NOT EXISTS Tag (
			id INTEGER PRIMARY KEY,
			nome TEXT NOT NULL
		);

		-- Tabela de Relacionamento NotaTag
		CREATE TABLE IF NOT EXISTS NotaTag (
			nota_id INTEGER,
			tag_id INTEGER,
			PRIMARY KEY (nota_id, tag_id),
			FOREIGN KEY (nota_id) REFERENCES Nota(id) ON DELETE CASCADE,
			FOREIGN KEY (tag_id) REFERENCES Tag(id) ON DELETE CASCADE
		);
	EOF
}

criar_tabelas;