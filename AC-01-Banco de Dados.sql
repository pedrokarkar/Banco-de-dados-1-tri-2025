create database ac01	

use ac01

create table clientes(
	idCliente int primary key identity(1,1),
	nome varchar(50) not null,
	cpf char(11)not null
)

create table pecas(
	idPecas int primary key identity(1,1),
	nome varchar(50) not null,
	preco decimal(5,2) not null
)

create table pc(
	idPC int primary key identity(1,1),
	idCliente int not null,
	dataCompra date not null,
	constraint fk_pc_clientes foreign key (idCliente) references clientes(idCliente)
)

create table pc_peca(
	id int primary key identity(1,1),
	idPC int not null,
	idPecas int not null,
	constraint fk_pc_pc_peca foreign key (idPC) references pc(idPC),
	constraint fk_pecas_pc_peca foreign key (idPecas) references pecas(idPecas)
)

insert into clientes (nome ,cpf)
values('Gabriel','59054303492')
insert into clientes (nome,cpf)
values('Karkar','76015503386')
insert into clientes (nome,cpf)
values('Ramalho','50842767916')
insert into clientes (nome,cpf)
values('Baggio','02029332372')
insert into clientes (nome,cpf)
values('Arthur','57461447629')

insert into pecas (nome ,preco)
values('nvme 500GB', 400)
insert into pecas (nome,preco)
values('placa mae Intel B660',900.50)
insert into pecas (nome,preco)
values('fonte 550W generica',325.90)
insert into pecas (nome,preco)
values('intel Core i5-12',999.99)
insert into pecas (nome,preco)
values('MSI GeForce RTX 5090',999.99)

insert into pc (idCliente,dataCompra)
values(1,'2025-02-21')
insert into pc (idCliente,dataCompra)
values(2,'2025-02-22')
insert into pc (idCliente,dataCompra)
values(3,'2025-02-23')
insert into pc (idCliente,dataCompra)
values(4,'2025-02-24')
insert into pc (idCliente,dataCompra)
values(5,'2025-02-25')

insert into pc_peca (idPecas, idPC)
values(1,4)
insert into pc_peca (idPecas, idPC)
values(2,3)
insert into pc_peca (idPecas, idPC)
values(3,1)
insert into pc_peca (idPecas, idPC)
values(4,2)
insert into pc_peca (idPecas, idPC)
values(5,2)

--1
select pc.idPC ,pc.dataCompra, clientes.nome as nomeCliente, clientes.cpf as cpfClientes from pc 
inner join clientes on pc.idCliente = clientes.idCliente

--2
select pc.idPC ,pc.dataCompra, clientes.nome as nomeCliente, clientes.cpf as cpfClientes from pc 
inner join clientes on pc.idCliente = clientes.idCliente
where clientes.nome = 'Arthur' 

--3
select pc_peca.idPC, pc_peca.idPecas, pecas.nome   from pc_peca 
inner join pecas on pecas.idPecas = pc_peca.idPecas
where pecas.idPecas = 2

--4
select pc.idPC ,pc.dataCompra, pecas.nome as nomePeca, pecas.preco, clientes.nome as nomeCliente, clientes.cpf as cpfClientes from pc 
inner join clientes on pc.idCliente = clientes.idCliente
inner join pc_peca on pc.idPC = pc_peca.idPC
inner join pecas on pc_peca.idPecas = pecas.idPecas
where pc.idPC = 1

--5
select pc.idPC ,pc.dataCompra, pecas.nome as nomePeca, pecas.preco, clientes.nome as nomeCliente, clientes.cpf as cpfClientes from pc 
inner join clientes on pc.idCliente = clientes.idCliente
inner join pc_peca on pc.idPC = pc_peca.idPC
inner join pecas on pc_peca.idPecas = pecas.idPecas
where pecas.idPecas = 1
