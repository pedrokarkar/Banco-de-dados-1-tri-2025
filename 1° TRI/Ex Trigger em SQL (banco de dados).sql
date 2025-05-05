CREATE DATABASE exrevisao

USE exrevisao

CREATE TABLE Produtos (
    IDProduto INT PRIMARY KEY IDENTITY(1,1),
    NomeProduto VARCHAR(100) NOT NULL,
    Estoque INT NOT NULL DEFAULT 0,
    Preco DECIMAL(10, 2) NOT NULL
)

CREATE TABLE Funcionarios (
    IDFuncionario INT PRIMARY KEY IDENTITY(1,1),
    NomeFuncionario VARCHAR(100) NOT NULL,
    Funcao VARCHAR(50),
    Departamento VARCHAR(50),
    CargaHoraria INT,
    DataContratacao DATE
)

CREATE TABLE HistoricoEstoque (
    IDHistorico INT PRIMARY KEY IDENTITY(1,1),
    IDProduto INT NOT NULL,
    DataAlteracao DATETIME NOT NULL DEFAULT GETDATE(),
    QuantidadeAnterior INT,
    QuantidadeNova INT,
    IDFuncionario INT,
    FOREIGN KEY (IDProduto) REFERENCES Produtos(IDProduto),
    FOREIGN KEY (IDFuncionario) REFERENCES Funcionarios(IDFuncionario)
)

CREATE TRIGGER tr_AtualizaHistoricoEstoque
ON Produtos
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Estoque)
    BEGIN
        DECLARE @IDFuncionario INT
        SELECT @IDFuncionario = IDFuncionario
        FROM Funcionarios
        WHERE NomeFuncionario = SUSER_SNAME()

        INSERT INTO HistoricoEstoque (IDProduto, DataAlteracao, QuantidadeAnterior, QuantidadeNova, IDFuncionario)
        SELECT
            i.IDProduto,
            GETDATE(),
            d.Estoque,
            i.Estoque,
            @IDFuncionario
        FROM
            inserted AS i
        INNER JOIN
            deleted AS d ON i.IDProduto = d.IDProduto
    END
END

INSERT INTO Produtos (NomeProduto, Estoque, Preco) VALUES ('Produto A', 10, 25.50)

INSERT INTO Funcionarios (NomeFuncionario, Funcao, Departamento, CargaHoraria, DataContratacao)
VALUES (SUSER_SNAME(), 'Gerente de Estoque', 'Logística', 40, GETDATE())

UPDATE Produtos SET Estoque = 20 WHERE NomeProduto = 'Produto A'

SELECT * FROM HistoricoEstoque

SELECT * FROM Funcionarios

DROP DATABASE exrevisao
