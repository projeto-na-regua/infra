-- Inserções na tabela 'barbearia'
INSERT INTO barbearia (nome_negocio, img_perfil) VALUES ('Barbearia do Zé', 'imagem_perfil_barbearia1.jpg');
INSERT INTO barbearia (nome_negocio, img_perfil) VALUES ('Barbearia Moderna', 'imagem_perfil_barbearia2.jpg');

-- Inserções na tabela 'usuario'
INSERT INTO usuario (nome, email, senha, celular, imgPerfil, user_admin, user_fk_barbearia) VALUES ('João', 'joao@example.com', 'senha123', '999999999', 'joao_foto_perfil.jpg', 1, 1);
INSERT INTO usuario (nome, email, senha, celular, imgPerfil, user_admin, user_fk_barbearia) VALUES ('Maria', 'maria@example.com', 'senha456', '888888888', 'maria_foto_perfil.jpg', 0, 2);
INSERT INTO usuario (nome, email, senha, celular, imgPerfil) VALUES ('Douglas', 'douglas@example.com', 'senha456', '888888888', 'douglas_foto_perfil.jpg');

-- Inserções na tabela 'financeiro'
INSERT INTO financeiro (id_financeiro, valor, dt_lancamento, financeiro_fk_barberia) VALUES (1, 100.50, '2024-04-03 10:00:00', 1);
INSERT INTO financeiro (id_financeiro, valor, dt_lancamento, financeiro_fk_barberia) VALUES (2, 200.75, '2024-04-03 11:30:00', 2);

-- Inserções na tabela 'endereco'
INSERT INTO endereco (id_endereco, cep, logradouro, numero, complemento, cidade, estado, end_fk_barbearia, end_fk_usuario) VALUES (1, '12345-678', 'Rua Teste', 123, 'Apto 101', 'Cidade Teste', 'Estado Teste', 1, 1);
INSERT INTO endereco (id_endereco, cep, logradouro, numero, complemento, cidade, estado, end_fk_barbearia, end_fk_usuario) VALUES (2, '54321-987', 'Avenida Principal', 456, 'Sala 202', 'Cidade Nova', 'Estado Novo', 2, 2);

-- Inserções na tabela 'imgs_galeria'
INSERT INTO imgs_galeria (id_imgs_galeria, imagem, barbearia_id_barbearia, usuario_id_usuario) VALUES (1, 'imagem_galeria1.jpg', 1, 1);
INSERT INTO imgs_galeria (id_imgs_galeria, imagem, barbearia_id_barbearia, usuario_id_usuario) VALUES (2, 'imagem_galeria2.jpg', 2, 2);

-- Inserções na tabela 'especialidade'
INSERT INTO especialidade (id_especialidade, nome) VALUES (1, 'Corte Masculino');
INSERT INTO especialidade (id_especialidade, nome) VALUES (2, 'Barba');

-- Inserções na tabela 'servico'
INSERT INTO servico (id_servico, preco, descricao, tipo_servico, servico_fk_usuario, servico_fk_barbearia, servico_fk_especialidade) VALUES (1, 50.00, 'Corte de cabelo masculino padrão', 'Corte Masculino', 1, 1, 1);
INSERT INTO servico (id_servico, preco, descricao, tipo_servico, servico_fk_usuario, servico_fk_barbearia, servico_fk_especialidade) VALUES (2, 30.00, 'Barba completa com navalha', 'Barba', 2, 2, 2);

-- Inserções na tabela 'avaliacao'
INSERT INTO avaliacao (id_avaliacao, resultado_avaliacao) VALUES (1, 4.5);
INSERT INTO avaliacao (id_avaliacao, resultado_avaliacao) VALUES (2, 4.0);

-- Inserções na tabela 'agendamento'
INSERT INTO agendamento (id_agendamento, data_hora, ag_fk_servico, ag_fk_usuario, ag_fk_barbearia, ag_fk_especialidade, ag_fk_avaliacao) VALUES (1, '2024-04-10 14:00:00', 1, 1, 1, 1, 1);
INSERT INTO agendamento (id_agendamento, data_hora, ag_fk_servico, ag_fk_usuario, ag_fk_barbearia, ag_fk_especialidade, ag_fk_avaliacao) VALUES (2, '2024-04-15 15:30:00', 2, 2, 2, 2, 2);


-- Selecionar todas as barbearias
SELECT * FROM barbearia;

-- Selecionar todos os usuários
SELECT * FROM usuario;

-- Selecionar todos os registros financeiros
SELECT * FROM financeiro;

-- Selecionar todos os endereços
SELECT * FROM endereco;

-- Selecionar todas as imagens da galeria
SELECT * FROM imgs_galeria;

-- Selecionar todas as especialidades
SELECT * FROM especialidade;

-- Selecionar todos os serviços
SELECT * FROM servico;

-- Selecionar todas as avaliações
SELECT * FROM avaliacao;

-- Selecionar todos os agendamentos
SELECT * FROM agendamento;
