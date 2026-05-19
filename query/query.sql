

-- Query Especializada: Análise de Resiliência Climática e Impacto da Irrigação
-- Objetivo: Comparar a produtividade (ton/ha) entre fazendas irrigadas e sequeiro em anos de crise hídrica.


WITH metricas AS (
    SELECT
        f.nome AS fazenda,
        e.sigla AS estado,
        c.nome AS cultura,
        s.descricao AS safra,
        t.irrigado AS possui_irrigacao,
        p.area_plantada_ha AS area_ha,

        ROUND((ch.producao_real_ton / p.area_plantada_ha)::numeric, 2) AS produtividade_real_ton_ha,

        ROUND((p.produtividade_prevista_ton / p.area_plantada_ha)::numeric, 2) AS produtividade_prevista_ton_ha,

        ROUND(
            (((ch.producao_real_ton - p.produtividade_prevista_ton) / p.produtividade_prevista_ton) * 100)::numeric,
            2
        ) AS desvio_percentual,

        ch.qualidade_grao AS classificacao_qualidade

    FROM plantios p
    
    JOIN colheitas ch ON p.id = ch.plantio_id
    JOIN talhoes t     ON p.talhao_id = t.id
    JOIN fazendas f    ON t.fazenda_id = f.id
    JOIN estados e     ON f.estado_id = e.id
    JOIN culturas c    ON p.cultura_id = c.id
    JOIN safras s      ON p.safra_id = s.id

    WHERE
        (s.descricao = 'Safra 2014/2015' AND e.sigla = 'MG' AND c.nome = 'Milho')
        OR
        (s.descricao = 'Safra 2021/2022' AND e.sigla = 'PR' AND c.nome = 'Soja')
)

SELECT * FROM metricas
ORDER BY produtividade_real_ton_ha DESC;


---Query produtividade das safras---

WITH consolidado_culturas AS (
    SELECT 
        c.nome AS cultura,
        c.categoria,
        COUNT(p.id) AS total_ciclos_plantados,
        
        SUM(p.area_plantada_ha) AS area_total_identificada_ha,
        SUM(p.produtividade_prevista_ton) AS total_previsto_ton,
        SUM(ch.producao_real_ton) AS total_real_colhido_ton,
        
        ROUND((SUM(ch.producao_real_ton) / SUM(p.area_plantada_ha))::numeric, 2) AS media_produtividade_ton_ha,
        
        ROUND(((SUM(ch.producao_real_ton) / SUM(p.produtividade_prevista_ton)) * 100)::numeric, 2) AS percentual_atingimento_meta

    FROM culturas c

    JOIN plantios p   ON c.id = p.cultura_id
    JOIN colheitas ch ON p.id = ch.plantio_id

    GROUP BY 
        c.nome, 
        c.categoria
)

SELECT * FROM consolidado_culturas
ORDER BY total_real_colhido_ton DESC;