create database aulaStoredProcedure

use aulaStoredProcedure

create table alunos(
id int primary key identity (1,1),
nome varchar(50) not null,
email varchar(50),
endereco varchar(100) not null
)

create procedure inserirAluno
@nome varchar(50),
@email varchar(50),
@endereco varchar(100)
as
insert into alunos(nome, email, endereco)
values (@nome,@email,@endereco)
select id,nome,email,endereco from alunos
order by id desc

exec inserirAluno 'Maria','maria@fiap.com.br','Rua teste'