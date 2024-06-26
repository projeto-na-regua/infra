CREATE DATABASE db_naregua;
USE db_naregua;

CREATE TABLE IF NOT EXISTS endereco (
  id_endereco INT NOT NULL AUTO_INCREMENT,
  cep CHAR(9) NULL,
  logradouro VARCHAR(250) NULL,
  numero INT NULL,
  complemento VARCHAR(50) NULL,
  cidade VARCHAR(60) NULL,
  estado VARCHAR(60) NULL,
  PRIMARY KEY (id_endereco)
);
  
CREATE TABLE IF NOT EXISTS especialidade (
  id_especialidade INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(180) NULL,
  PRIMARY KEY (id_especialidade)
);

CREATE TABLE IF NOT EXISTS avaliacao (
  id_avaliacao INT NOT NULL AUTO_INCREMENT,
  resultado_avaliacao DECIMAL(3,2) NULL,
  constraint check_avaliacao check (resultado_avaliacao <= 5 AND resultado_avaliacao >= 0),
  PRIMARY KEY (id_avaliacao)
);

CREATE TABLE IF NOT EXISTS dia_semana (
  id_dia_semana INT NOT NULL AUTO_INCREMENT,
  nome ENUM('SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM') NOT NULL,
  hora_abertura TIME NULL,
  hora_fechamento TIME NULL,
  ds_id_barbearia INT NOT NULL,
  PRIMARY KEY (id_dia_semana),
  INDEX fk_dia_semana_barbearia1_idx (ds_id_barbearia ASC) VISIBLE,
  CONSTRAINT Fk_dia_semana_barbearia1
    FOREIGN KEY (ds_id_barbearia)
    REFERENCES barbearia (id_barbearia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS barbearia (
  id_barbearia INT NOT NULL AUTO_INCREMENT,
  nome_negocio VARCHAR(100) NULL,
  email_negocio VARCHAR(100) NULL,
  celular_negocio VARCHAR(15) NULL,
  img_perfil BLOB NULL,
  cnpj VARCHAR(18) NULL,
  cpf VARCHAR(14) NULL,
  descricao TEXT NULL,
  barbearia_fk_endereco INT NOT NULL,
  PRIMARY KEY (id_barbearia),
  INDEX fk_barbearia_endereco1_idx (barbearia_fk_endereco ASC) VISIBLE,
  CONSTRAINT fk_barbearia_endereco1
    FOREIGN KEY (barbearia_fk_endereco)
    REFERENCES endereco (id_endereco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    



CREATE TABLE IF NOT EXISTS usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  dtype VARCHAR(50) NOT NULL,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(250) NOT NULL,
  senha VARCHAR(12) NOT NULL,
  celular VARCHAR(15) NOT NULL,
  img_perfil BLOB NULL,
  usuario_admin TINYINT(1) NULL,
  usuario_fk_barbearia INT NULL,
  usuario_fk_endereco INT NULL,
  PRIMARY KEY (id_usuario),
  INDEX fk_Usuario_Barbearia1_idx (usuario_fk_barbearia ASC) VISIBLE,
  CONSTRAINT fk_Usuario_Barbearia1
    FOREIGN KEY (usuario_fk_barbearia)
    REFERENCES barbearia(id_barbearia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
 CONSTRAINT fk_usuario_cliente FOREIGN KEY (usuario_fk_endereco) REFERENCES endereco(id_endereco),
 CONSTRAINT checkDtype CHECK (dtype IN('Barbeiro', 'Cliente'))
);

    
CREATE TABLE IF NOT EXISTS financeiro (
  id_financeiro INT NOT NULL AUTO_INCREMENT,
  valor DECIMAL(8,2) NULL,
  dt_lancamento DATETIME NULL,
  financeiro_fk_barberia INT NOT NULL,
  PRIMARY KEY (id_financeiro, financeiro_fk_barberia),
  INDEX fk_financeiro_Barbearia1_idx (financeiro_fk_barberia ASC) VISIBLE,
  CONSTRAINT fk_financeiro_Barbearia1
    FOREIGN KEY (financeiro_fk_barberia)
    REFERENCES barbearia (id_barbearia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
    
CREATE TABLE IF NOT EXISTS imgs_galeria (
  id_imgs_galeria INT NOT NULL AUTO_INCREMENT,
  imagem TEXT NULL,
  barbearia_id_barbearia INT NOT NULL,
  usuario_id_usuario INT NOT NULL,
  PRIMARY KEY (id_imgs_galeria),
  INDEX fk_imgs_galeria_barbearia1_idx (barbearia_id_barbearia ASC) VISIBLE,
  INDEX fk_imgs_galeria_usuario1_idx (usuario_id_usuario ASC) VISIBLE,
  CONSTRAINT fk_imgs_galeria_barbearia1
    FOREIGN KEY (barbearia_id_barbearia)
    REFERENCES barbearia (id_barbearia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_imgs_galeria_usuario1
    FOREIGN KEY (usuario_id_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS servico (
  id_servico INT NOT NULL AUTO_INCREMENT,
  preco DECIMAL(7,2) NULL,
  descricao TEXT NULL,
  tipo_servico VARCHAR(180) NULL,
  tempo_estimado INT NOT NULL,
  servico_fk_usuario INT NOT NULL,
  servico_fk_barbearia INT NOT NULL,
  servico_fk_especialidade INT NOT NULL,
  PRIMARY KEY (id_servico, servico_fk_usuario, servico_fk_barbearia, servico_fk_especialidade),
  INDEX fk_servico_usuario1_idx (servico_fk_usuario ASC) VISIBLE,
  INDEX fk_servico_barbearia1_idx (servico_fk_barbearia ASC) VISIBLE,
  INDEX fk_servico_especialidade1_idx (servico_fk_especialidade ASC) VISIBLE,
  CONSTRAINT fk_servico_usuario1
    FOREIGN KEY (servico_fk_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servico_barbearia1
    FOREIGN KEY (servico_fk_barbearia)
    REFERENCES barbearia (id_barbearia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servico_especialidade1
    FOREIGN KEY (servico_fk_especialidade)
    REFERENCES especialidade (id_especialidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX idx_servico_fk_agendamento (id_servico, servico_fk_usuario, servico_fk_barbearia, servico_fk_especialidade)
);

CREATE TABLE IF NOT EXISTS agendamento (
  id_agendamento INT NOT NULL AUTO_INCREMENT,
  data_hora DATETIME NULL,
  concluido BOOLEAN NOT NULL,
  ag_fk_servico INT NOT NULL,
  ag_fk_cliente INT NOT NULL,
  ag_fk_barbeiro INT NOT NULL,
  ag_fk_barbearia INT NOT NULL,
  ag_fk_especialidade INT NOT NULL,
  ag_fk_avaliacao INT NOT NULL,
  PRIMARY KEY (id_agendamento),
  INDEX fk_agendamento_Avaliacao1_idx (ag_fk_avaliacao),
  CONSTRAINT fk_agendamento_cliente
    FOREIGN KEY (ag_fk_cliente)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_agendamento_barbeiro
    FOREIGN KEY (ag_fk_barbeiro)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_agendamento_Avaliacao1
    FOREIGN KEY (ag_fk_avaliacao)
    REFERENCES avaliacao (id_avaliacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

