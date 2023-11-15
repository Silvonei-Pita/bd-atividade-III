CREATE DATABASE Atividade_Trigger;

USE Atividade_Trigger;

CREATE TABLE Produtos (
id INT AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
data_validade DATE NOT NULL,
valor DECIMAL(8,2) NOT NULL,
PRIMARY KEY(id)
);

DELIMITER // 

CREATE TRIGGER tg_validar_vencimento_produto
BEFORE INSERT ON Produtos
FOR EACH ROW
BEGIN
    IF NEW.data_validade < '2023-11-08' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de validade inválida, já está vencida. Produto não cadastrado.';
    END IF;
END //

DELIMITER ;

-- Inserção que dará erro
INSERT INTO Produtos(nome, data_validade, valor) 
VALUES
('Maionese 500ml', '2022-11-07', 30.99);

-- Inserção que funcionará --
INSERT INTO Produtos(nome, data_validade, valor) 
VALUES
('Ketchup 300ml', '2023-11-10', 15.49);

SELECT * FROM Produtos;

-- Reiniciar a tabela usando delete
DELETE FROM Produtos WHERE id > 0;