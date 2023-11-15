CREATE DATABASE Atividade_View;

USE Atividade_View;

CREATE TABLE Vendedores (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE Clientes (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
pedido VARCHAR(255) NOT NULL,
id_vendedor INT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(id_vendedor) REFERENCES Vendedores(id)
);

INSERT INTO Vendedores (id, nome) VALUES
(1, 'Sérgio'),
(2, 'Letícia'),
(3, 'Márcio');

INSERT INTO Clientes (nome, pedido, id_vendedor) VALUES
('Merlin', 'Água com Gás x 3', 3),
('Luiz', 'Cebola Roxa x 5', 2),
('Samantha', 'Uva x 2', 1);

CREATE VIEW vw_relacionamento_cliente_vendedor AS
SELECT Clientes.nome AS Cliente, 
Clientes.pedido AS Pedido, 
Vendedores.nome AS Vendedor
FROM Clientes
INNER JOIN Vendedores ON Clientes.id_vendedor = Vendedores.id;

SELECT * FROM vw_relacionamento_cliente_vendedor;
