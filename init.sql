GRANT ALL PRIVILEGES ON *.* TO 'admin-dba'@'%' IDENTIFIED BY 'SPTECHnaregua2024' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_naregua
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_naregua
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_naregua` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_naregua` ;

-- -----------------------------------------------------
-- Table `db_naregua`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `cep` VARCHAR(9) NULL DEFAULT NULL,
  `logradouro` VARCHAR(250) NULL DEFAULT NULL,
  `numero` INT NULL DEFAULT NULL,
  `complemento` VARCHAR(50) NULL DEFAULT NULL,
  `cidade` VARCHAR(60) NULL DEFAULT NULL,
  `estado` VARCHAR(60) NULL DEFAULT NULL,
  `localizacao` POINT NOT NULL,
  PRIMARY KEY (`id_endereco`),
  SPATIAL INDEX `idx_localizacao` (`localizacao`) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`barbearia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`barbearia` (
  `id_barbearia` INT NOT NULL AUTO_INCREMENT,
  `nome_negocio` VARCHAR(100) NULL DEFAULT NULL,
  `email_negocio` VARCHAR(100) NULL DEFAULT NULL,
  `celular_negocio` VARCHAR(15) NULL DEFAULT NULL,
  `cnpj` VARCHAR(18) NULL DEFAULT NULL,
  `cpf` VARCHAR(14) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `barbearia_fk_endereco` INT NOT NULL,
  `img_perfil` TEXT NULL DEFAULT NULL,
  `img_banner` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_barbearia`),
  INDEX `barbearia_fk_endereco` (`barbearia_fk_endereco` ASC) VISIBLE,
  CONSTRAINT `barbearia_ibfk_1`
    FOREIGN KEY (`barbearia_fk_endereco`)
    REFERENCES `db_naregua`.`endereco` (`id_endereco`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`servico` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `preco` FLOAT NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `tipo_servico` VARCHAR(180) NULL DEFAULT NULL,
  `tempo_estimado` INT NOT NULL,
  `servico_fk_barbearia` INT NOT NULL,
  `nome_barbeiro` VARCHAR(255) NULL DEFAULT NULL,
  `status` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `servico_fk_barbearia` (`servico_fk_barbearia` ASC) VISIBLE,
  CONSTRAINT `servico_ibfk_1`
    FOREIGN KEY (`servico_fk_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`especialidade` (
  `id_especialidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(180) NULL DEFAULT NULL,
  PRIMARY KEY (`id_especialidade`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `dtype` VARCHAR(50) NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `senha` VARCHAR(80) NOT NULL,
  `celular` VARCHAR(15) NOT NULL,
  `img_perfil` VARCHAR(255) NULL DEFAULT NULL,
  `usuario_admin` BIT(1) NULL DEFAULT NULL,
  `usuario_fk_barbearia` INT NULL DEFAULT NULL,
  `usuario_fk_endereco` INT NULL DEFAULT NULL,
  `barbeiro_fk_especialidade` INT NULL DEFAULT NULL,
  `usuario_fk_especialidade` INT NULL DEFAULT NULL,
  `username` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `UK_usuario_especialidade` (`usuario_fk_especialidade` ASC) VISIBLE,
  INDEX `usuario_fk_barbearia` (`usuario_fk_barbearia` ASC) VISIBLE,
  INDEX `usuario_fk_endereco` (`usuario_fk_endereco` ASC) VISIBLE,
  INDEX `barbeiro_fk_especialidade` (`barbeiro_fk_especialidade` ASC) VISIBLE,
  CONSTRAINT `usuario_ibfk_1`
    FOREIGN KEY (`usuario_fk_especialidade`)
    REFERENCES `db_naregua`.`especialidade` (`id_especialidade`),
  CONSTRAINT `usuario_ibfk_2`
    FOREIGN KEY (`usuario_fk_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`),
  CONSTRAINT `usuario_ibfk_3`
    FOREIGN KEY (`usuario_fk_endereco`)
    REFERENCES `db_naregua`.`endereco` (`id_endereco`),
  CONSTRAINT `usuario_ibfk_4`
    FOREIGN KEY (`barbeiro_fk_especialidade`)
    REFERENCES `db_naregua`.`especialidade` (`id_especialidade`))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`avaliacao` (
  `id_avaliacao` INT NOT NULL AUTO_INCREMENT,
  `resultado_avaliacao` DECIMAL(3,2) NULL DEFAULT NULL,
  `comentario` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_avaliacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`agendamento` (
  `id_agendamento` INT NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `status` VARCHAR(50) NULL DEFAULT NULL,
  `ag_fk_avaliacao` INT NULL DEFAULT NULL,
  `barbearia_id_barbearia` INT NOT NULL,
  `barbeiro_id_usuario` INT NOT NULL,
  `cliente_id_usuario` INT NOT NULL,
  `servico_id_servico` INT NOT NULL,
  `especialidade_id_especialidade` INT NULL DEFAULT NULL,
  `data_hora_concluido` DATETIME NULL DEFAULT NULL,
  `data_hora_fim_prevista` DATETIME NULL DEFAULT NULL,
  `avaliado` BIT(1) NULL DEFAULT NULL,
  `id_avaliacao` INT NULL DEFAULT NULL,
  `concluido` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_agendamento`),
  INDEX `servico_id_servico` (`servico_id_servico` ASC) VISIBLE,
  INDEX `barbeiro_id_usuario` (`barbeiro_id_usuario` ASC) VISIBLE,
  INDEX `id_avaliacao` (`id_avaliacao` ASC) VISIBLE,
  INDEX `cliente_id_usuario` (`cliente_id_usuario` ASC) VISIBLE,
  INDEX `ag_fk_avaliacao` (`ag_fk_avaliacao` ASC) VISIBLE,
  INDEX `especialidade_id_especialidade` (`especialidade_id_especialidade` ASC) VISIBLE,
  INDEX `barbearia_id_barbearia` (`barbearia_id_barbearia` ASC) VISIBLE,
  CONSTRAINT `agendamento_ibfk_1`
    FOREIGN KEY (`servico_id_servico`)
    REFERENCES `db_naregua`.`servico` (`id_servico`),
  CONSTRAINT `agendamento_ibfk_2`
    FOREIGN KEY (`barbeiro_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`),
  CONSTRAINT `agendamento_ibfk_3`
    FOREIGN KEY (`id_avaliacao`)
    REFERENCES `db_naregua`.`avaliacao` (`id_avaliacao`),
  CONSTRAINT `agendamento_ibfk_4`
    FOREIGN KEY (`cliente_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`),
  CONSTRAINT `agendamento_ibfk_5`
    FOREIGN KEY (`ag_fk_avaliacao`)
    REFERENCES `db_naregua`.`avaliacao` (`id_avaliacao`),
  CONSTRAINT `agendamento_ibfk_6`
    FOREIGN KEY (`especialidade_id_especialidade`)
    REFERENCES `db_naregua`.`especialidade` (`id_especialidade`),
  CONSTRAINT `agendamento_ibfk_7`
    FOREIGN KEY (`barbearia_id_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`chat` (
  `id_chat` INT NOT NULL AUTO_INCREMENT,
  `data_criacao` DATETIME NOT NULL,
  `barbearia_id_barbearia` INT NULL DEFAULT NULL,
  `usuario_id_usuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_chat`),
  INDEX `FK2ahurspt0jxplu4jlj9e5d4si` (`barbearia_id_barbearia` ASC) VISIBLE,
  INDEX `FKdi1ir9kfe88qhkcvvl5bydk3c` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `FK2ahurspt0jxplu4jlj9e5d4si`
    FOREIGN KEY (`barbearia_id_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`),
  CONSTRAINT `FKdi1ir9kfe88qhkcvvl5bydk3c`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`postagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`postagem` (
  `id_postagem` INT NOT NULL AUTO_INCREMENT,
  `conteudo` TEXT NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  `postagem_id_usuario` INT NOT NULL,
  `is_active` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_postagem`, `postagem_id_usuario`),
  INDEX `fk_postagem_usuario` (`postagem_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_postagem_usuario`
    FOREIGN KEY (`postagem_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`comentario` (
  `id_comentario` INT NOT NULL AUTO_INCREMENT,
  `conteudo` TEXT NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  `comentario_id_postagem` INT NOT NULL,
  `comentario_id_usuario` INT NOT NULL,
  `is_active` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_comentario`, `comentario_id_postagem`, `comentario_id_usuario`),
  INDEX `fk_comentario_postagem` (`comentario_id_postagem` ASC) VISIBLE,
  INDEX `fk_comentario_usuario` (`comentario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_comentario_postagem`
    FOREIGN KEY (`comentario_id_postagem`)
    REFERENCES `db_naregua`.`postagem` (`id_postagem`),
  CONSTRAINT `fk_comentario_usuario`
    FOREIGN KEY (`comentario_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`curtida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`curtida` (
  `id_curtida` INT NOT NULL AUTO_INCREMENT,
  `data_criacao` DATETIME NOT NULL,
  `curtida_id_usuario` INT NOT NULL,
  `curtida_id_comentario` INT NULL DEFAULT NULL,
  `curtida_id_postagem` INT NULL DEFAULT NULL,
  `is_active` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_curtida`, `curtida_id_usuario`),
  INDEX `fk_curtida_postagem` (`curtida_id_postagem` ASC) VISIBLE,
  INDEX `fk_curtida_comentario` (`curtida_id_comentario` ASC) VISIBLE,
  INDEX `fk_curtida_usuario` (`curtida_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_curtida_comentario`
    FOREIGN KEY (`curtida_id_comentario`)
    REFERENCES `db_naregua`.`comentario` (`id_comentario`),
  CONSTRAINT `fk_curtida_postagem`
    FOREIGN KEY (`curtida_id_postagem`)
    REFERENCES `db_naregua`.`postagem` (`id_postagem`),
  CONSTRAINT `fk_curtida_usuario`
    FOREIGN KEY (`curtida_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`dia_semana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`dia_semana` (
  `id_dia_semana` INT NOT NULL AUTO_INCREMENT,
  `nome` ENUM('SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM') NULL DEFAULT NULL,
  `hora_abertura` TIME NULL DEFAULT NULL,
  `hora_fechamento` TIME NULL DEFAULT NULL,
  `ds_id_barbearia` INT NOT NULL,
  PRIMARY KEY (`id_dia_semana`),
  INDEX `ds_id_barbearia` (`ds_id_barbearia` ASC) VISIBLE,
  CONSTRAINT `dia_semana_ibfk_1`
    FOREIGN KEY (`ds_id_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`))
ENGINE = InnoDB
AUTO_INCREMENT = 57
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`financeiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`financeiro` (
  `id_financeiro` INT NOT NULL AUTO_INCREMENT,
  `dt_lancamento` DATETIME(6) NULL DEFAULT NULL,
  `valor` FLOAT NULL DEFAULT NULL,
  `saldo` DECIMAL(10,2) NULL DEFAULT NULL,
  `despesas` BIT(1) NULL DEFAULT NULL,
  `financeiro_fk_barbearia` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_financeiro`),
  INDEX `financeiro_fk_barbearia` (`financeiro_fk_barbearia` ASC) VISIBLE,
  CONSTRAINT `financeiro_ibfk_1`
    FOREIGN KEY (`financeiro_fk_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`imgs_galeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`imgs_galeria` (
  `id_imgs_galeria` INT NOT NULL AUTO_INCREMENT,
  `imagem` TEXT NOT NULL,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `usuario_id_usuario` INT NULL DEFAULT NULL,
  `is_active` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_imgs_galeria`),
  INDEX `usuario_id_usuario` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `imgs_galeria_ibfk_1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`mensagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`mensagem` (
  `id_mensagem` INT NOT NULL AUTO_INCREMENT,
  `conteudo` TEXT NULL DEFAULT NULL,
  `data_criacao` DATETIME NOT NULL,
  `status_mensagem` VARCHAR(45) NULL DEFAULT NULL,
  `mensagem_id_usuario` INT NOT NULL,
  `mensagem_id_chat` INT NOT NULL,
  `filename` TEXT NULL DEFAULT NULL,
  `tipo` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_mensagem`, `mensagem_id_usuario`, `mensagem_id_chat`),
  INDEX `fk_mensagem_usuario_idx` (`mensagem_id_usuario` ASC) VISIBLE,
  INDEX `fk_mensagem_chat_history1_idx` (`mensagem_id_chat` ASC) VISIBLE,
  CONSTRAINT `FK7tu1hlxoywt5f7m6adct06cwt`
    FOREIGN KEY (`mensagem_id_chat`)
    REFERENCES `db_naregua`.`chat` (`id_chat`),
  CONSTRAINT `fk_mensagem_usuario`
    FOREIGN KEY (`mensagem_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`midia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`midia` (
  `id_midia` INT NOT NULL AUTO_INCREMENT,
  `arquivo` TEXT NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  `midia_id_postagem` INT NULL DEFAULT NULL,
  `midia_id_comentario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_midia`),
  INDEX `fk_midia_postagem` (`midia_id_postagem` ASC) VISIBLE,
  INDEX `fk_midia_comentario` (`midia_id_comentario` ASC) VISIBLE,
  CONSTRAINT `fk_midia_comentario`
    FOREIGN KEY (`midia_id_comentario`)
    REFERENCES `db_naregua`.`comentario` (`id_comentario`),
  CONSTRAINT `fk_midia_postagem`
    FOREIGN KEY (`midia_id_postagem`)
    REFERENCES `db_naregua`.`postagem` (`id_postagem`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`tipo_notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`tipo_notificacao` (
  `id_tipo_notificacao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  PRIMARY KEY (`id_tipo_notificacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`notificacao` (
  `id_notificacao` INT NOT NULL AUTO_INCREMENT,
  `notificacao_id_usuario` INT NOT NULL,
  `notificacao_id_tipo` INT NOT NULL,
  `referencia_id` INT NULL DEFAULT NULL,
  `mensagem` TEXT NULL DEFAULT NULL,
  `data_criacao` DATETIME NULL DEFAULT NULL,
  `lida` BIT(1) NULL DEFAULT b'0',
  `notificacao_id_usuario_notificado` INT NOT NULL,
  PRIMARY KEY (`id_notificacao`),
  INDEX `notificacao_id_usuario` (`notificacao_id_usuario` ASC) VISIBLE,
  INDEX `notificacao_id_tipo` (`notificacao_id_tipo` ASC) VISIBLE,
  INDEX `FK162kupndxjkiq3plcpsrh6q0i` (`notificacao_id_usuario_notificado` ASC) VISIBLE,
  CONSTRAINT `FK162kupndxjkiq3plcpsrh6q0i`
    FOREIGN KEY (`notificacao_id_usuario_notificado`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`),
  CONSTRAINT `notificacao_ibfk_1`
    FOREIGN KEY (`notificacao_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`),
  CONSTRAINT `notificacao_ibfk_2`
    FOREIGN KEY (`notificacao_id_tipo`)
    REFERENCES `db_naregua`.`tipo_notificacao` (`id_tipo_notificacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`seguidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`seguidores` (
  `id_seguidores` INT NOT NULL AUTO_INCREMENT,
  `seguidor_id` INT NOT NULL,
  `seguido_id` INT NOT NULL,
  `data_seguimento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_seguidores`),
  UNIQUE INDEX `unique_seguimento` (`seguidor_id` ASC, `seguido_id` ASC) VISIBLE,
  INDEX `fk_seguido` (`seguido_id` ASC) VISIBLE,
  CONSTRAINT `fk_seguido`
    FOREIGN KEY (`seguido_id`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_seguidor`
    FOREIGN KEY (`seguidor_id`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_naregua`.`usuario_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_naregua`.`usuario_servico` (
  `servico_id_servico` INT NOT NULL,
  `servico_fk_barbearia` INT NULL DEFAULT NULL,
  `usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`servico_id_servico`, `usuario_id_usuario`),
  INDEX `servico_fk_barbearia` (`servico_fk_barbearia` ASC) VISIBLE,
  INDEX `usuario_id_usuario` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `usuario_servico_ibfk_1`
    FOREIGN KEY (`servico_fk_barbearia`)
    REFERENCES `db_naregua`.`barbearia` (`id_barbearia`),
  CONSTRAINT `usuario_servico_ibfk_2`
    FOREIGN KEY (`servico_id_servico`)
    REFERENCES `db_naregua`.`servico` (`id_servico`),
  CONSTRAINT `usuario_servico_ibfk_3`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `db_naregua`.`usuario` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

