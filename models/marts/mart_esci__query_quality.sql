select
    search_query,
    count(*) as total_results,
    sum(case when relevance_label = 'Exact' then 1 else 0 end) as exact_count,
    round(
        100 * sum(case when relevance_label = 'Exact' then 1 else 0 end) / count(*),
        2
    ) as exact_ratio
from {{ ref('fct_esci_search_ranking') }}
group by search_query