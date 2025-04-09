create database LojaDB

use LojaDB
	
create table Clientes(
    ID int primary key identity(1,1),
    Nome varchar(100) not null,
    Email varchar(150) not null,
    dataCadastro date not null,
)

create table Produtos(
    ID int primary key identity(1,1),
    NomeProduto varchar(100) not null,
    Preco float not null,
)

select * from Clientes

insert into Clientes(Nome,Email,dataCadastro)
values ('Pedro Antonio Karkar','Pedrokarkar@ciac.com.br','02-06-2025')

insert into Clientes(Nome,Email,dataCadastro)
values ('Abdalla El Dib','Abdalla.Dib@gmail.com','02-06-2025')

insert into Clientes(Nome,Email,dataCadastro)
values ('Mateus Santos Baggio','MateusBaggio@gmail.com','02-06-2025')

insert into Clientes(Nome,Email,dataCadastro)
values ('Gabriel Martins De Castro','Gabriel.Castro@gmail.com','02-07-2025')

insert into Clientes(Nome,Email,dataCadastro)
values ('Arthur Carvalho Rocco Pessoa','Arthur.Obitos@gmail.com','02-07-2025')    

select * from Produtos

insert into Produtos(NomeProduto,Preco)
values ('Alface',5.20)

insert into Produtos(NomeProduto,Preco)
values ('uva',9.97)

insert into Produtos(NomeProduto,Preco)
values ('Pistache','120')

insert into Produtos(NomeProduto,Preco)
values ('Damasco','45')

insert into Produtos(NomeProduto,Preco)
values ('Tâmara','190')

update Produtos set Preco=4.40
where ID=1

update Clientes set Email='Abdalla.dib.10@gmail.com'
where ID=2

update Clientes set Email='pedroAkarkar@gmail.com'
where ID=1

delete from Clientes
where ID=3

delete from Produtos
where ID=3

delete from Produtos 
where ID=4

delete from Clientes 
where ID=2

update Clientes set Email='Pedro.Karkar@ciac.com.br'
where ID=1
