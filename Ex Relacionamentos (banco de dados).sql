CREATE DATABASE exRelacionamento

USE exRelacionamento

CREATE TABLE personagens(
	id INT PRIMARY KEY IDENTITY(1, 1),
	raca VARCHAR(20) NOT NULL,
	nome VARCHAR(80) NOT NULL,
	classe VARCHAR(20) NOT NULL
)

CREATE TABLE itens(
	id INT PRIMARY KEY IDENTITY(1, 1),
	nome VARCHAR(80) NOT NULL,
	categoria VARCHAR(20) NOT NULL
)

create table personagemItem(
	id INT PRIMARY KEY IDENTITY(1, 1),
	id_personagem INT NOT NULL,
	id_item INT NOT NULL,
	CONSTRAINT fk_personagem_item_personagem FOREIGN KEY (id_personagem)
	REFERENCES personagens(id),
	CONSTRAINT fk_personagem_item_item FOREIGN KEY (id_item)
	REFERENCES itens(id)
)

CREATE PROCEDURE inserirPersonagem
@raca VARCHAR(20),
@nome VARCHAR(80),
@classe VARCHAR(20)
AS INSERT INTO personagens(raca, nome, classe)
VALUES(@raca, @nome, @classe)
SELECT id,raca,nome,classe FROM personagens
ORDER BY id DESC

CREATE PROCEDURE inserirItem
@nome VARCHAR(80),
@categoria VARCHAR(20)
AS INSERT INTO itens(nome, categoria)
VALUES(@nome, @categoria)
SELECT id,nome,categoria FROM itens
ORDER BY id DESC

CREATE PROCEDURE atribuirItem
@id_personagem INT,
@id_item INT
AS INSERT INTO personagemItem(id_personagem, id_item)
VALUES(@id_personagem, @id_item)
SELECT id, id_personagem, id_item FROM personagemItem
ORDER BY id DESC

exec inserirPersonagem 'Orc', 'Elias', 'Guerreiro'

exec inserirItem 'Espada', 'Arma Branca'

exec atribuirItem 1, 1