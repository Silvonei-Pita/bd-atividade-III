CREATE DATABASE Atividade_Trigger;

USE Atividade_Trigger;

-- Exercicio Trigger 3: Crie um trigger para atualizar o estoque sempre que um produto for vendido.
-- O trigger deve diminuir o número de itens em estoque sempre que uma venda for realizada.

-- ---------------------------------------------------------------------------------------------- --

-- Criar tabela Estoque
CREATE TABLE Estoque (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
preco DECIMAL(8,2) NOT NULL,
qtd_atual INT NOT NULL,
qtd_vendida INT NOT NULL,
PRIMARY KEY(id)
);

-- Criar trigger que atualiza o estoque sempre que uma venda for realizada

DELIMITER //

CREATE TRIGGER tg_atualizar_estoque
BEFORE UPDATE ON
Estoque
FOR EACH ROW
BEGIN
	SET NEW.qtd_atual = OLD.qtd_atual - (NEW.qtd_vendida - OLD.qtd_vendida);
END //

DELIMITER ;

-- Inserir um item no Estoque
INSERT INTO Estoque (nome, qtd_atual, qtd_vendida, preco)
VALUES
('Garrafa 700ml', 100, 0, 10.00);

-- Exibir tabela Estoque antes do trigger
SELECT * FROM Estoque;

-- Teste: Realizar venda do item de id "1" para verificar se o trigger funciona
UPDATE Estoque
SET qtd_vendida = qtd_vendida + 1
WHERE id = 1;

-- Exibir tabela Estoque depois do trigger 
SELECT * FROM Estoque;

-- Opcional: Reiniciar a tabela usando delete
DELETE FROM Estoque WHERE id > 0;

-- Opcional: Eliminar o trigger
DROP TRIGGER tg_atualizar_estoque;

-- Opcional: Excluir a tabela Estoque;
DROP TABLE Estoque;

