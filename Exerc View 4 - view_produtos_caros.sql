CREATE DATABASE Atividade_View;

USE Atividade_View;

CREATE TABLE Produtos (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
preco DECIMAL(8,2) NOT NULL,
PRIMARY KEY(id)
);

INSERT INTO Produtos (nome, preco) VALUES
('Esponja de banho', 30),
('Régua 30cm', 15.50),
('Helicóptero Apache de Brinquedo', 200),
('Teclado Mecânico X-Ryzen', 300);

CREATE VIEW vw_produtos_caros AS
SELECT nome AS produto, preco AS preço
FROM Produtos
WHERE preco >= 100;

SELECT * FROM vw_produtos_caros;
