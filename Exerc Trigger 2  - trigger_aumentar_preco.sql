CREATE DATABASE Atividade_Trigger;

USE Atividade_Trigger;

-- Exercicio Trigger 2: Crie um trigger para aumentar o preço de um produto sempre que ele for atualizado. 
-- O aumento deve ser de 10%.

-- ---------------------------------------------------------------------------------------------- --

-- Criar tabela Produtos
CREATE TABLE Produtos (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
data_validade DATE NOT NULL,
valor DECIMAL(8,2) NOT NULL,
PRIMARY KEY(id)
);

-- Criar trigger que aumenta o preço de um produto sempre que o produto receber alguma atualização.

DELIMITER //

CREATE TRIGGER tg_aumentar_preco
BEFORE UPDATE ON
Produtos
FOR EACH ROW
BEGIN
	SET NEW.valor = NEW.valor + NEW.valor * (10/100);
END //

DELIMITER ;

-- Inserir um produto
INSERT INTO Produtos(nome, data_validade, valor) 
VALUES
('Ketchup 300ml', '2024-11-10', 15.49),
('Ketchup 500ml', '2022-12-13', 20.00);

-- Exibir tabela Produtos antes do trigger
SELECT * FROM Produtos;

-- Teste: atualizar produto de id "1" para verificar se o trigger funciona
UPDATE Produtos
SET nome = 'Maionese 400 ml'
WHERE id = 1;

-- Exibir tabela Produtos depois do trigger 
SELECT * FROM Produtos;

-- Opcional: Reiniciar a tabela usando delete
DELETE FROM Produtos WHERE id > 0;

-- Opcional: Eliminar o trigger
DROP TRIGGER tg_aumentar_preco;

-- Opcional: Excluir a tabela Produtos;
DROP TABLE Produtos;

