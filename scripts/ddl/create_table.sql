
-- =========================================================
-- EXTENSÃO PARA UUID
-- =========================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- =========================================================
-- TABELA: estados
-- =========================================================

CREATE TABLE estados (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    nome VARCHAR(100) NOT NULL,
    sigla CHAR(2) NOT NULL UNIQUE,

    regiao VARCHAR(20) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- TABELA: fazendas
-- =========================================================

CREATE TABLE fazendas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    estado_id UUID NOT NULL,

    nome VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,

    area_total_ha NUMERIC(12,2) NOT NULL,

    data_aquisicao DATE,

    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_fazenda_estado
        FOREIGN KEY (estado_id)
        REFERENCES estados(id)
);

-- =========================================================
-- TABELA: culturas
-- =========================================================

CREATE TABLE culturas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    nome VARCHAR(50) NOT NULL UNIQUE,

    categoria VARCHAR(50),

    ciclo_medio_dias INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- TABELA: safras
-- =========================================================

CREATE TABLE safras (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    ano_inicio INT NOT NULL,
    ano_fim INT NOT NULL,

    descricao VARCHAR(20) NOT NULL UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_safra_anos
        CHECK (ano_fim = ano_inicio + 1)
);

-- =========================================================
-- TABELA: talhoes
-- =========================================================

CREATE TABLE talhoes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    fazenda_id UUID NOT NULL,

    codigo VARCHAR(30) NOT NULL,

    area_ha NUMERIC(10,2) NOT NULL,

    tipo_solo VARCHAR(50),

    altitude_metros NUMERIC(8,2),

    irrigado BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_talhao_fazenda
        FOREIGN KEY (fazenda_id)
        REFERENCES fazendas(id),

    CONSTRAINT uq_talhao_codigo
        UNIQUE (fazenda_id, codigo)
);

-- =========================================================
-- TABELA: plantios
-- =========================================================

CREATE TABLE plantios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    talhao_id UUID NOT NULL,
    cultura_id UUID NOT NULL,
    safra_id UUID NOT NULL,

    data_plantio DATE NOT NULL,

    area_plantada_ha NUMERIC(10,2) NOT NULL,

    produtividade_prevista_ton NUMERIC(12,2),

    status_plantio VARCHAR(30) DEFAULT 'EM_ANDAMENTO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_plantio_talhao
        FOREIGN KEY (talhao_id)
        REFERENCES talhoes(id),

    CONSTRAINT fk_plantio_cultura
        FOREIGN KEY (cultura_id)
        REFERENCES culturas(id),

    CONSTRAINT fk_plantio_safra
        FOREIGN KEY (safra_id)
        REFERENCES safras(id),

    CONSTRAINT chk_area_plantada
        CHECK (area_plantada_ha > 0)
);

-- =========================================================
-- TABELA: colheitas
-- =========================================================

CREATE TABLE colheitas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    plantio_id UUID NOT NULL UNIQUE,

    data_colheita DATE NOT NULL,

    producao_real_ton NUMERIC(12,2) NOT NULL,

    umidade_percentual NUMERIC(5,2),

    perda_percentual NUMERIC(5,2),

    qualidade_grao VARCHAR(30),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_colheita_plantio
        FOREIGN KEY (plantio_id)
        REFERENCES plantios(id),

    CONSTRAINT chk_producao
        CHECK (producao_real_ton >= 0),

    CONSTRAINT chk_umidade
        CHECK (
            umidade_percentual >= 0
            AND umidade_percentual <= 100
        ),

    CONSTRAINT chk_perda
        CHECK (
            perda_percentual >= 0
            AND perda_percentual <= 100
        )
);