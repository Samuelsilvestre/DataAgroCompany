DO '
DECLARE
    -- IDs dos Estados
    id_rs UUID;
    id_pr UUID;

    -- IDs das Culturas
    id_soja UUID;
    id_milho UUID;
    id_trigo UUID;
    id_cevada UUID;
    id_aveia UUID;

    -- IDs das Safras (2010 a 2026)
    id_sf10 UUID; id_sf11 UUID; id_sf12 UUID; id_sf13 UUID; id_sf14 UUID; id_sf15 UUID;
    id_sf16 UUID; id_sf17 UUID; id_sf18 UUID; id_sf19 UUID; id_sf20 UUID; id_sf21 UUID;
    id_sf22 UUID; id_sf23 UUID; id_sf24 UUID; id_sf25 UUID;

    -- IDs das 4 Fazendas do Sul
    id_faz_pampa_verde UUID;
    id_faz_missioes UUID;
    id_faz_pinhais UUID;
    id_faz_norte_parana UUID;

    -- IDs dos Talhões
    id_tal_rs_pampa UUID;
    id_tal_rs_missioes UUID;
    id_tal_pr_pinhais UUID;
    id_tal_pr_norte UUID;

    -- IDs dos Plantios temporários para as colheitas
    id_p_v1 UUID; id_p_v2 UUID; id_p_v3 UUID; id_p_v4 UUID; id_p_v5 UUID; id_p_v6 UUID;
    id_p_i1 UUID; id_p_i2 UUID; id_p_i3 UUID; id_p_i4 UUID; id_p_i5 UUID; id_p_i6 UUID;
BEGIN

    -- =========================================================
    -- 1. CADASTRO DOS ESTADOS (SUL) - EVITA DUPLICADO
    -- =========================================================
    INSERT INTO estados (nome, sigla, regiao)
    VALUES (''Rio Grande do Sul'', ''RS'', ''Sul'')
    ON CONFLICT (sigla) DO UPDATE SET nome = EXCLUDED.nome
    RETURNING id INTO id_rs;

    INSERT INTO estados (nome, sigla, regiao)
    VALUES (''Paraná'', ''PR'', ''Sul'')
    ON CONFLICT (sigla) DO UPDATE SET nome = EXCLUDED.nome
    RETURNING id INTO id_pr;


    -- =========================================================
    -- 2. CADASTRO DE CULTURAS COM TRATAMENTO DE CONFLITO
    -- =========================================================
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Soja'', ''Grãos'', 120) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_soja;
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Milho'', ''Grãos'', 140) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_milho;
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Trigo'', ''Grãos'', 140) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_trigo;
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Cevada'', ''Grãos'', 120) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_cevada;
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Aveia'', ''Grãos'', 115) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_aveia;


    -- =========================================================
    -- 3. CADASTRO DAS SAFRAS (2010 ATÉ 2026) - EVITA DUPLICADO
    -- =========================================================
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2010, 2011, ''Safra 2010/2011'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf10;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2011, 2012, ''Safra 2011/2012'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf11;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2012, 2013, ''Safra 2012/2013'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf12;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2013, 2014, ''Safra 2013/2014'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf13;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2014, 2015, ''Safra 2014/2015'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf14;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2015, 2016, ''Safra 2015/2016'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf15;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2016, 2017, ''Safra 2016/2017'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf16;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2017, 2018, ''Safra 2017/2018'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf17;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2018, 2019, ''Safra 2018/2019'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf18;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2019, 2020, ''Safra 2019/2020'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf19;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2020, 2021, ''Safra 2020/2021'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf20;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2021, 2022, ''Safra 2021/2022'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf21;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2022, 2023, ''Safra 2022/2023'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf22;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2023, 2024, ''Safra 2023/2024'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf23;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2024, 2025, ''Safra 2024/2025'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf24;
    INSERT INTO safras (ano_inicio, ano_fim, descricao) VALUES (2025, 2026, ''Safra 2025/2026'') ON CONFLICT (descricao) DO UPDATE SET ano_inicio = EXCLUDED.ano_inicio RETURNING id INTO id_sf25;


    -- =========================================================
    -- 4. CADASTRO DAS 4 FAZENDAS DO SUL
    -- =========================================================
    -- Rio Grande do Sul
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_rs, ''Fazenda Pampa Verde'', ''Passo Fundo'', 800.00, ''2005-03-15'', -28.2612, -52.4083) RETURNING id INTO id_faz_pampa_verde;

    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_rs, ''Fazenda Missões Velhas'', ''Santo Ângelo'', 1200.00, ''2008-11-22'', -28.2994, -54.2631) RETURNING id INTO id_faz_missioes;

    -- Paraná
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_pr, ''Fazenda das Pinheiras'', ''Cascavel'', 1500.00, ''2004-06-10'', -24.9555, -53.4552) RETURNING id INTO id_faz_pinhais;

    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_pr, ''Fazenda Terra Roxa'', ''Londrina'', 1100.00, ''2009-01-18'', -23.3102, -51.1628) RETURNING id INTO id_faz_norte_parana;


    -- =========================================================
    -- 5. CADASTRO DOS TALHÕES ESTRATÉGICOS
    -- =========================================================
    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_pampa_verde, ''TALHAO_RS_PASSO_01'', 350.00, ''Latossolo'', 680.00, FALSE) RETURNING id INTO id_tal_rs_pampa;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_missioes, ''TALHAO_RS_SANTO_01'', 500.00, ''Argiloso'', 290.00, TRUE) RETURNING id INTO id_tal_rs_missioes;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_pinhais, ''TALHAO_PR_CASCAVEL_01'', 650.00, ''Terra Roxa'', 760.00, FALSE) RETURNING id INTO id_tal_pr_pinhais;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_norte_parana, ''TALHAO_PR_LONDRINA_01'', 450.00, ''Latossolo Vermelho'', 580.00, TRUE) RETURNING id INTO id_tal_pr_norte;


    -- =========================================================
    -- 6. HISTÓRICO DE SAFRAS (2010 - 2026): VERÃO E INVERNO (ROTAÇÃO)
    -- =========================================================

    -- [PERÍODO 2011/2012] - Ano Médio no RS
    -- Verão: Soja
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_rs_pampa, id_soja, id_sf11, ''2011-10-20'', 350.00, 1050.00, ''FINALIZADO'') RETURNING id INTO id_p_v1;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_v1, ''2012-03-05'', 1015.00, 13.50, 1.20, ''TIPO_1'');

    -- Inverno: Trigo (Rotação no mesmo talhão)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_rs_pampa, id_trigo, id_sf11, ''2012-06-05'', 350.00, 980.00, ''FINALIZADO'') RETURNING id INTO id_p_i1;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_i1, ''2012-10-28'', 950.00, 13.00, 1.80, ''TIPO_2'');


    -- [PERÍODO 2015/2016] - Ano Excelente no PR
    -- Verão: Milho de alta performance (Londrina Irrigado)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_pr_norte, id_milho, id_sf15, ''2015-09-15'', 450.00, 3800.00, ''FINALIZADO'') RETURNING id INTO id_p_v2;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_v2, ''2016-02-10'', 4100.00, 14.00, 0.50, ''TIPO_1'');

    -- Inverno: Cevada (Inserindo a nova cultura na rotação do PR)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_pr_norte, id_cevada, id_sf15, ''2016-05-20'', 450.00, 1600.00, ''FINALIZADO'') RETURNING id INTO id_p_i2;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_i2, ''2016-09-25'', 1720.00, 12.50, 0.80, ''TIPO_1'');


    -- [PERÍODO 2018/2019] - Introdução de Aveia no RS
    -- Verão: Soja
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_rs_missioes, id_soja, id_sf18, ''2018-11-01'', 500.00, 1650.00, ''FINALIZADO'') RETURNING id INTO id_p_v3;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_v3, ''2019-03-20'', 1710.00, 12.80, 0.90, ''TIPO_1'');

    -- Inverno: Aveia Preta (Cobertura e produção de grão)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_rs_missioes, id_aveia, id_sf18, ''2019-05-15'', 500.00, 1100.00, ''FINALIZADO'') RETURNING id INTO id_p_i3;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_i3, ''2019-09-12'', 1180.00, 13.00, 1.10, ''TIPO_1'');


    -- [PERÍODO 2021/2022] - A Grande Crise do Sul (La Niña Severa - Seca Extrema)
    -- Verão: Quebra drástica de Soja em sequeiro (Cascavel - PR)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_pr_pinhais, id_soja, id_sf21, ''2021-10-15'', 650.00, 2200.00, ''FINALIZADO'') RETURNING id INTO id_p_v4;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_v4, ''2022-03-02'', 920.00, 11.50, 6.50, ''TIPO_3''); -- Perda gigantesca de volume e qualidade ruim por estresse hídrico

    -- Inverno: Recuperação parcial com Trigo no inverno seguinte
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_pr_pinhais, id_trigo, id_sf21, ''2022-05-28'', 650.00, 1950.00, ''FINALIZADO'') RETURNING id INTO id_p_i4;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_i4, ''2022-10-15'', 1850.00, 13.20, 1.40, ''TIPO_1'');


    -- [PERÍODO 2024/2025] - Ano Excelente (Recuperação Completa do Mercado)
    -- Verão: Recorde de Soja no RS
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_rs_pampa, id_soja, id_sf24, ''2024-10-25'', 350.00, 1200.00, ''FINALIZADO'') RETURNING id INTO id_p_v5;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_v5, ''2025-03-10'', 1380.00, 12.60, 0.40, ''TIPO_1'');

    -- Inverno: Cevada de Maltearia de Alta Qualidade
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_rs_pampa, id_cevada, id_sf24, ''2025-06-02'', 350.00, 1100.00, ''FINALIZADO'') RETURNING id INTO id_p_i5;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_i5, ''2025-10-14'', 1210.00, 12.00, 0.60, ''TIPO_1'');


    -- [PERÍODO 2025/2026] - Safra Atual (Fechada recentemente em 2026)
    -- Verão: Soja no Norte do Paraná (Londrina)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_pr_norte, id_soja, id_sf25, ''2025-10-12'', 450.00, 1600.00, ''FINALIZADO'') RETURNING id INTO id_p_v6;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_v6, ''2026-02-22'', 1750.00, 12.90, 0.50, ''TIPO_1'');

END;
';