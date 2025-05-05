create database ac02

use ac02

create table carros(
    id int primary key identity(1,1),
    placa char(7) not null,
    modelo varchar(75)not null,
    ano date
)

create table motoristas(
    id int primary key identity(1,1),
    nome varchar(100) not null,
    cnh char(11) not null,
    pontos_cnh int not null
)

create table multas(
    id int primary key identity(1,1),
    carroid int,
    data_multa date,
    pontos int,
    constraint fk_id_idcarro foreign key (carroid) references carros(id)
)

create table prontuarios(
    id int primary key identity(1,1),
    motoristaid int,
    multaid int ,
    data_associacao date not null,
    constraint fk_id_motoristaid foreign key(motoristaid) references motoristas(id),
    constraint fk_id_multaid foreign key(multaid) references multas(id)
)

create table carro_motorista( 
	id int primary key identity(1,1), 
	carro_id int not null, motorista_id int not null, 
	constraint fk_carro foreign key (carro_id) references carros(id), 
	constraint fk_motorista foreign key (motorista_id) references motoristas(id) 
) 

create trigger tr_inserir_multa
on multas
after insert
as
begin

    insert into prontuarios (motoristaid, multaid, data_associacao)
    select 
        carro_motorista.motorista_id,  
        inserted.id,      
        getdate() 
    from
        inserted inner join carro_motorista on inserted.carroid = carro_motorista.carro_id
    
   
    update motoristas
    set pontos_cnh = motoristas.pontos_cnh + inserted.pontos
    from
	motoristas inner join prontuarios on motoristas.id = prontuarios.motoristaid
	inner join inserted on prontuarios.multaid = inserted.id
end





create procedure  sp_inserir_carro
    @placa char(7),
    @modelo varchar(75),
    @ano date
as
begin
    insert into carros (placa, modelo, ano)
    values (@placa, @modelo, @ano)
end



create procedure  sp_inserir_motorista
    @nome varchar(100),
    @cnh char(11),
    @pontos_cnh int
as
begin
    insert into motoristas (nome, cnh, pontos_cnh)
	values (@nome, @cnh, @pontos_cnh)
end




create procedure  sp_carro_motorista
    @carro_id int,
    @motorista_id int
as
begin
    insert into carro_motorista (carro_id, motorista_id)
    values (@carro_id, @motorista_id)
end




create procedure  sp_inserir_multa
    @carroid int,
    @data_multa date,
    @pontos int
as
begin
    insert into multas (carroid, data_multa, pontos)
    values (@carroid, @data_multa, @pontos)
end






create procedure  sp_obter_todos_motoristas_multas
as
begin
    select
        motoristas.id,
        motoristas.nome,
        motoristas.cnh,
        motoristas.pontos_cnh,
        multas.id,
        multas.data_multa,
        multas.pontos,
        carros.placa,
        carros.modelo
    from
        motoristas
        inner join prontuarios on motoristas.id = prontuarios.motoristaid
        inner join multas on prontuarios.multaid = multas.id
        inner join carros on multas.carroid = carros.id
    order by motoristas.nome, multas.data_multa desc
end





create procedure  sp_obter_motorista_multas
    @motorista_id int
as
begin
    select 
        motoristas.id,
        motoristas.nome,
        motoristas.cnh,
        motoristas.pontos_cnh,
        multas.id,
        multas.data_multa,
        multas.pontos,
        carros.placa,
        carros.modelo
   from
        motoristas
        inner join prontuarios on motoristas.id = prontuarios.motoristaid
        inner join  multas on prontuarios.multaid = multas.id
        inner join  carros on multas.carroid = carros.id
	where
        motoristas.id = @motorista_id
    order by multas.data_multa desc
end





create procedure sp_obter_pontos_motorista
    @motorista_id int
as
begin
    select
        id,
        nome,
        cnh,
        pontos_cnh
    from
        motoristas
    where 
        id = @motorista_id
end


-- add motorista
exec sp_inserir_motorista 'Gabriel Martins', '48828608722', 5;
exec sp_inserir_motorista 'Pedro Karkar', '88425590833', 0;
exec sp_inserir_motorista 'Abdalla El Dib', '47467482606', 2;

-- add carro
exec sp_inserir_carro 'XHZ1L19', 'Mercedes-Benz 500 SL', '1990-01-01'
exec sp_inserir_carro 'DUS4M22', 'Audi R8 V10', '2010-02-02'
exec sp_inserir_carro 'EJS4Y58', 'Rolls-Royce Spectre', '2025-03-03'


-- linkar carro no motorista
exec sp_carro_motorista 1, 1;
exec sp_carro_motorista 2, 2;
exec sp_carro_motorista 3, 3;

-- registra a multa
exec sp_inserir_multa 1, '1998-05-10', 5;
exec sp_inserir_multa 2, '2000-07-09', 2;
exec sp_inserir_multa 3, '2024-10-12', 3;

-- ver as multas
exec sp_obter_motorista_multas 1;
exec sp_obter_motorista_multas 2;
exec sp_obter_motorista_multas 3;

