

CREATE SEQUENCE clientes_seq;

CREATE TABLE clientes (
  cliente_id INT NOT NULL DEFAULT NEXTVAL ('clientes_seq'),
  codigo VARCHAR(15) NOT NULL,
  nome VARCHAR(50) DEFAULT NULL,
  email VARCHAR(50) DEFAULT NULL,
  endereco VARCHAR(255) DEFAULT NULL,
  cidade VARCHAR(50) DEFAULT NULL,
  estado VARCHAR(50) DEFAULT NULL,
  cep VARCHAR(15) DEFAULT NULL,
  telefone1 VARCHAR(15) DEFAULT NULL,
  telefone2 VARCHAR(15) DEFAULT NULL,
  ramal VARCHAR(8) DEFAULT NULL,
  PRIMARY KEY (cliente_id),
  CONSTRAINT cliente_id UNIQUE (cliente_id),
  CONSTRAINT codigo UNIQUE (codigo)
);
 
ALTER SEQUENCE clientes_seq RESTART WITH 1;


COMMENT ON COLUMN public.clientes.nome
    IS 'Nome completo dos clientes.';



CREATE SEQUENCE logins_seq;

CREATE TABLE logins (
  login_id int NOT NULL DEFAULT NEXTVAL ('logins_seq'),
  nome varchar(255) NOT NULL UNIQUE,
  password int NOT NULL,
  nome_compl VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (login_id),
  CONSTRAINT login_id UNIQUE (login_id)
);
 
ALTER SEQUENCE logins_seq RESTART WITH 1;

CREATE SEQUENCE modulos_seq;

CREATE TABLE modulos (
  modulo_id INT NOT NULL DEFAULT NEXTVAL ('modulos_seq'),
  nome VARCHAR(255) NOT NULL UNIQUE,
  servidor VARCHAR(40) DEFAULT NULL,
  pasta VARCHAR(500) DEFAULT NULL,
  arquivos TEXT DEFAULT NULL,
  config TEXT DEFAULT NULL,
  prerequisitos TEXT DEFAULT NULL,
  crontab TEXT DEFAULT NULL,
  psirc TEXT DEFAULT NULL,
  PRIMARY KEY (modulo_id, nome),
  CONSTRAINT modulo_id UNIQUE (modulo_id)
);

ALTER SEQUENCE modulos_seq RESTART WITH 1;

CREATE SEQUENCE cliente_vs_modulo_seq;

CREATE TABLE cliente_vs_modulo (
  relacao_id int NOT NULL DEFAULT NEXTVAL ('cliente_vs_modulo_seq'),
  cliente_id int NOT NULL,
  modulo_id int NOT NULL,
  PRIMARY KEY (relacao_id),
  CONSTRAINT FK_cliente_vs_modulo_clientes_cliente_id FOREIGN KEY (cliente_id)
  REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_cliente_vs_modulo_modulos_modulo_id FOREIGN KEY (modulo_id)
  REFERENCES modulos (modulo_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
 
ALTER SEQUENCE cliente_vs_modulo_seq RESTART WITH 1;

CREATE SEQUENCE config_cliente_seq;

CREATE TABLE config_cliente (
  config_id int NOT NULL DEFAULT NEXTVAL ('config_cliente_seq'),
  cliente_id int NOT NULL,
  descricao TEXT DEFAULT NULL,
  PRIMARY KEY (config_id),
  CONSTRAINT config_id UNIQUE (config_id),
  CONSTRAINT FK_cliente_vs_config_cliente_cliente_id FOREIGN KEY (cliente_id)
  REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
 
ALTER SEQUENCE config_cliente_seq RESTART WITH 1;

CREATE SEQUENCE campos_personalizados_seq;

CREATE TABLE campos_personalizados (
  campo_id INT NOT NULL DEFAULT NEXTVAL ('campos_personalizados_seq'),
  modulo_id INT NOT NULL,
  valor_campo TEXT DEFAULT NULL,
  nome_campo VARCHAR(100) NOT NULL,
  PRIMARY KEY (campo_id),
  CONSTRAINT campo_id UNIQUE (campo_id),
  CONSTRAINT FK_campos_personalizados_modul FOREIGN KEY (modulo_id)
    REFERENCES modulos(modulo_id) ON DELETE CASCADE ON UPDATE NO ACTION
);
 
ALTER SEQUENCE campos_personalizados_seq RESTART WITH 1;


CREATE SEQUENCE config_esp_clientes_seq;

CREATE TABLE config_esp_clientes (
  config_id INT NOT NULL DEFAULT NEXTVAL ('config_esp_clientes_seq'),
  cliente_id INT NOT NULL,
  modulo_id INT NOT NULL,
  config TEXT DEFAULT NULL,
  PRIMARY KEY (config_id),
  CONSTRAINT FK_config_esp_clientes_cliente FOREIGN KEY (cliente_id)
    REFERENCES clientes(cliente_id) ON DELETE NO ACTION ON UPDATE RESTRICT,
  CONSTRAINT FK_config_esp_clientes_modulo_ FOREIGN KEY (modulo_id)
    REFERENCES modulos(modulo_id) ON DELETE NO ACTION ON UPDATE RESTRICT
);
 
ALTER SEQUENCE config_esp_clientes_seq RESTART WITH 1;

CREATE SEQUENCE arquivos_seq;

CREATE TABLE arquivos (
  arquivo_id INTEGER NOT NULL DEFAULT NEXTVAL ('arquivos_seq') UNIQUE,
  modulo_id INTEGER NOT NULL,
  arquivo_nome VARCHAR(255) NOT NULL,
  arquivo_dados BYTEA DEFAULT NULL,
  PRIMARY KEY (arquivo_id),
  CONSTRAINT FK_arquivos_modulo_id FOREIGN KEY (modulo_id)
    REFERENCES modulos(modulo_id) ON DELETE CASCADE ON UPDATE RESTRICT
);

ALTER SEQUENCE arquivos_seq RESTART WITH 1;