with source as (
    -- Kaynağı çağırıyoruz
    select * from {{ source('esci_raw', 'shopping_queries_examples') }}
),

cleaned as (
    select
        -- 1. Kimlik (ID) Sütunları (String'e çeviriyoruz)
        cast(example_id as string) as example_id,
        cast(query_id as string) as query_id,
        cast(product_id as string) as product_id,

        -- 2. Ana Metin Verileri
        coalesce(trim(query), 'Unknown Query') as search_query,
        trim(esci_label) as relevance_label,

        -- 3. Kategorik Veriler
        split as data_split,
        product_locale, -- EKLENDİ: Ülke/Dil bilgisi (Örn: us, jp)

        -- 4. Versiyon Bilgileri (Analizde lazım olabilir diye ekledik)
        small_version,
        large_version

        -- NOT: __index_level_0__ sütununu bilerek almadık, gereksiz.

    from source
)

select * from cleaned