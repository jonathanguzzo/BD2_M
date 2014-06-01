CREATE TABLE Produtos(
	idProduto  serial PRIMARY KEY,
	Descricao VARCHAR(100),
	QtdEstoque INTEGER,
	Valor DECIMAL(10,2)
);
select * from produtos;

CREATE TABLE numNf(
	idNf TEXT PRIMARY KEY,
	data DATE,
	NumNf INTEGER
);
select * from numnf;

CREATE TABLE ItensNF(
	idItemNf serial PRIMARY KEY,
	Qtd INTEGER,
	Valor DECIMAL(10,2),
	idProduto INTEGER,
	idNf TEXT,
	Constraint idProduto FOREIGN KEY (idProduto) REFERENCES Produtos (idProduto),
	Constraint idNf      FOREIGN KEY (idNf)	     REFERENCES numNf     (idNf)
);
select * from itensnf;


-- INSERÇÃO DE DADOS --

--Produtos--
INSERT INTO Produtos
VALUES
(1,'Descrição 1',100,10.50);
INSERT INTO Produtos
VALUES
(2,'Descrição 2',50 ,20);
INSERT INTO Produtos
VALUES
(3,'Descriçaõ 3',30 ,5.00 );
INSERT INTO Produtos
VALUES
(4,'Descriçaõ 4',10 ,30.00);

SELECT * FROM PRODUTOS;

--numNf--
INSERT INTO numNf
VALUES
(1,'2014-01-10',1);
INSERT INTO numNf
VALUES
(2,'2014-02-10',2);
INSERT INTO numNf
VALUES
(3,'2014-03-10',3);
INSERT INTO numNf
VALUES
(4,'2014-04-10',4);

SELECT * FROM NUMNF;

--ItensNF--
INSERT INTO ItensNF
VALUES(1,2,60.00,4,1);
INSERT INTO ItensNF
VALUES(2,1,10.50,1,2);
INSERT INTO ItensNF
VALUES(3,3,15.00,3,3);

SELECT * FROM ITENSNF;


-------------------------------------------------------------------------------------------

-- TRIGGERS -- 


1--
CREATE OR REPLACE FUNCTION att_estoque()
RETURNS TRIGGER AS
$$
BEGIN 
	UPDATE PRODUTOS
        SET QtdEstoque = QtdEstoque - NEW.Qtd
        WHERE idProduto = NEW.idProduto;
END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER att_estoque
AFTER INSERT ON ItensNF
FOR EACH ROW EXECUTE PROCEDURE att_estoque();


---------------------------------------------------------------------------------------------

2--
CREATE OR REPLACE FUNCTION delete_on_estoque()
RETURNS TRIGGER AS 
$$
BEGIN
	UPDATE PRODUTOS
	SET QtdEstoque = QtdEstoque + NEW.Qtd
	WHERE idProduto = NEW.idProduto;
END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER delete_on_estoque
AFTER DELETE ON itensNF
FOR EACH ROW EXECUTE PROCEDURE delete_on_estoque();


------------------------------------------------------------------------------------------------

3--
CREATE OR REPLACE FUNCTION update_on_estoque()
RETURNS TRIGGER AS 
$$
BEGIN
	UPDATE PRODUTOS
	SET QtdEstoque = QtdEstoque + OLD.Qtd - NEW.Qtd
	WHERE idProduto = NEW.idProduto;
END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER update_on_estoque
AFTER UPDATE ON itensNF
FOR EACH ROW EXECUTE PROCEDURE update_on_estoque();