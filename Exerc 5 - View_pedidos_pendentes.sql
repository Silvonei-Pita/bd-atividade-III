CREATE DATABASE Atividade_View;

USE Atividade_View;

CREATE TABLE Compradores (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE Pedidos (
id INT AUTO_INCREMENT,
produto VARCHAR(255) NOT NULL,
quantidade INT NOT NULL,
valor DECIMAL(8,2) NOT NULL,
situacao VARCHAR(100) NOT NULL,
id_comprador INT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(id_comprador) REFERENCES Compradores(id)
);

INSERT INTO Compradores (id, nome) VALUES
(1, 'Maurício'),
(2, 'Bruna'),
(3, 'Alana');

INSERT INTO Pedidos (produto, quantidade, valor, situacao, id_comprador) VALUES
('Água com gás', 2, 10, 'Pendente', 3),
('Marca-texto Amarelo', 10, 50, 'Pendente', 1),
('Bolo de Banana', 1, 15.50, 'Finalizado', 2);

CREATE VIEW vw_pedidos_pendentes AS
SELECT Compradores.nome AS Comprador, 
Pedidos.produto AS Produto,
Pedidos.quantidade AS Quantidade,
Pedidos.valor AS Valor_Total,
Pedidos.situacao AS Situação
FROM Compradores
INNER JOIN Pedidos ON Pedidos.id_comprador = Compradores.id
WHERE Pedidos.situacao = 'Pendente';

SELECT * FROM vw_pedidos_pendentes;
