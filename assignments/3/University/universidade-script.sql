--Implementação SQL: Universidade.
--Nome: Vitor Gabriel da Silva Ruffo

--definições:

CREATE SCHEMA uni;

CREATE TABLE uni.centro(
	sigla VARCHAR(8),
	nome VARCHAR(30) NOT NULL,
	CONSTRAINT pk_centro PRIMARY KEY(sigla),
	CONSTRAINT uk_centro_nome UNIQUE(nome)
);

CREATE TABLE uni.departamento(
	sigla VARCHAR(8),
	nome VARCHAR(30) NOT NULL,
	centro_sigla VARCHAR(8) NOT NULL,
	CONSTRAINT pk_depart PRIMARY KEY(sigla),
	CONSTRAINT uk_depart_nome UNIQUE(nome),
	CONSTRAINT fk_depart FOREIGN KEY(centro_sigla)
		REFERENCES uni.centro(sigla) ON DELETE CASCADE
);

CREATE TABLE uni.pessoa(
	cpf CHAR(11),
	pnome VARCHAR(15) NOT NULL,
	snome VARCHAR(30) NOT NULL,
	dt_nasc DATE NOT NULL,
	sexo CHAR,
	end_rua VARCHAR(30),
	end_bairro VARCHAR(15),
	end_cidade VARCHAR(15) NOT NULL,
	end_estado CHAR(2) NOT NULL,
	CONSTRAINT pk_pessoa PRIMARY KEY(cpf),
	CONSTRAINT ck_pessoa_sexo CHECK (sexo in ('f', 'm'))
);

CREATE TABLE uni.professor(
	pessoa_cpf CHAR(11),
	categoria VARCHAR(15),
	sal NUMERIC(7,2),
	depart_sigla VARCHAR(8) NOT NULL,
	CONSTRAINT pk_professor PRIMARY KEY(pessoa_cpf),
	CONSTRAINT fk_professor_cpf FOREIGN KEY(pessoa_cpf)
		REFERENCES uni.pessoa(cpf) ON DELETE CASCADE,
	CONSTRAINT fk_professor_depart_sigla FOREIGN KEY(depart_sigla)
		REFERENCES uni.departamento(sigla) ON DELETE CASCADE
);

CREATE TABLE uni.aluno_grad(
	pessoa_cpf CHAR(11),
	CONSTRAINT pk_aluno_grad PRIMARY KEY(pessoa_cpf),
	CONSTRAINT fk_aluno_grad FOREIGN KEY(pessoa_cpf)
		REFERENCES uni.pessoa(cpf) ON DELETE CASCADE
);

CREATE TABLE uni.aluno_pos(
	pessoa_cpf CHAR(11),
	CONSTRAINT pk_aluno_pos PRIMARY KEY(pessoa_cpf),
	CONSTRAINT fk_aluno_pos FOREIGN KEY(pessoa_cpf)
		REFERENCES uni.pessoa(cpf) ON DELETE CASCADE
);

CREATE SEQUENCE uni.prof_grad_id_seq;
CREATE TABLE uni.prof_grad(
	identificador INT DEFAULT nextval('uni.prof_grad_id_seq'),
	prof_cpf CHAR(11),
	aluno_pos_cpf CHAR(11),
	CONSTRAINT pk_prof_grad PRIMARY KEY(identificador),
	CONSTRAINT fk_prof_grad_prof_cpf FOREIGN KEY(prof_cpf)
		REFERENCES uni.professor(pessoa_cpf) ON DELETE CASCADE,
	CONSTRAINT fk_prof_grad_aluno_pos_cpf FOREIGN KEY(aluno_pos_cpf)
		REFERENCES uni.aluno_pos(pessoa_cpf) ON DELETE CASCADE,
	CONSTRAINT ck_prof_grad_cpf CHECK ((prof_cpf != NULL AND aluno_pos_cpf = NULL) OR
								       (prof_cpf = NULL AND aluno_pos_cpf != NULL)),
	CONSTRAINT uk_prof_grad_prof_cpf UNIQUE(prof_cpf),
	CONSTRAINT uk_prof_grad_aluno_pos_cpf UNIQUE(aluno_pos_cpf)
);

CREATE SEQUENCE uni.bolsista_id_seq;
CREATE TABLE uni.bolsista(
	identificador INT DEFAULT nextval('uni.bolsista_id_seq'),
	prof_cpf CHAR(11),
	aluno_pos_cpf CHAR(11),
	CONSTRAINT pk_bolsista PRIMARY KEY(identificador),
	CONSTRAINT fk_bolsista_prof_cpf FOREIGN KEY(prof_cpf)
		REFERENCES uni.professor(pessoa_cpf) ON DELETE CASCADE,
	CONSTRAINT fk_bolsista_aluno_pos_cpf FOREIGN KEY(aluno_pos_cpf)
		REFERENCES uni.aluno_pos(pessoa_cpf) ON DELETE CASCADE,
	CONSTRAINT ck_bolsista_cpf CHECK ((prof_cpf != NULL AND aluno_pos_cpf = NULL) OR
								      (prof_cpf = NULL AND aluno_pos_cpf != NULL)),
	CONSTRAINT uk_bolsista_prof_cpf UNIQUE(prof_cpf),
	CONSTRAINT uk_bolsista_aluno_pos_cpf UNIQUE(aluno_pos_cpf)
);

CREATE TABLE uni.agencia(
	sigla VARCHAR(8),
	nome VARCHAR(30) NOT NULL,
	CONSTRAINT pk_agencia PRIMARY KEY(sigla),
	CONSTRAINT uk_agencia_nome UNIQUE(nome)
);

CREATE TABLE uni.bolsa(
	n_processo INT,
	agencia_sigla VARCHAR(8),
	CONSTRAINT pk_bolsa PRIMARY KEY(n_processo, agencia_sigla),
	CONSTRAINT fk_bolsa FOREIGN KEY(agencia_sigla)
		REFERENCES uni.agencia(sigla) ON DELETE CASCADE
);


CREATE TABLE uni.chefia(
	inicio DATE,
	fim DATE,
	depart_sigla VARCHAR(8),
	prof_chefe_cpf CHAR(11) NOT NULL,
	CONSTRAINT pk_chefia PRIMARY KEY(inicio, fim, depart_sigla),
	CONSTRAINT fk_chefia_depart FOREIGN KEY(depart_sigla)
		REFERENCES uni.departamento(sigla),
	CONSTRAINT fk_chefia_prof_chefe_cpf FOREIGN KEY(prof_chefe_cpf)
		REFERENCES uni.professor(pessoa_cpf)
);

CREATE TABLE uni.curso(
	cod VARCHAR(15),
	nome VARCHAR(30) NOT NULL,
	CONSTRAINT pk_curso PRIMARY KEY(cod),
	CONSTRAINT uk_curso_nome UNIQUE(nome)
);

CREATE TABLE uni.curso_grad(
	curso_cod VARCHAR(15),
	CONSTRAINT pk_curso_grad PRIMARY KEY(curso_cod),
	CONSTRAINT fk_curso_grad FOREIGN KEY(curso_cod)
		REFERENCES uni.curso(cod) ON DELETE CASCADE
);

CREATE TABLE uni.curso_pos(
	curso_cod VARCHAR(15),
	CONSTRAINT pk_curso_pos PRIMARY KEY(curso_cod),
	CONSTRAINT fk_curso_pos FOREIGN KEY(curso_cod)
		REFERENCES uni.curso(cod) ON DELETE CASCADE
);

CREATE TABLE uni.disc_grad(
	cod VARCHAR(15),
	nome VARCHAR(30),
	ementa VARCHAR(500),
	CONSTRAINT pk_disc_grad PRIMARY KEY(cod)
);

CREATE TABLE uni.disc_pos(
	cod VARCHAR(15),
	nome VARCHAR(30),
	ementa VARCHAR(500),
	CONSTRAINT pk_disc_pos PRIMARY KEY(cod)
);

CREATE TABLE uni.curso_grad_disciplina(
	curso_grad_cod VARCHAR(15),
	disc_grad_cod VARCHAR(15),
	CONSTRAINT pk_curso_grad_disciplina PRIMARY KEY(curso_grad_cod, disc_grad_cod),
	CONSTRAINT fk_curso_grad_disciplina_curso_cod FOREIGN KEY(curso_grad_cod)
		REFERENCES uni.curso_grad(curso_cod) ON DELETE CASCADE,
	CONSTRAINT fk_curso_grad_disciplina_disc_cod FOREIGN KEY(disc_grad_cod)
		REFERENCES uni.disc_grad(cod) ON DELETE CASCADE
);

CREATE TABLE uni.curso_pos_disciplina(
	curso_pos_cod VARCHAR(15),
	disc_pos_cod VARCHAR(15),
	CONSTRAINT pk_curso_pos_disciplina PRIMARY KEY(curso_pos_cod, disc_pos_cod),
	CONSTRAINT fk_curso_pos_disciplina_curso_cod FOREIGN KEY(curso_pos_cod)
		REFERENCES uni.curso_pos(curso_cod) ON DELETE CASCADE,
	CONSTRAINT fk_curso_pos_disciplina_disc_cod FOREIGN KEY(disc_pos_cod)
		REFERENCES uni.disc_pos(cod) ON DELETE CASCADE
);

CREATE TABLE uni.oferta_pos(
	ano INT,
	semestre INT,
	curso_pos_cod VARCHAR(15),
	disc_pos_cod VARCHAR(15),
	prof_cpf CHAR(11) NOT NULL,
	CONSTRAINT pk_oferta_pos PRIMARY KEY(ano, semestre, curso_pos_cod, disc_pos_cod),
	CONSTRAINT fk_oferta_pos_curso_disc FOREIGN KEY(curso_pos_cod, disc_pos_cod)
		REFERENCES uni.curso_pos_disciplina(curso_pos_cod, disc_pos_cod),
	CONSTRAINT fk_oferta_pos_prof_cpf FOREIGN KEY(prof_cpf)
		REFERENCES uni.professor(pessoa_cpf),
	CONSTRAINT ck_oferta_pos_semestre CHECK(semestre in (1, 2))
);

CREATE SEQUENCE uni.avaliacao_pos_num_seq;
CREATE TABLE uni.avaliacao_pos(
	num INT DEFAULT nextval('uni.avaliacao_pos_num_seq'),
	data DATE,
	descri VARCHAR(100),
	reg_ou_exame CHAR,
	ano INT,
	semestre INT,
	curso_pos_cod VARCHAR(15),
	disc_pos_cod VARCHAR(15),
	CONSTRAINT pk_avaliacao_pos PRIMARY KEY(num, ano, semestre, curso_pos_cod, disc_pos_cod),
	CONSTRAINT fk_avaliacao_pos FOREIGN KEY(ano, semestre, curso_pos_cod, disc_pos_cod)
		REFERENCES uni.oferta_pos(ano, semestre, curso_pos_cod, disc_pos_cod),
	CONSTRAINT ck_avaliacao_pos_semestre CHECK(semestre in (1, 2))
);

CREATE TABLE uni.oferta_grad(
	ano INT,
	semestre INT,
	curso_grad_cod VARCHAR(15),
	disc_grad_cod VARCHAR(15),
	prof_grad_id INT NOT NULL,
	CONSTRAINT pk_oferta_grad PRIMARY KEY(ano, semestre, curso_grad_cod, disc_grad_cod),
	CONSTRAINT fk_oferta_grad_curso_disc FOREIGN KEY(curso_grad_cod, disc_grad_cod)
		REFERENCES uni.curso_grad_disciplina(curso_grad_cod, disc_grad_cod),
	CONSTRAINT fk_oferta_grad_prof_grad_id FOREIGN KEY(prof_grad_id)
		REFERENCES uni.prof_grad(identificador),
	CONSTRAINT ck_oferta_grad_semestre CHECK(semestre in (1, 2))
);

CREATE TABLE uni.orientacao(
	prof_cpf CHAR(11),
	curso_pos_cod VARCHAR(15),
	al_pos_cpf CHAR(11),
	CONSTRAINT pk_orientacao PRIMARY KEY(curso_pos_cod, al_pos_cpf),
	CONSTRAINT fk_orientacao_prof FOREIGN KEY(prof_cpf)
		REFERENCES uni.professor(pessoa_cpf),
	CONSTRAINT fk_orientacao_curso_pos FOREIGN KEY(curso_pos_cod)
		REFERENCES uni.curso_pos(curso_cod),
	CONSTRAINT fk_orientacao_al_pos FOREIGN KEY(al_pos_cpf)
		REFERENCES uni.aluno_pos(pessoa_cpf)
);

CREATE TABLE uni.banca(
	prof_cpf CHAR(11),
	curso_pos_cod VARCHAR(15),
	al_pos_cpf CHAR(11),
	CONSTRAINT pk_banca PRIMARY KEY(prof_cpf, curso_pos_cod, al_pos_cpf),
	CONSTRAINT fk_banca_prof FOREIGN KEY(prof_cpf)
		REFERENCES uni.professor(pessoa_cpf),
	CONSTRAINT fk_banca_curso_pos FOREIGN KEY(curso_pos_cod)
		REFERENCES uni.curso_pos(curso_cod),
	CONSTRAINT fk_banca_al_pos FOREIGN KEY(al_pos_cpf)
		REFERENCES uni.aluno_pos(pessoa_cpf)
);

CREATE TABLE uni.oferecimento(
	depart_sigla VARCHAR(8),
	curso_cod VARCHAR(15),
	CONSTRAINT pk_oferecimento PRIMARY KEY(depart_sigla, curso_cod),
	CONSTRAINT fk_oferecimento_depart FOREIGN KEY(depart_sigla)
		REFERENCES uni.departamento(sigla),
	CONSTRAINT fk_oferecimento_curso FOREIGN KEY(curso_cod)
		REFERENCES uni.curso(cod)
);

CREATE TABLE uni.fazer_avaliacao_pos(
	num INT,
	ano INT,
	semestre INT,
	curso_pos_cod VARCHAR(15),
	disc_pos_cod VARCHAR(15),
	aluno_pos_cpf CHAR(11),
	nota NUMERIC(3,1),
	CONSTRAINT pk_fazer_avaliacao_pos 
	PRIMARY KEY(num, ano, semestre, curso_pos_cod, disc_pos_cod, aluno_pos_cpf),
	CONSTRAINT fk_fazer_avaliacao_pos FOREIGN KEY(num, ano, semestre, curso_pos_cod, disc_pos_cod)
		REFERENCES uni.avaliacao_pos(num, ano, semestre, curso_pos_cod, disc_pos_cod),
	CONSTRAINT fk_fazer_avaliacao_pos_aluno FOREIGN KEY(aluno_pos_cpf)
		REFERENCES uni.aluno_pos(pessoa_cpf),
	CONSTRAINT ck_fazer_avaliacao_pos_semestre CHECK(semestre in (1, 2))
);

CREATE TABLE uni.cursar_oferta_pos(
	ano INT,
	semestre INT,
	curso_pos_cod VARCHAR(15),
	disc_pos_cod VARCHAR(15),
	aluno_pos_cpf CHAR(11),
	media_final NUMERIC(3,1),
	status CHAR,
	CONSTRAINT pk_cursar_oferta_pos 
	PRIMARY KEY(ano, semestre, curso_pos_cod, disc_pos_cod, aluno_pos_cpf),
	CONSTRAINT fk_cursar_oferta_pos FOREIGN KEY(ano, semestre, curso_pos_cod, disc_pos_cod)
		REFERENCES uni.oferta_pos(ano, semestre, curso_pos_cod, disc_pos_cod),
	CONSTRAINT fk_cursar_oferta_pos_aluno FOREIGN KEY(aluno_pos_cpf)
		REFERENCES uni.aluno_pos(pessoa_cpf),
	CONSTRAINT ck_cursar_oferta_pos_semestre CHECK(semestre in (1, 2)),
	CONSTRAINT ck_cursar_oferta_pos_status CHECK (status in ('A', 'R')) --A: aprovado, R: reprovado
);

CREATE TABLE uni.atribuicao_bolsa(
	n_processo INT,
	agencia_sigla VARCHAR(8),
	bolsista_id INT,
	CONSTRAINT pk_atribuicao_bolsa PRIMARY KEY(n_processo, agencia_sigla, bolsista_id),
	CONSTRAINT fk_atribuicao_bolsa FOREIGN KEY(n_processo, agencia_sigla)
		REFERENCES uni.bolsa(n_processo, agencia_sigla),
	CONSTRAINT fk_atribuicao_bolsa_bolsista FOREIGN KEY(bolsista_id)
		REFERENCES uni.bolsista(identificador)
);
