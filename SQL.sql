CREATE DATABASE clients_info
CHARACTER SET utf8
COLLATE utf8_general_ci;

USE clients_info;

CREATE TABLE clientes (
  cliente_id int(11) NOT NULL AUTO_INCREMENT,
  codigo varchar(10) NOT NULL,
  PRIMARY KEY (cliente_id),
  UNIQUE INDEX cliente_id (cliente_id),
  UNIQUE INDEX codigo (codigo)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;





CREATE TABLE perfis (
  perfil_id int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(20) DEFAULT NULL,
  PRIMARY KEY (perfil_id),
  UNIQUE INDEX nome (nome),
  UNIQUE INDEX perfil_id (perfil_id)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE logins (
  login_id int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(255) NOT NULL,
  password int(11) NOT NULL,
  perfil int(11) NOT NULL,
  PRIMARY KEY (login_id),
  UNIQUE INDEX login_id (login_id),
  CONSTRAINT FK_logins_perfil FOREIGN KEY (perfil)
  REFERENCES perfis (perfil_id) ON DELETE NO ACTION ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE sistemas (
  sistema_id int(11) NOT NULL,
  nome varchar(255) NOT NULL,
  servidor varchar(40) DEFAULT NULL,
  pasta varchar(500) DEFAULT NULL,
  arquivos text DEFAULT NULL,
  config text DEFAULT NULL,
  prerequisitos text DEFAULT NULL,
  crontab text DEFAULT NULL,
  configcron text DEFAULT NULL,
  psirc text DEFAULT NULL,
  iscron tinyint(1) NOT NULL,
  layout1 blob DEFAULT NULL,
  layout2 blob DEFAULT NULL,
  layout3 blob DEFAULT NULL,
  layout4 blob DEFAULT NULL,
  PRIMARY KEY (sistema_id, nome),
  UNIQUE INDEX sistema_id (sistema_id)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE cliente_vs_sistema (
  relacao_id int(11) NOT NULL AUTO_INCREMENT,
  cliente_id int(11) NOT NULL,
  sistema_id int(11) NOT NULL,
  config_cliente text DEFAULT NULL,
  PRIMARY KEY (relacao_id),
  CONSTRAINT FK_cliente_vs_sistema_clientes_cliente_id FOREIGN KEY (cliente_id)
  REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_cliente_vs_sistema_sistemas_sistema_id FOREIGN KEY (sistema_id)
  REFERENCES sistemas (sistema_id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE usuarios (
  usuario_id int(11) NOT NULL AUTO_INCREMENT,
  login_id int(11) DEFAULT NULL,
  perfil_id int(11) DEFAULT NULL,
  Nome varchar(255) DEFAULT NULL,
  Telefone varchar(11) DEFAULT NULL,
  celular varchar(11) DEFAULT NULL,
  PRIMARY KEY (usuario_id),
  UNIQUE INDEX usuario_id (usuario_id),
  CONSTRAINT FK_usuarios_login_id FOREIGN KEY (login_id)
  REFERENCES logins (login_id) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT FK_usuarios_perfil_id FOREIGN KEY (perfil_id)
  REFERENCES perfis (perfil_id) ON DELETE NO ACTION ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

