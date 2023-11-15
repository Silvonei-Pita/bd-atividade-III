CREATE DATABASE Atividade_View;

USE Atividade_View;

CREATE TABLE Estoque (
id INT AUTO_INCREMENT,
produto VARCHAR(255) NOT NULL,
quantidade INT NOT NULL,
PRIMARY KEY(id)
);

INSERT INTO Estoque (produto, quantidade) VALUES
('Maçã', 8),
('Pêra', 6),
('Mamão', 4),
('Limão', 2);


CREATE VIEW vw_estoque_insuficiente AS
SELECT id, produto, quantidade 
FROM Estoque
WHERE quantidade < 5;

SELECT * FROM vw_estoque_insuficiente;
