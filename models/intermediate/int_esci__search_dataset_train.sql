select
    -- --- EXAMPLES ---
    e.example_id,
    e.query_id,
    e.search_query,
    e.relevance_label,
    e.product_locale,
    e.small_version,
    e.large_version,

    -- --- PRODUCTS ---
    p.product_id,
    p.product_title,
    p.product_brand,
    p.product_color,
    p.product_description,
    p.product_bullet_point,

    -- --- SOURCES ---
    s.device_source

from {{ ref('int_esci__examples_train') }} e

left join {{ ref('stg_esci__products') }} p
    on e.product_id = p.product_id
   and e.product_locale = p.product_locale

left join {{ ref('stg_esci__sources') }} s
    on e.query_id = s.query_id