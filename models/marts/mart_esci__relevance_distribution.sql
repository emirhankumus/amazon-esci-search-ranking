select
    relevance_label,
    count(*) as total_results,
    round(
        100 * count(*) / sum(count(*)) over (),
        2
    ) as percentage
from {{ ref('fct_esci_search_ranking') }}
group by relevance_label