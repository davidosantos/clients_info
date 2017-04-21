CREATE DATABASE clients_info
CHARACTER SET utf8
COLLATE utf8_general_ci;

USE clients_info;

CREATE TABLE clientes (
  cliente_id INT(11) NOT NULL AUTO_INCREMENT,
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
  UNIQUE INDEX cliente_id (cliente_id),
  UNIQUE INDEX codigo (codigo)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;



ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE logins (
  login_id INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL UNIQUE,
  password INT(11) NOT NULL,
  nome_compl VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (login_id),
  UNIQUE INDEX login_id (login_id)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE clients_info.modulos (
  modulo_id INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL UNIQUE,
  servidor VARCHAR(40) DEFAULT NULL,
  pasta VARCHAR(500) DEFAULT NULL,
  arquivos TEXT DEFAULT NULL,
  config TEXT DEFAULT NULL,
  prerequisitos TEXT DEFAULT NULL,
  crontab TEXT DEFAULT NULL,
  psirc TEXT DEFAULT NULL,
  PRIMARY KEY (modulo_id, nome),
  UNIQUE INDEX modulo_id (modulo_id)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE cliente_vs_modulo (
  relacao_id int(11) NOT NULL AUTO_INCREMENT,
  cliente_id int(11) NOT NULL,
  modulo_id int(11) NOT NULL,
  PRIMARY KEY (relacao_id),
  CONSTRAINT FK_cliente_vs_modulo_clientes_cliente_id FOREIGN KEY (cliente_id)
  REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_cliente_vs_modulo_modulos_modulo_id FOREIGN KEY (modulo_id)
  REFERENCES modulos (modulo_id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE config_cliente (
  config_id int(11) NOT NULL AUTO_INCREMENT,
  cliente_id int(11) NOT NULL,
  descricao TEXT DEFAULT NULL,
  PRIMARY KEY (config_id),
  UNIQUE INDEX config_id (config_id),
  CONSTRAINT FK_cliente_vs_config_cliente_cliente_id FOREIGN KEY (cliente_id)
  REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE campos_personalizados (
  campo_id INT(11) NOT NULL AUTO_INCREMENT,
  modulo_id INT(11) NOT NULL,
  valor_campo TEXT DEFAULT NULL,
  nome_campo VARCHAR(100) NOT NULL,
  PRIMARY KEY (campo_id),
  UNIQUE INDEX campo_id (campo_id),
  CONSTRAINT FK_campos_personalizados_modul FOREIGN KEY (modulo_id)
    REFERENCES modulos (modulo_id) ON DELETE CASCADE ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;


CREATE TABLE config_esp_clientes (
  config_id INT(11) NOT NULL AUTO_INCREMENT,
  cliente_id INT(11) NOT NULL,
  modulo_id INT(11) NOT NULL,
  config TEXT DEFAULT NULL,
  PRIMARY KEY (config_id),
  CONSTRAINT FK_config_esp_clientes_cliente FOREIGN KEY (cliente_id)
    REFERENCES clientes(cliente_id) ON DELETE NO ACTION ON UPDATE RESTRICT,
  CONSTRAINT FK_config_esp_clientes_modulo_ FOREIGN KEY (modulo_id)
    REFERENCES modulos(modulo_id) ON DELETE NO ACTION ON UPDATE RESTRICT
)

ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;


CREATE TABLE arquivos (
  arquivo_id INTEGER(11) NOT NULL AUTO_INCREMENT UNIQUE,
  modulo_id INTEGER(11) NOT NULL,
  arquivo_nome VARCHAR(255) NOT NULL,
  arquivo_dados BLOB DEFAULT NULL,
  PRIMARY KEY (arquivo_id),
  CONSTRAINT FK_arquivos_modulo_id FOREIGN KEY (modulo_id)
    REFERENCES modulos(modulo_id) ON DELETE CASCADE ON UPDATE RESTRICT
)
ENGINE = INNODB;