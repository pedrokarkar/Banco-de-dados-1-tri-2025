create database AC01EX1

use AC01EX1

CREATE TABLE Alunos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Matriculado INT DEFAULT 0
)
 
CREATE TABLE Matriculas (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_Aluno INT,
    Ano_Letivo INT,
    Data_Matricula DATE,
    FOREIGN KEY (ID_Aluno) REFERENCES Alunos(ID)
)
 
INSERT INTO Alunos (ID, Nome, Matriculado) VALUES 
(1, 'João Silva', 0),
(2, 'Maria Santos', 0),
(3, 'Pedro Oliveira', 0)
 
CREATE PROCEDURE MatricularAluno
    @aluno_id INT,
    @ano_letivo INT
AS
BEGIN
    DECLARE @aluno_ja_matriculado INT
    BEGIN TRANSACTION
    SELECT @aluno_ja_matriculado = COUNT(*) 
    FROM Matriculas 
    WHERE ID_Aluno = @aluno_id AND Ano_Letivo = @ano_letivo
    IF @aluno_ja_matriculado = 0
    BEGIN
        UPDATE Alunos SET Matriculado = 1 WHERE ID = @aluno_id
        INSERT INTO Matriculas (ID_Aluno, Ano_Letivo, Data_Matricula)
        VALUES (@aluno_id, @ano_letivo, GETDATE())
        COMMIT TRANSACTION;
        SELECT 'Matrícula realizada com sucesso' AS Resultado
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        SELECT 'Aluno já está matriculado para este ano letivo' AS Resultado;
    END
END
 
 
 
EXEC MatricularAluno @aluno_id = 1, @ano_letivo = 2025
 
SELECT * FROM Alunos

DROP DATABASE AC01EX1

--1. Controle de Matrículas Escolares:
--Suponha que você tenha uma tabela Alunos com os camposID, Nome e Matriculado.
--Crie um procedimento armazenado que aceite como entrada o ID do aluno e o ano letivo da
--matrícula. Este procedimento deve verificar se o aluno já está matriculado para o ano
--especificado.
--Se não estiver matriculado, atualize o status na tabela Alunos.
--Use uma transação para garantir que a matrícula seja concluída com sucesso ou revertida em
--caso de erro.