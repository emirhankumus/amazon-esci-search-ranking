with source as (
    select * from {{ source('esci_raw', 'shopping_queries_products') }}
),

cleaned as (
    select
        -- 1. Kimlik
        cast(product_id as string) as product_id,
        
        -- 2. Temel Bilgiler
        coalesce(product_title, 'Unnamed Product') as product_title,
        product_brand,
        product_color,
        
        -- 3. Detaylı Metinler (Analizde NLP yapmak istersen lazım olur)
        product_description,
        product_bullet_point,
        
        -- 4. Lokasyon Bilgisi (EKSİKTİ, EKLENDİ)
        -- Ürünün hangi pazar yerinde olduğu (örn: us, es, jp)
        product_locale

    from source
)

select * from cleaned