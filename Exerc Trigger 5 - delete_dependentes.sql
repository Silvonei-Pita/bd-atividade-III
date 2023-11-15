CREATE DATABASE Atividade_Trigger;

USE Atividade_Trigger;

-- Exercicio Trigger 5: Crie uma trigger que exclua um dependente da tabela "tb_dependentes" de um funcionário 
-- sempre que um funcionário for deletado da tabela "tb_funcionarios".

-- ---------------------------------------------------------------------------------------------- --

-- INÍCIO DA EXECUÇÃO

-- Criar tabela Funcionários
CREATE TABLE Funcionarios (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
cargo VARCHAR(255) NOT NULL
);

CREATE TABLE Dependentes (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
vinculo VARCHAR(50) NOT NULL,
funcionario_id INT NOT NULL,
FOREIGN KEY(funcionario_id) REFERENCES Funcionarios(id)
);

-- Criar tabela virtual para visualizar os funcionários ativos e seus respectivos dependentes
CREATE VIEW vw_funcionarios_e_dependentes AS
SELECT F.nome AS Funcionário, F.cargo AS Cargo, D.nome AS Dependente, D.vinculo AS Vínculo
FROM Funcionarios F  
INNER JOIN Dependentes D ON D.funcionario_id = F.id;

-- Criar trigger que após o delete de uma linha na tabela Funcionario, exclua também a linha na tabela
-- Dependentes que faz referência a linha deletada.

DELIMITER //

CREATE TRIGGER tg_delete_dependentes
BEFORE DELETE ON
Funcionarios
FOR EACH ROW 
BEGIN
	-- Declarar variável que guardará a id do funcionário que será deletado
	DECLARE deleted_id int;
    SET deleted_id = OLD.id;
    -- Deletar dos dependentes aqueles que possuem a 
    -- chave estrangeira originada do Funcionário deletado
	DELETE FROM Dependentes WHERE Funcionario_id = deleted_id;
END //

DELIMITER ;

-- Inserir lista de Funcionários
INSERT INTO Funcionarios (id, nome, cargo)
VALUES
(1, 'Sérgio', 'Analista Contábil'),
(2, 'Andressa', 'Assistente de RH'),
(3, 'Marcos', 'Técnico de TI');

-- Inserir lista de Dependentes
INSERT INTO Dependentes (nome, vinculo, funcionario_id)
VALUES
('Samara Rita', 'Esposa', 3),
('André Bastos', 'Filho', 2),
('Melissa Uliver', 'Filha', 1);

-- Exibir tabela Funcionarios antes do trigger
SELECT * FROM Funcionarios;

-- Exibir a tabela Dependentes antes do trigger
SELECT * FROM Dependentes;

-- Exibir a VIEW de Funcionários e Dependentes antes do Trigger
SELECT * FROM vw_funcionarios_e_dependentes;

-- Teste: Realizar exclusão do Funcionário de id "2" para testar o trigger
DELETE FROM Funcionarios WHERE id = 2;

-- Exibir tabela Funcionarios depois do trigger 
SELECT * FROM Funcionarios;

-- Exibir a VIEW de Funcionários e Dependentes depois do Trigger
SELECT * FROM vw_funcionarios_e_dependentes;

-- FIM DA EXECUÇÃO

-- Opcional: Reiniciar tudo ---------------------------

-- Opcional: Eliminar o trigger
DROP TRIGGER tg_delete_dependentes;

-- Opcional: Excluir a tabela Dependentes
DROP TABLE Dependentes;

-- Opcional: Excluir a tabela Funcionarios;
DROP TABLE Funcionarios;

-- Opcional: Excluir a tabela virtual 
DROP VIEW vw_funcionarios_e_dependentes;

