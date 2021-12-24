--Implementação SQL: Georgia Tech Library.
--Nome: Vitor Gabriel da Silva Ruffo

--definições:

CREATE SCHEMA lib;

CREATE SEQUENCE lib.catalogo_id_seq;

CREATE TABLE lib.catalogo_atual(
	identificador INT DEFAULT nextval('lib.catalogo_id_seq'),
	CONSTRAINT pk_catalogo_atual PRIMARY KEY(identificador)
);

CREATE TABLE lib.catalogo_interesse(
	identificador INT DEFAULT nextval('lib.catalogo_id_seq'),
	CONSTRAINT pk_catalogo_interesse PRIMARY KEY(identificador)
);


CREATE TABLE lib.livro(
	isbn INT,
	autor VARCHAR(50),
	titulo VARCHAR(50),
	area VARCHAR(30),
	catalogo_atual_id INT,
	copias_disp INT,
	copias_emp INT,
	descricao VARCHAR(100),
	pode_ser_emp BOOLEAN,
	catalogo_interesse_id INT,
	CONSTRAINT pk_livro PRIMARY KEY(isbn),
  	CONSTRAINT fk_livro_catalogo_atual FOREIGN KEY(catalogo_atual_id)
		REFERENCES lib.catalogo_atual(identificador),
	CONSTRAINT fk_livro_catalogo_interesse FOREIGN KEY(catalogo_interesse_id)
		REFERENCES lib.catalogo_interesse(identificador),
	CONSTRAINT ck_livro_catalogo_id CHECK ((catalogo_atual_id != NULL AND catalogo_interesse_id = NULL) OR
								          (catalogo_atual_id = NULL AND catalogo_interesse_id != NULL))
);

CREATE TABLE lib.pessoa(
	ssn INT,
	nome VARCHAR(100),
	cartao INT,
	CONSTRAINT pk_pessoa PRIMARY KEY(ssn)
);

CREATE TABLE lib.membro(
	pessoa_ssn INT,
	CONSTRAINT pk_membro PRIMARY KEY(pessoa_ssn),
	CONSTRAINT fk_membro FOREIGN KEY(pessoa_ssn)
		REFERENCES lib.pessoa(ssn) ON DELETE CASCADE
);

CREATE TABLE lib.func_bibliotecario(
	pessoa_ssn INT,
	CONSTRAINT pk_func_bibliotecario PRIMARY KEY(pessoa_ssn),
	CONSTRAINT fk_func_bibliotecario FOREIGN KEY(pessoa_ssn)
		REFERENCES lib.pessoa(ssn) ON DELETE CASCADE
);

CREATE TABLE lib.func_checkout(
	pessoa_ssn INT,
	CONSTRAINT pk_func_checkout PRIMARY KEY(pessoa_ssn),
	CONSTRAINT fk_func_checkout FOREIGN KEY(pessoa_ssn)
		REFERENCES lib.pessoa(ssn) ON DELETE CASCADE
);

CREATE TABLE lib.func_assist(
	pessoa_ssn INT,
	CONSTRAINT pk_func_assit PRIMARY KEY(pessoa_ssn),
	CONSTRAINT fk_func_assit FOREIGN KEY(pessoa_ssn)
		REFERENCES lib.pessoa(ssn) ON DELETE CASCADE
);

CREATE TABLE lib.professor(
	membro_ssn INT,
	CONSTRAINT pk_professor PRIMARY KEY(membro_ssn),
	CONSTRAINT fk_professor FOREIGN KEY(membro_ssn)
		REFERENCES lib.membro(pessoa_ssn) ON DELETE CASCADE
);

CREATE TABLE lib.bibli_chefe(
	bibli_ssn INT,
	CONSTRAINT pk_bibli_chefe PRIMARY KEY(bibli_ssn),
	CONSTRAINT fk_bibli_chefe FOREIGN KEY(bibli_ssn)
		REFERENCES lib.func_bibliotecario(pessoa_ssn) ON DELETE CASCADE
);

CREATE TABLE lib.bibli_depart(
	bibli_ssn INT,
	CONSTRAINT pk_bibli_depart PRIMARY KEY(bibli_ssn),
	CONSTRAINT fk_bibli_depart FOREIGN KEY(bibli_ssn)
		REFERENCES lib.func_bibliotecario(pessoa_ssn) ON DELETE CASCADE
);

CREATE TABLE lib.bibli_ref(
	bibli_ssn INT,
	CONSTRAINT pk_bibli_ref PRIMARY KEY(bibli_ssn),
	CONSTRAINT fk_bibli_ref FOREIGN KEY(bibli_ssn)
		REFERENCES lib.func_bibliotecario(pessoa_ssn) ON DELETE CASCADE
);

CREATE TABLE lib.pessoa_endereco(
	endereco VARCHAR(100),
	pessoa_ssn INT,
	CONSTRAINT pk_pessoa_endereco PRIMARY KEY(endereco, pessoa_ssn),
	CONSTRAINT fk_pessoa_endereco FOREIGN KEY(pessoa_ssn)
		REFERENCES lib.pessoa(ssn) ON DELETE CASCADE
);

CREATE TABLE lib.pessoa_tel(
	tel CHAR(11),
	pessoa_ssn INT,
	CONSTRAINT pk_pessoa_tel PRIMARY KEY(tel, pessoa_ssn),
	CONSTRAINT fk_pessoa_tel FOREIGN KEY(pessoa_ssn)
		REFERENCES lib.pessoa(ssn) ON DELETE CASCADE
);


CREATE TABLE lib.emprestimo(
	isbn INT,
	membro_ssn INT,
	bibli_ssn INT,
	data_emprestimo DATE DEFAULT current_date,
	data_devolucao DATE,
	CONSTRAINT pk_emprestimo PRIMARY KEY(isbn),
	CONSTRAINT fk_emprestimo_membro FOREIGN KEY(membro_ssn)
		REFERENCES lib.membro(pessoa_ssn),
	CONSTRAINT fk_emprestimo_bibli FOREIGN KEY(bibli_ssn)
		REFERENCES lib.func_bibliotecario(pessoa_ssn)
);

