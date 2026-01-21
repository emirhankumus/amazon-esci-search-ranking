select
    example_id,
    query_id,
    product_id,
    product_locale,
    search_query,
    relevance_label,
    small_version,
    large_version
from {{ ref('stg_esci__examples') }}
where data_split = 'test'