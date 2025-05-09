create database transacao
use transacao
-- Criando tabela de clientes
CREATE TABLE Clientes (
 ClienteID INT PRIMARY KEY,
 Nome VARCHAR(100),
 Saldo DECIMAL(10, 2)
);
-- Inserindo dados de exemplo
INSERT INTO Clientes (ClienteID, Nome, Saldo)
VALUES
 (1, 'Cliente A', 1000.00),
 (2, 'Cliente B', 500.00);
-- Criando a stored procedure para transferência de saldo
CREATE PROCEDURE TransferirSaldoEntreClientes
 @ClienteOrigem INT,
 @ClienteDestino INT,
 @ValorTransferencia DECIMAL(10, 2)
AS
BEGIN
 BEGIN TRANSACTION TransferirSaldo;
 -- Verificando se o saldo do cliente de origem é suficiente para a transferência
 IF ((SELECT Saldo FROM Clientes WHERE ClienteID = @ClienteOrigem) >=
@ValorTransferencia)
 BEGIN
 -- Atualizando saldo do cliente de origem
 UPDATE Clientes
 SET Saldo = Saldo - @ValorTransferencia
 WHERE ClienteID = @ClienteOrigem;
 -- Atualizando saldo do cliente de destino
 UPDATE Clientes
 SET Saldo = Saldo + @ValorTransferencia
 WHERE ClienteID = @ClienteDestino;
 COMMIT TRANSACTION TransferirSaldo;
 PRINT 'Transferência realizada com sucesso!';
 END
 ELSE
 BEGIN
 ROLLBACK TRANSACTION TransferirSaldo;
 PRINT 'Saldo insuficiente para realizar a transferência!';
 END
END;
EXEC TransferirSaldoEntreClientes
@ClienteOrigem = 2, @ClienteDestino = 1, @ValorTransferencia = 10000.00;
select * from Clientes