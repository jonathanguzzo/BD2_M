--================ CRIAÇÃO DAS TABELAS =================--
CREATE TABLE Marca(
	idMarca SERIAL PRIMARY KEY,
	marca VARCHAR(50)
);
SELECT * FROM Marca;


CREATE TABLE Tipo(
	idTipo SERIAL PRIMARY KEY,
	tipo VARCHAR(50)
);

SELECT * FROM Tipo;


CREATE TABLE NF(
	idNF SERIAL PRIMARY KEY,
	Numero INTEGER ,
	data DATE
);
SELECT * FROM NF;


CREATE TABLE ItemNF(
	idItemNF SERIAL PRIMARY KEY,
	custo REAL,
	quantidade INTEGER,
	idNF INTEGER,
	Constraint idNF Foreign Key (idNF) REFERENCES NF (idNF)
);
SELECT * FROM ItemNF;


CREATE TABLE Material(
	idMaterial SERIAL PRIMARY KEY,
	custo REAL,
	quantidade INTEGER,
	nome VARCHAR(50),
	idItemNF INTEGER,
	idMarca INTEGER,
	idTipo INTEGER,
	Constraint idItemNF Foreign Key (idItemNF) REFERENCES ItemNF (idItemNF),
	Constraint idMarca  Foreign Key (idMarca)  REFERENCES Marca  (idMarca),
	Constraint idTipo   Foreign Key (idTipo)   REFERENCES Tipo   (idTipo)
);
SELECT * FROM Material;


--====================== INSERÇÃO DE DADOS ======================--

INSERT INTO Marca(marca)
VALUES 
('Puma');
INSERT INTO Marca(marca)
VALUES
('Nike');
INSERT INTO Marca(marca)
VALUES
('Oakley');
SELECT * FROM Marca;


INSERT INTO Tipo(tipo)
VALUES
('tipo 1');
INSERT INTO Tipo(tipo)
VALUES
('tipo 2');
INSERT INTO Tipo(tipo)
VALUES
('tipo 3');
SELECT * FROM Tipo;


INSERT INTO NF(Numero,data)
VALUES
(1,'2014-08-01');
INSERT INTO NF(Numero,data)
VALUES
(2,'2013-01-22');
INSERT INTO NF(Numero,data)
VALUES
(3,'2012-10-11');
SELECT * FROM NF;


INSERT INTO ItemNF(custo,quantidade,idNF)
VALUES
(1500,1,1);
INSERT INTO ItemNF(custo,quantidade,idNF)
VALUES
(600,3,2);
INSERT INTO ItemNF(custo,quantidade,idNF)
VALUES
(300,5,3);
SELECT * FROM ItemNF;


INSERT INTO Material(custo,quantidade,nome,idItemNF,idMarca,idTipo)
VALUES
(200,4,'Boné JOHNJOHN',1,1,1);
INSERT INTO Material(custo,quantidade,nome,idItemNF,idMarca,idTipo)
VALUES
(500,2,'Bola Baskete',2,2,2);
INSERT INTO Material(custo,quantidade,nome,idItemNF,idMarca,idTipo)
VALUES
(700,3,'Bicicleta',3,3,3);
SELECT * FROM Material;



--=================== FUNÇÕES =====================--

-- QUESTÃO 1 --
CREATE OR REPLACE FUNCTION totalNota(INTEGER)
RETURNS REAL AS $$
DECLARE
	totalNF INTEGER;
BEGIN
	SELECT INTO totalNF SUM(custo*quantidade) FROM ItemNF WHERE idNF = 1;
	RETURN totalNF;
END
$$ LANGUAGE 'plpgsql';

SELECT totalNota(1) AS "Total NF";


-- QUESTÃO 2 --
CREATE OR REPLACE FUNCTION tot_item()
RETURNS SETOF Material AS $$
DECLARE
	totalDados VARCHAR;
BEGIN
	SELECT INTO totalDados (nome,custo,tipo,marca) 
	FROM Material,Tipo,Marca 
	WHERE Material.idItemNF = 1 and
		Material.idTipo = Tipo.idTipo and 
		Material.idMarca = Marca.idMarca; 
END
$$ LANGUAGE 'plpgsql';

SELECT tot_item(1) AS "Todos Dados Compra";



-- QUESTÃO 3 -- 
