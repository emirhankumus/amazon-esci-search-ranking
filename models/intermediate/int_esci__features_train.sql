select
    *,
    length(search_query) as query_length,
    length(product_title) as title_length,

    array_length(
        array(
            select word
            from unnest(split(lower(search_query), ' ')) word
            intersect distinct
            select word
            from unnest(split(lower(product_title), ' ')) word
        )
    ) as query_title_overlap

from {{ ref('int_esci__search_dataset_train') }}