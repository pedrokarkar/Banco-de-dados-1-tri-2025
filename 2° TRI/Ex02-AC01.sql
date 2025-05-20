create database AC01EX2

use AC01EX2

CREATE TABLE Pacientes (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Medicado INT DEFAULT 0
)

CREATE TABLE HistoricoMedicamentos (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PacienteID INT NOT NULL,
    Medicamento VARCHAR(100) NOT NULL,
    DataAdministracao DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Paciente FOREIGN KEY (PacienteID) REFERENCES Pacientes(ID)
)

CREATE PROCEDURE sp_AdministrarMedicamento
    @PacienteID INT,
    @Medicamento VARCHAR(100)
AS
BEGIN
    BEGIN TRANSACTION;
    
    DECLARE @JaRecebeu INT
    
    SELECT @JaRecebeu = COUNT(*)
    FROM HistoricoMedicamentos 
    WHERE PacienteID = @PacienteID 
    AND Medicamento = @Medicamento
    
    IF @JaRecebeu = 0
    BEGIN
        INSERT INTO HistoricoMedicamentos (PacienteID, Medicamento)
        VALUES (@PacienteID, @Medicamento)
        
        UPDATE Pacientes
        SET Medicado = 1
        WHERE ID = @PacienteID
        
        SELECT * FROM Pacientes WHERE ID = @PacienteID;
    END
    ELSE
    BEGIN
        SELECT * FROM HistoricoMedicamentos 
        WHERE PacienteID = @PacienteID 
        AND Medicamento = @Medicamento
    END
    
    COMMIT TRANSACTION;
END

INSERT INTO Pacientes (Nome) VALUES ('João Silva')
INSERT INTO Pacientes (Nome) VALUES ('Maria Oliveira')
INSERT INTO Pacientes (Nome) VALUES ('Maria')

EXEC sp_AdministrarMedicamento @PacienteID = 3, @Medicamento = 'Paracetamol'

SELECT * FROM HistoricoMedicamentos
SELECT * FROM Pacientes 

DROP DATABASE AC01EX2

--2. Controle de Administração de Medicamentos em um Hospital:
--Suponha que você tenha uma tabela Pacientes com os campos ID, Nome e Medicado.
--Crie um procedimento armazenado que aceite como entrada o ID do paciente e o nome do
--medicamento a ser administrado.
--Este procedimento deve verificar se o paciente já recebeu o medicamento
--especificado. Se ainda não tiver recebido, atualize o status na tabela Pacientes.
--Use uma transação para garantir que a administração do medicamento seja concluída com
--sucesso ou revertida em caso de erro.