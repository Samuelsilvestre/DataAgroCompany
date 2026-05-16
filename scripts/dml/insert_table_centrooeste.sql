DO $$
DECLARE
    -- Variáveis para guardar os IDs dos Estados
    id_mt UUID;
    id_ms UUID;

    -- Variáveis para guardar os IDs das Culturas
    id_soja UUID;
    id_milho UUID;
    id_arroz UUID;

    -- Variáveis para guardar os IDs das Safras
    id_safra_10_11 UUID;
    id_safra_11_12 UUID;
    id_safra_12_13 UUID;
    id_safra_13_14 UUID;
    id_safra_14_15 UUID;

    -- Variáveis para as Fazendas
    id_faz_horizonte UUID;
    id_faz_pampa UUID;
    id_faz_pantanal UUID;
    id_faz_progresso UUID;

    -- Variáveis para os Talhões
    id_talhao_h1 UUID;
    id_talhao_p1 UUID;
    id_talhao_pan1 UUID;
    id_talhao_pr1 UUID;

    -- Variáveis para os Plantios
    id_plantio_1 UUID;
    id_plantio_2 UUID;
    id_plantio_3 UUID;
    id_plantio_4 UUID;
BEGIN

    -- =========================================================
    -- 1. INSERÇÃO DOS ESTADOS (Retornando os UUIDs gerados)
    -- =========================================================
    INSERT INTO estados (nome, sigla, regiao)
    VALUES ('Mato Grosso', 'MT', 'Centro-Oeste')
    RETURNING id INTO id_mt;

    INSERT INTO estados (nome, sigla, regiao)
    VALUES ('Mato Grosso do Sul', 'MS', 'Centro-Oeste')
    RETURNING id INTO id_ms;


    -- =========================================================
    -- 2. INSERÇÃO DOS CULTURAS
    -- =========================================================
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias)
    VALUES ('Soja', 'Grãos', 120)
    RETURNING id INTO id_soja;

    INSERT INTO culturas (nome, categoria, ciclo_medio_dias)
    VALUES ('Milho', 'Grãos', 140)
    RETURNING id INTO id_milho;

    INSERT INTO culturas (nome, categoria, ciclo_medio_dias)
    VALUES ('Arroz', 'Grãos', 130)
    RETURNING id INTO id_arroz;


    -- =========================================================
    -- 3. INSERÇÃO DAS SAFRAS (Respeitando a regra: fim = inicio + 1)
    -- =========================================================
    INSERT INTO safras (ano_inicio, ano_fim, descricao)
    VALUES (2010, 2011, 'Safra 2010/2011') RETURNING id INTO id_safra_10_11;

    INSERT INTO safras (ano_inicio, ano_fim, descricao)
    VALUES (2011, 2012, 'Safra 2011/2012') RETURNING id INTO id_safra_11_12;

    INSERT INTO safras (ano_inicio, ano_fim, descricao)
    VALUES (2012, 2013, 'Safra 2012/2013') RETURNING id INTO id_safra_12_13;

    INSERT INTO safras (ano_inicio, ano_fim, descricao)
    VALUES (2013, 2014, 'Safra 2013/2014') RETURNING id INTO id_safra_13_14;

    INSERT INTO safras (ano_inicio, ano_fim, descricao)
    VALUES (2014, 2015, 'Safra 2014/2015') RETURNING id INTO id_safra_14_15;


    -- =========================================================
    -- 4. INSERÇÃO DAS 4 FAZENDAS (Vinculadas aos IDs dos Estados)
    -- =========================================================
    -- Fazendas no Mato Grosso (MT)
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_mt, 'Fazenda Horizonte Verde', 'Sorriso', 1500.00, '2008-05-10', -12.5444, -55.7222)
    RETURNING id INTO id_faz_horizonte;

    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_mt, 'Fazenda Nova Progresso', 'Lucas do Rio Verde', 2200.00, '2009-11-20', -13.0641, -55.9105)
    RETURNING id INTO id_faz_progresso;

    -- Fazendas no Mato Grosso do Sul (MS)
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_ms, 'Fazenda Pantanal Sul', 'Maracaju', 1800.00, '2007-03-15', -21.6144, -55.1683)
    RETURNING id INTO id_faz_pantanal;

    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_ms, 'Fazenda Pampa do Cerrado', 'Dourados', 1200.00, '2010-01-05', -22.2211, -54.8056)
    RETURNING id INTO id_faz_pampa;


    -- =========================================================
    -- 5. INSERÇÃO DOS TALHÕES (Vinculados às Fazendas)
    -- =========================================================
    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_horizonte, 'TALHAO_A_SOJA', 500.00, 'Argiloso', 365.00, FALSE)
    RETURNING id INTO id_talhao_h1;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_pampa, 'TALHAO_B_MILHO', 400.00, 'Franco-Arenoso', 430.00, TRUE)
    RETURNING id INTO id_talhao_p1;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_pantanal, 'TALHAO_C_ARROZ', 600.00, 'Humoso', 280.00, TRUE)
    RETURNING id INTO id_talhao_pan1;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_progresso, 'TALHAO_D_MIX', 800.00, 'Argiloso', 390.00, FALSE)
    RETURNING id INTO id_talhao_pr1;


    -- =========================================================
    -- 6. INSERÇÃO DOS PLANTIOS (Cruzando Talhão, Cultura e Safra)
    -- =========================================================
    -- Soja na Safra 2010/2011
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_10_11, '2010-10-15', 450.00, 1600.00, 'FINALIZADO')
    RETURNING id INTO id_plantio_1;

    -- Milho na Safra 2012/2013
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_p1, id_milho, id_safra_12_13, '2013-02-20', 380.00, 2200.00, 'FINALIZADO')
    RETURNING id INTO id_plantio_2;

    -- Arroz na Safra 2014/2015
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_pan1, id_arroz, id_safra_14_15, '2014-11-05', 550.00, 3100.00, 'FINALIZADO')
    RETURNING id INTO id_plantio_3;

    -- Soja na Safra 2013/2014
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_pr1, id_soja, id_safra_13_14, '2013-10-12', 700.00, 2500.00, 'FINALIZADO')
    RETURNING id INTO id_plantio_4;


    -- =========================================================
    -- 7. INSERÇÃO DAS COLHEITAS (Vinculadas obrigatoriamente a um Plantio)
    -- =========================================================
    -- Colheita do Plantio 1 (Soja)
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_plantio_1, '2011-02-20', 1580.50, 13.50, 1.20, 'TIPO_1');

    -- Colheita do Plantio 2 (Milho)
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_plantio_2, '2013-07-15', 2150.00, 14.00, 2.10, 'TIPO_2');

    -- Colheita do Plantio 3 (Arroz)
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_plantio_3, '2015-03-10', 3050.00, 12.80, 1.50, 'TIPO_1');

    -- Colheita do Plantio 4 (Soja)
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_plantio_4, '2014-02-18', 2610.00, 13.00, 0.90, 'TIPO_1');

END $$;

---============================---
---Bloco 2---
DO $$
DECLARE
    -- Variáveis para recuperar os IDs existentes
    id_soja UUID;
    id_milho UUID;
    id_arroz UUID;
    id_faz_horizonte UUID;
    id_faz_progresso UUID;
    id_faz_pantanal UUID;
    id_faz_pampa UUID;
    id_talhao_h1 UUID;
    id_talhao_p1 UUID;
    id_talhao_pan1 UUID;
    id_talhao_pr1 UUID;

    -- Novas Safras
    id_safra_15_16 UUID;
    id_safra_16_17 UUID;
    id_safra_17_18 UUID;
    id_safra_18_19 UUID;
    id_safra_19_20 UUID;

    -- Novos Plantios
    id_p_15_16 UUID; id_p_16_17 UUID; id_p_17_18 UUID; id_p_18_19 UUID; id_p_19_20 UUID;
BEGIN

    -- =========================================================
    -- 1. RECUPERANDO OS IDs DAS CULTURAS, FAZENDAS E TALHÕES
    -- =========================================================
    SELECT id INTO id_soja FROM culturas WHERE nome = 'Soja';
    SELECT id INTO id_milho FROM culturas WHERE nome = 'Milho';
    SELECT id INTO id_arroz FROM culturas WHERE nome = 'Arroz';

    SELECT id INTO id_faz_horizonte FROM fazendas WHERE nome = 'Fazenda Horizonte Verde';
    SELECT id INTO id_faz_progresso FROM fazendas WHERE nome = 'Fazenda Nova Progresso';
    SELECT id INTO id_faz_pantanal FROM fazendas WHERE nome = 'Fazenda Pantanal Sul';
    SELECT id INTO id_faz_pampa FROM fazendas WHERE nome = 'Fazenda Pampa do Cerrado';

    SELECT id INTO id_talhao_h1 FROM talhoes WHERE fazenda_id = id_faz_horizonte AND codigo = 'TALHAO_A_SOJA';
    SELECT id INTO id_talhao_pr1 FROM talhoes WHERE fazenda_id = id_faz_progresso AND codigo = 'TALHAO_D_MIX';
    SELECT id INTO id_talhao_p1 FROM talhoes WHERE fazenda_id = id_faz_pampa AND codigo = 'TALHAO_B_MILHO';
    SELECT id INTO id_talhao_pan1 FROM talhoes WHERE fazenda_id = id_faz_pantanal AND codigo = 'TALHAO_C_ARROZ';


    -- =========================================================
    -- 2. CRIAÇÃO DAS SAFRAS DE 2015 A 2020
    -- =========================================================
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2015, 2016, 'Safra 2015/2016') RETURNING id INTO id_safra_15_16;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2016, 2017, 'Safra 2016/2017') RETURNING id INTO id_safra_16_17;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2017, 2018, 'Safra 2017/2018') RETURNING id INTO id_safra_17_18;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2018, 2019, 'Safra 2018/2019') RETURNING id INTO id_safra_18_19;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2019, 2020, 'Safra 2019/2020') RETURNING id INTO id_safra_19_20;


    -- =========================================================
    -- 3. HISTÓRICO DE 5 ANOS: SOJA (Foco em dados reais e flutuações)
    -- =========================================================

    -- [ANO 1 - 2015/2016]: Ano Médio (Clima instável, produtividade padrão)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_15_16, '2015-10-20', 500.00, 1650.00, 'FINALIZADO') RETURNING id INTO id_p_15_16;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_15_16, '2016-02-25', 1620.00, 14.20, 1.80, 'TIPO_2');


    -- [ANO 2 - 2016/2017]: Ano Excelente (Recorde de safra, clima perfeito)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_16_17, '2016-10-18', 500.00, 1700.00, 'FINALIZADO') RETURNING id INTO id_p_16_17;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_16_17, '2017-02-22', 1950.50, 12.50, 0.80, 'TIPO_1'); -- Produção bem acima da prevista


    -- [ANO 3 - 2017/2018]: Ano Médio (Chuvas na colheita aumentaram a umidade)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_17_18, '2017-10-25', 500.00, 1750.00, 'FINALIZADO') RETURNING id INTO id_p_17_18;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_17_18, '2018-03-02', 1710.00, 15.10, 2.30, 'TIPO_2');


    -- [ANO 4 - 2018/2019]: Ano Excelente (Alta tecnologia e manejo perfeito)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_18_19, '2018-10-12', 500.00, 1800.00, 'FINALIZADO') RETURNING id INTO id_p_18_19;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_18_19, '2019-02-15', 2100.00, 13.00, 0.50, 'TIPO_1'); -- Excelente aproveitamento


    -- [ANO 5 - 2019/2020]: Ano Excelente (Fechando o ciclo em alta no MT)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_pr1, id_soja, id_safra_19_20, '2019-10-15', 750.00, 2600.00, 'FINALIZADO') RETURNING id INTO id_p_19_20;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_19_20, '2020-02-20', 2920.00, 12.90, 0.70, 'TIPO_1');


    -- =========================================================
    -- 4. OUTRAS CULTURAS SÓ PARA MANTER O BANCO MOVIMENTADO
    -- =========================================================
    -- Safrinha de Milho em 2017
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_p1, id_milho, id_safra_16_17, '2017-03-01', 400.00, 2400.00, 'FINALIZADO')
    RETURNING id INTO id_p_16_17;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_16_17, '2017-08-10', 2550.00, 13.80, 1.90, 'TIPO_1');

    -- Arroz no MS em 2019
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_pan1, id_arroz, id_safra_18_19, '2018-11-10', 580.00, 3200.00, 'FINALIZADO')
    RETURNING id INTO id_p_18_19;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_18_19, '2019-04-05', 3180.00, 13.00, 1.20, 'TIPO_1');

END $$;

---==================---
---BLOCO 3---
DO '
DECLARE
    -- IDs existentes
    id_soja UUID;
    id_milho UUID;
    id_faz_horizonte UUID;
    id_faz_progresso UUID;
    id_talhao_h1 UUID;
    id_talhao_pr1 UUID;

    -- Novas Safras (2020 até 2026)
    id_safra_20_21 UUID;
    id_safra_21_22 UUID;
    id_safra_22_23 UUID;
    id_safra_23_24 UUID;
    id_safra_24_25 UUID;
    id_safra_25_26 UUID;

    -- Novos Plantios
    id_p_20_21 UUID; id_p_21_22 UUID; id_p_22_23 UUID; id_p_23_24 UUID; id_p_24_25 UUID; id_p_25_26 UUID;
BEGIN

    -- =========================================================
    -- 1. RECUPERANDO OS IDs NECESSÁRIOS
    -- =========================================================
    SELECT id INTO id_soja FROM culturas WHERE nome = ''Soja'';
    SELECT id INTO id_milho FROM culturas WHERE nome = ''Milho'';

    SELECT id INTO id_faz_horizonte FROM fazendas WHERE nome = ''Fazenda Horizonte Verde'';
    SELECT id INTO id_faz_progresso FROM fazendas WHERE nome = ''Fazenda Nova Progresso'';

    SELECT id INTO id_talhao_h1 FROM talhoes WHERE fazenda_id = id_faz_horizonte AND codigo = ''TALHAO_A_SOJA'';
    SELECT id INTO id_talhao_pr1 FROM talhoes WHERE fazenda_id = id_faz_progresso AND codigo = ''TALHAO_D_MIX'';


    -- =========================================================
    -- 2. CRIAÇÃO DAS SAFRAS DE 2020 A 2026
    -- =========================================================
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2020, 2021, ''Safra 2020/2021'') RETURNING id INTO id_safra_20_21;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2021, 2022, ''Safra 2021/2022'') RETURNING id INTO id_safra_21_22;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2022, 2023, ''Safra 2022/2023'') RETURNING id INTO id_safra_22_23;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2023, 2024, ''Safra 2023/2024'') RETURNING id INTO id_safra_23_24;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2024, 2025, ''Safra 2024/2025'') RETURNING id INTO id_safra_24_25;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2025, 2026, ''Safra 2025/2026'') RETURNING id INTO id_safra_25_26;


    -- =========================================================
    -- 3. HISTÓRICO DE PRODUÇÃO (2020 - 2026)
    -- =========================================================

    -- [ANO 2020/2021] - Ano Ruim/Médio: Quebra de safra por estresse hídrico (Seca)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_20_21, ''2020-10-22'', 500.00, 1800.00, ''FINALIZADO'') RETURNING id INTO id_p_20_21;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_20_21, ''2021-02-28'', 1450.00, 13.00, 3.50, ''TIPO_2'');


    -- [ANO 2021/2022] - Ano Médio: Início instável, mas recuperação no final do ciclo
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_21_22, ''2021-10-15'', 500.00, 1800.00, ''FINALIZADO'') RETURNING id INTO id_p_21_22;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_21_22, ''2022-02-18'', 1720.00, 13.80, 2.10, ''TIPO_1'');


    -- [ANO 2022/2023] - Ano Excelente: Clima perfeito, recordes de produtividade no MT
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_22_23, ''2022-10-10'', 500.00, 1850.00, ''FINALIZADO'') RETURNING id INTO id_p_22_23;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_22_23, ''2023-02-12'', 2180.00, 12.20, 0.40, ''TIPO_1'');


    -- [ANO 2023/2024] - Ano Excelente: Consolidação do potencial do solo (Fazenda Progresso)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_pr1, id_soja, id_safra_23_24, ''2023-10-14'', 750.00, 2700.00, ''FINALIZADO'') RETURNING id INTO id_p_23_24;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_23_24, ''2024-02-19'', 3100.50, 12.50, 0.60, ''TIPO_1'');


    -- [ANO 2024/2025] - Ano Médio/Excelente: Clima bom, controle rigoroso de pragas
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_h1, id_soja, id_safra_24_25, ''2024-10-18'', 500.00, 1900.00, ''FINALIZADO'') RETURNING id INTO id_p_24_25;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_24_25, ''2025-02-22'', 1980.00, 13.20, 1.10, ''TIPO_1'');


    -- [ANO 2025/2026 - ANO ATUAL] - Safra Recém-Colhida ou Em Andamento
    -- Como estamos em 2026, esse plantio foi realizado no fim de 2025 e colhido no início de 2026.
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_talhao_pr1, id_soja, id_safra_25_26, ''2025-10-12'', 750.00, 2800.00, ''FINALIZADO'') RETURNING id INTO id_p_25_26;

    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_25_26, ''2026-02-15'', 3150.00, 12.80, 0.50, ''TIPO_1'');

END;
';
