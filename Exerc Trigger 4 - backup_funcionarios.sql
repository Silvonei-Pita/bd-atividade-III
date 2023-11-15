CREATE DATABASE Atividade_Trigger;

USE Atividade_Trigger;

-- Exercicio Trigger 4: Crie um trigger que seja acionado após a exclusão de um registro em uma tabela "tb_funcionarios" 
-- e insira os dados excluídos em outra tabela "tb_funcionarios_demitidos" de registro de exclusões.

-- ---------------------------------------------------------------------------------------------- --

-- INÍCIO DA EXECUÇÃO

-- Criar tabela Funcionários
CREATE TABLE Funcionarios (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
cargo VARCHAR(255) NOT NULL
);

CREATE TABLE Funcionarios_Demitidos (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
cargo VARCHAR(255) NOT NULL,
data_demissao DATE NOT NULL
);

-- Criar trigger que após o delete de uma linha na tabela Funcionario, insere os dados dessa
-- linha deletada na tabela Funcionarios_Demitidos

DELIMITER //

CREATE TRIGGER tg_backup_funcionarios
AFTER DELETE ON
Funcionarios
FOR EACH ROW
BEGIN
	INSERT INTO Funcionarios_Demitidos (nome, cargo, data_demissao) VALUES
    (OLD.nome, OLD.cargo, CURDATE());
END //

DELIMITER ;

-- Inserir Funcionários
INSERT INTO Funcionarios (nome, cargo)
VALUES
('Sérgio', 'Analista Contábil'),
('Andressa', 'Assistente de RH'),
('Marcos', 'Técnico de TI');

-- Exibir tabela Funcionarios antes do trigger
SELECT * FROM Funcionarios;

-- Exibir tabela Funcionarios_Demitidos antes do trigger
SELECT * FROM Funcionarios_Demitidos;

-- Teste: Realizar exclusão do Funcionário de id "3" para testar o trigger
DELETE FROM Funcionarios WHERE id = 3;

-- Exibir tabela Funcionarios depois do trigger 
SELECT * FROM Funcionarios;

-- Exibir tabela Funcionarios_Demitidos depois do trigger
SELECT * FROM Funcionarios_Demitidos;

-- FIM DA EXECUÇÃO

-- Opcional: Reiniciar a tabela usando delete
DELETE FROM Funcionarios WHERE id > 0;

-- Opcional: Eliminar o trigger
DROP TRIGGER tg_backup_funcionarios;

-- Opcional: Excluir a tabela Funcionarios;
DROP TABLE Funcionarios;

-- Opcional: Excluir a tabela Funcionarios_Demitidos;
DROP TABLE Funcionarios_Demitidos;

