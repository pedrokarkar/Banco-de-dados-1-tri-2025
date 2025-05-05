create database aulaTrigger

use aulaTrigger

create table caixa(
	dataVenda date,
	saldo_inicial float,
	saldo_final float
)

insert into caixa
values(getdate(),100,100)

select * from caixa

create table vendas(
	dataVenda date,
	codigo int,
	valor float
)

create trigger tgr_novaVenda
on vendas for insert
as
begin
		declare
		@valor float,
		@data datetime
		select @data=dataVenda,@valor=valor from inserted
		update caixa set saldo_final=saldo_final+@valor
		where dataVenda=@data
end

create trigger tgr_excluirVenda
on vendas for delete
as
begin
		declare
		@valor float,
		@data datetime
		select @data=dataVenda,@valor=valor from deleted
		update caixa set saldo_final=saldo_final-@valor
		where dataVenda=@data
end

insert into vendas
values (getdate(),2,50)

delete from vendas
where codigo=1

select * from caixa
select * from vendas