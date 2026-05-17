DO '
DECLARE
    -- IDs dos Estados (Novos)
    id_sp UUID;
    id_mg UUID;
    id_es UUID;

    -- IDs das Culturas Existentes (Buscando do banco para evitar duplicidade)
    id_soja UUID;
    id_milho UUID;
    id_trigo UUID;

    -- IDs das Novas Culturas do Sudeste
    id_cana UUID;
    id_cafe_arabica UUID;
    id_cafe_conilon UUID;

    -- IDs das Safras Históricas
    id_sf13 UUID; id_sf14 UUID; id_sf15 UUID; id_sf18 UUID; id_sf20 UUID; id_sf21 UUID; id_sf24 UUID; id_sf25 UUID;

    -- IDs das Fazendas do Sudeste
    id_faz_ribeirao UUID;
    id_faz_itapeva UUID;
    id_faz_patrocinio UUID;
    id_faz_unai_pivo UUID;     -- << A FAZENDA SUPER PRODUTIVA CONSTANTE
    id_faz_linhares UUID;
    id_faz_sao_mateus UUID;

    -- IDs dos Talhões
    id_tal_sp_cana UUID;
    id_tal_sp_graos UUID;
    id_tal_mg_cafe UUID;
    id_tal_mg_super UUID;      -- << Talhão de recordes da fazenda super produtiva
    id_tal_es_conilon UUID;
    id_tal_es_milho UUID;

    -- IDs dos Plantios para amarração das colheitas
    id_p_sp1 UUID; id_p_sp2 UUID; id_p_mg1 UUID; id_p_mg2 UUID; id_p_es1 UUID; id_p_es2 UUID;
    id_p_super1 UUID; id_p_super2 UUID; id_p_super3 UUID;
BEGIN

    -- =========================================================
    -- 1. CADASTRO DOS ESTADOS (SUDESTE) - PROTEÇÃO CONTRA DUPLICIDADE
    -- =========================================================
    INSERT INTO estados (nome, sigla, regiao) VALUES (''São Paulo'', ''SP'', ''Sudeste'') ON CONFLICT (sigla) DO UPDATE SET nome = EXCLUDED.nome RETURNING id INTO id_sp;
    INSERT INTO estados (nome, sigla, regiao) VALUES (''Minas Gerais'', ''MG'', ''Sudeste'') ON CONFLICT (sigla) DO UPDATE SET nome = EXCLUDED.nome RETURNING id INTO id_mg;
    INSERT INTO estados (nome, sigla, regiao) VALUES (''Espírito Santo'', ''ES'', ''Sudeste'') ON CONFLICT (sigla) DO UPDATE SET nome = EXCLUDED.nome RETURNING id INTO id_es;


    -- =========================================================
    -- 2. RECUPERAÇÃO DE CULTURAS EXISTENTES E CADASTRO DAS NOVAS
    -- =========================================================
    SELECT id INTO id_soja FROM culturas WHERE nome = ''Soja'';
    SELECT id INTO id_milho FROM culturas WHERE nome = ''Milho'';

    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Cana-de-Açúcar'', ''Industrial'', 365) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_cana;
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Café Arábica'', ''Estimulantes'', 240) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_cafe_arabica;
    INSERT INTO culturas (nome, categoria, ciclo_medio_dias) VALUES (''Café Conilon'', ''Estimulantes'', 250) ON CONFLICT (nome) DO UPDATE SET categoria = EXCLUDED.categoria RETURNING id INTO id_cafe_conilon;


    -- =========================================================
    -- 3. RECUPERAÇÃO DOS IDs DAS SAFRAS COMPATÍVEIS COM O SEU HISTÓRICO
    -- =========================================================
    SELECT id INTO id_sf13 FROM safras WHERE descricao = ''Safra 2013/2014'';
    SELECT id INTO id_sf14 FROM safras WHERE descricao = ''Safra 2014/2015'';
    SELECT id INTO id_sf15 FROM safras WHERE descricao = ''Safra 2015/2016'';
    SELECT id INTO id_sf18 FROM safras WHERE descricao = ''Safra 2018/2019'';
    SELECT id INTO id_sf20 FROM safras WHERE descricao = ''Safra 2020/2021'';
    SELECT id INTO id_sf21 FROM safras WHERE descricao = ''Safra 2021/2022'';
    SELECT id INTO id_sf24 FROM safras WHERE descricao = ''Safra 2024/2025'';
    SELECT id INTO id_sf25 FROM safras WHERE descricao = ''Safra 2025/2026'';


    -- =========================================================
    -- 4. INVESTIMENTO AGROCOMPANY: CADASTRO DAS FAZENDAS (SUDESTE)
    -- =========================================================
    -- SÃO PAULO
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude) -- Corrigido de city para cidade aqui!
    VALUES (id_sp, ''Fazenda Vale do Sol'', ''Ribeirão Preto'', 2500.00, ''2006-05-14'', -21.1704, -47.8103) RETURNING id INTO id_faz_ribeirao;

    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_sp, ''Fazenda Alto Itapeva'', ''Itapeva'', 1800.00, ''2011-09-01'', -23.9812, -48.8765) RETURNING id INTO id_faz_itapeva;

    -- MINAS GERAIS
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_mg, ''Fazenda Cerrado Ouro'', ''Patrocínio'', 1100.00, ''2008-03-20'', -18.9421, -46.9942) RETURNING id INTO id_faz_patrocinio;

    -- [A LENDÁRIA] Fazenda Biotecnológica Unaí - Super Produtiva e Estável por uso de Pivô Central Inteligente e Solo Regenerado
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_mg, ''Fazenda Titã dos Pivôs'', ''Unaí'', 3200.00, ''2010-02-10'', -16.3575, -46.9061) RETURNING id INTO id_faz_unai_pivo;

    -- ESPÍRITO SANTO
    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_es, ''Fazenda Conilon Real'', ''Linhares'', 900.00, ''2012-07-19'', -19.3911, -40.0722) RETURNING id INTO id_faz_linhares;

    INSERT INTO fazendas (estado_id, nome, cidade, area_total_ha, data_aquisicao, latitude, longitude)
    VALUES (id_es, ''Fazenda Horizonte Capixaba'', ''São Mateus'', 750.00, ''2015-11-05'', -18.7161, -39.8601) RETURNING id INTO id_faz_sao_mateus;


    -- =========================================================
    -- 5. CADASTRO DOS TALHÕES
    -- =========================================================
    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_ribeirao, ''TALHAO_SP_CANA_01'', 1200.00, ''Terra Roxa'', 540.00, FALSE) RETURNING id INTO id_tal_sp_cana;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_itapeva, ''TALHAO_SP_GRAOS_01'', 800.00, ''Latossolo Vermelho'', 720.00, FALSE) RETURNING id INTO id_tal_sp_graos;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_patrocinio, ''TALHAO_MG_ARABICA_01'', 500.00, ''Argiloso Fértil'', 980.00, FALSE) RETURNING id INTO id_tal_mg_cafe;

    -- Talhão Super Produtivo (Alta Tecnologia de Irrigação e Nutrição Mineral de Solo)
    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_unai_pivo, ''PIVO_CENTRAL_SUPREMO_01'', 600.00, ''Latossolo Profundo'', 610.00, TRUE) RETURNING id INTO id_tal_mg_super;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_linhares, ''TALHAO_ES_CONILON_01'', 400.00, ''Arenoso Tratado'', 40.00, TRUE) RETURNING id INTO id_tal_es_conilon;

    INSERT INTO talhoes (fazenda_id, codigo, area_ha, tipo_solo, altitude_metros, irrigado)
    VALUES (id_faz_sao_mateus, ''TALHAO_ES_MILHO_01'', 350.00, ''Latossolo Amarelo'', 25.00, FALSE) RETURNING id INTO id_tal_es_milho;


    -- =========================================================
    -- 6. HISTÓRICO DE SAFRAS REGIONAIS (SUDESTE)
    -- =========================================================

    -- [CENÁRIO DE CRISE - SAFRA 2014/2015]: Grande Seca Histórica no Sudeste brasileiro
    -- Queda violenta na Cana-de-Açúcar em Ribeirão Preto (Sem Irrigação)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_sp_cana, id_cana, id_sf14, ''2014-04-10'', 1200.00, 96000.00, ''FINALIZADO'') RETURNING id INTO id_p_sp1;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_sp1, ''2015-05-18'', 68000.00, 68.00, 4.50, ''PADRAO_USINA''); -- Redução drástica devido ao estresse hídrico

    -- Bienalidade Negativa + Seca no Café Arábica do Cerrado Mineiro (2014/2015)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_mg_cafe, id_cafe_arabica, id_sf14, ''2014-05-20'', 500.00, 750.00, ''FINALIZADO'') RETURNING id INTO id_p_mg1;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_mg1, ''2015-08-10'', 480.00, 11.80, 2.80, ''TIPO_B_DURO'');


    -- [O COMPORTAMENTO DA FAZENDA LENDÁRIA DURANTE A CRISE (2014/2015)]
    -- Graças ao pivô central e tecnologia de solo, a fazenda atinge a meta máxima mesmo na pior seca
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_mg_super, id_milho, id_sf14, ''2014-10-02'', 600.00, 6000.00, ''FINALIZADO'') RETURNING id INTO id_p_super1;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_super1, ''2015-03-08'', 6350.00, 13.00, 0.20, ''TIPO_1_PREMIUM''); -- Produtividade absurda de 10.5 ton/ha fora do normal


    -- [CENÁRIO REGULAR / BIENALIDADE POSITIVA - SAFRA 2018/2019]
    -- Café Conilon no ES apresentando excelente volume com irrigação costeira
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_es_conilon, id_cafe_conilon, id_sf18, ''2018-06-01'', 400.00, 960.00, ''FINALIZADO'') RETURNING id INTO id_p_es1;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_es1, ''2019-07-15'', 1080.00, 12.00, 0.90, ''CONILON_TIPO_1'');


    -- [A FAZENDA LENDÁRIA CONTINUA QUEBRANDO RECORDES - SAFRA 2020/2021]
    -- Enquanto o país enfrentava problemas logísticos e flutuações, o pivô supremo manteve estabilidade total em Soja de Alta Densidade
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_mg_super, id_soja, id_sf20, ''2020-10-15'', 600.00, 2400.00, ''FINALIZADO'') RETURNING id INTO id_p_super2;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_super2, ''2021-02-28'', 2760.00, 12.50, 0.10, ''TIPO_1_PREMIUM''); -- Praticamente zero perdas


    -- [RECUPERAÇÃO E ESTABILIDADE MODERNA - SAFRA 2024/2025]
    -- Ótimo desempenho de Grãos no Sudoeste Paulista (Itapeva)
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_sp_graos, id_soja, id_sf24, ''2024-11-02'', 800.00, 2800.00, ''FINALIZADO'') RETURNING id INTO id_p_sp2;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_sp2, ''2025-03-14'', 3040.00, 13.00, 0.60, ''TIPO_1'');

    -- Café Arábica em MG em ano de Bienalidade Alta Recorde
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_mg_cafe, id_cafe_arabica, id_sf24, ''2024-05-10'', 500.00, 900.00, ''FINALIZADO'') RETURNING id INTO id_p_mg2;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_mg2, ''2025-08-22'', 1050.00, 11.50, 1.10, ''GOURMET_EXPORTACAO'');


    -- [SAFRA ATUAL CONSOLIDADA RECENTEMENTE - SAFRA 2025/2026]
    -- Safrinha de Milho Imbatível na Fazenda Lendária em 2026
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_mg_super, id_milho, id_sf25, ''2026-01-10'', 600.00, 6200.00, ''FINALIZADO'') RETURNING id INTO id_p_super3;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_super3, ''2026-05-05'', 6600.00, 13.20, 0.15, ''TIPO_1_PREMIUM'');

    -- Milho de sequeiro no Espírito Santo (São Mateus) enfrentando instabilidade de chuvas no início do ano
    INSERT INTO plantios (talhao_id, cultura_id, safra_id, data_plantio, area_plantada_ha, produtividade_prevista_ton, status_plantio)
    VALUES (id_tal_es_milho, id_milho, id_sf25, ''2025-11-20'', 350.00, 2100.00, ''FINALIZADO'') RETURNING id INTO id_p_es2;
    INSERT INTO colheitas (plantio_id, data_colheita, producao_real_ton, umidade_percentual, perda_percentual, qualidade_grao)
    VALUES (id_p_es2, ''2026-04-12'', 1820.00, 14.10, 3.20, ''TIPO_2'');

END;
';