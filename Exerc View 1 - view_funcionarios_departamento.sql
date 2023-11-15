CREATE DATABASE Atividade_View;

USE Atividade_View;

CREATE TABLE Funcionarios (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
departamento VARCHAR(100) NOT NULL,
PRIMARY KEY(id)
);

INSERT INTO Funcionarios (nome, departamento) VALUES
('Adriano', 'Administrativo'),
('Alana', 'Administrativo'),
('Ruan Hebert', 'Recursos Humanos');

CREATE VIEW vw_funcionarios_departamento AS
SELECT id, nome, departamento 
FROM Funcionarios
WHERE departamento = 'Administrativo';

SELECT * FROM vw_funcionarios_departamento;
