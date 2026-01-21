select
    -- Kimlikler
    example_id,
    query_id,
    product_id,

    -- Arama
    search_query,
    relevance_label,

    -- Ürün
    product_title,
    product_brand,
    product_color,
    product_description,
    product_bullet_point,

    -- Kontekst
    product_locale,
    device_source,

    -- Versiyonlama
    small_version,
    large_version

from {{ ref('int_esci__search_dataset_train') }}