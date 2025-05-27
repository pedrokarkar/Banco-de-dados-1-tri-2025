CREATE DATABASE SubConsultas

USE SubConsultas

CREATE TABLE clientes (
 id_cliente INT PRIMARY KEY,
 nome VARCHAR(100),
 cidade VARCHAR(100)
);

CREATE TABLE pedidos (
 id_pedido INT PRIMARY KEY,
 id_cliente INT,
 valor DECIMAL(10, 2),
 data_pedido DATE,
 FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO clientes (id_cliente, nome, cidade) VALUES
(1, 'João', 'São Paulo'),
(2, 'Maria', 'Rio de Janeiro'),
(3, 'Pedro', 'Salvador');
INSERT INTO pedidos (id_pedido, id_cliente, valor, data_pedido) VALUES
(1, 1, 100.00, '2025-05-01'),
(2, 2, 150.00, '2025-05-02'),
(3, 3, 200.00, '2025-05-03'),
(4, 1, 50.00, '2025-05-04');

--	Subconsulta com IN
SELECT nome FROM clientes
WHERE id_cliente IN (SELECT id_cliente FROM pedidos WHERE valor > 100);

-- Subconsulta com EXISTS
SELECT nome FROM clientes c 
	WHERE EXISTS (SELECT 1 FROM pedidos p WHERE p.id_cliente = c.id_cliente 
				  AND p.valor > 100);

-- Subconsulta como Coluna (no SELECT)
SELECT nome,(SELECT MAX(valor)FROM pedidos WHERE id_cliente = c.id_cliente) AS maior_pedido FROM clientes c;