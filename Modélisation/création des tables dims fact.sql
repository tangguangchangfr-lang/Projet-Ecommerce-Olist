# création des tables dims et fact


CREATE TABLE dim_customers (
  
    customer_id VARCHAR(50) NOT NULL,
    customer_unique_id VARCHAR(50),
    customer_city VARCHAR(100),    
    customer_state CHAR(5),        
    customer_zip_code_prefix CHAR(5), 
  
    PRIMARY KEY (customer_id));
    
INSERT INTO dim_customers (customer_id, customer_unique_id, customer_city, customer_state, customer_zip_code_prefix)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state,
    customer_zip_code_prefix
FROM
    customers;
      
    
CREATE TABLE dim_geolocation (
    zip_code_prefix VARCHAR(5) NOT NULL,
    geolocation_lat DECIMAL(10, 6),
    geolocation_lng DECIMAL(10, 6),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(5),
    
    PRIMARY KEY (zip_code_prefix)
);

INSERT INTO dim_geolocation (
    zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
)
SELECT DISTINCT
    geolocation_zip_code_prefix AS zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM geolocalisation;


CREATE TABLE dim_products (
    product_id VARCHAR(50) NOT NULL,
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100),
    product_weight_g DECIMAL(10, 2),
    product_length_cm DECIMAL(10, 2),
    product_height_cm DECIMAL(10, 2),
    product_width_cm DECIMAL(10, 2),
    product_volume_cm3 DECIMAL(10, 2),

    PRIMARY KEY (product_id)
);

INSERT INTO dim_products (
    product_id,
    product_category_name,
    product_category_name_english,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    product_volume_cm3
)
SELECT DISTINCT
    p.product_id,
    p.product_category_name,
    c.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    p.product_volume_cm3
FROM products p
LEFT JOIN category c
    ON p.product_category_name = c.product_category_name;


CREATE TABLE dim_sellers (
  seller_id VARCHAR(50) PRIMARY KEY NOT NULL,
  seller_city VARCHAR(50),
  seller_state VARCHAR(50),
  seller_zip_code_prefix VARCHAR(5)
);

INSERT INTO dim_sellers (seller_id, seller_city, seller_state, seller_zip_code_prefix)
SELECT DISTINCT
    seller_id,
    seller_city,
    seller_state,
    seller_zip_code_prefix
FROM
    sellers;
    
 CREATE TABLE dim_review (
  review_key INT NOT NULL AUTO_INCREMENT,
  review_id VARCHAR(50) NOT NULL,
  order_id VARCHAR(50),
  review_score INT,
  result_concatenation_coms TEXT,
  review_creation_date DATETIME,
  review_answer_timestamp DATETIME,
  
  PRIMARY KEY (review_key)
);

INSERT INTO dim_review (
    review_id,
    order_id,
    review_score,
    result_concatenation_coms,
    review_creation_date,
    review_answer_timestamp
)
SELECT DISTINCT
    review_id,
    order_id,
    review_score,
    result_concatenation_coms,
    review_creation_date,
    review_answer_timestamp
FROM reviews;


DESCRIBE fact_orders
############
CREATE TABLE fact_orders (
    order_id              VARCHAR(50) NOT NULL,
    order_item_id         INT NOT NULL,
    customer_id           VARCHAR(50),
    seller_id             VARCHAR(50),
    product_id            VARCHAR(50),
    review_key            INT,
    purchase_date         DATETIME,
    expedition_date       DATETIME,
    delivery_date         DATETIME,
    estimated_delivery_date DATETIME,
    price                 DECIMAL(10,2),
    freight_value         DECIMAL(10,2),
    payment_value         DECIMAL(10,2),
    payment_type          VARCHAR(50),
    review_score          INT,
    delivery_delay_days   INT,
    delivery_time_days    INT,
    is_late_delivery      TINYINT(1),
    total_revenue         FLOAT,
    shipping_limit_date DATETIME,
    expedition_delay_days INT,
    total_delivery_days INT,
    seller_lat            DECIMAL(10,6),
    seller_lng            DECIMAL(10,6),
    customer_lat          DECIMAL(10,6),
    customer_lng          DECIMAL(10,6),
    
    
    CONSTRAINT PK_fact_orders PRIMARY KEY (order_id, order_item_id)
);

INSERT INTO fact_orders (
    order_id, order_item_id, customer_id, seller_id, product_id,
    purchase_date, expedition_date, delivery_date, estimated_delivery_date,
    shipping_limit_date, price, freight_value, payment_value, payment_type, review_key,
    review_score, delivery_delay_days, delivery_time_days,total_delivery_days, expedition_delay_days, is_late_delivery, 
    total_revenue, seller_lat, seller_lng, customer_lat, customer_lng
)
SELECT
    o.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.seller_id,
    oi.product_id,

    o.order_purchase_timestamp AS purchase_date,
    o.order_delivered_carrier_date AS expedition_date,
    o.order_delivered_customer_date AS delivery_date,
    o.order_estimated_delivery_date AS estimated_delivery_date,

    oi.shipping_limit_date,
    oi.price,
    oi.freight_value,

    p.payment_value,
    p.payment_type,

    r.review_key,
    r.review_score,

    DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS delivery_delay_days,
    DATEDIFF(o.order_delivered_customer_date, o.order_delivered_carrier_date) AS delivery_time_days,
    DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) AS total_delivery_days,
    DATEDIFF(o.order_delivered_carrier_date, oi.shipping_limit_date) AS expedition_delay_days,

    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END AS is_late_delivery,

    (oi.price + oi.freight_value) AS total_revenue,
    
    geo_seller.geolocation_lat  AS seller_lat,
    geo_seller.geolocation_lng  AS seller_lng,
    geo_customer.geolocation_lat AS customer_lat,
    geo_customer.geolocation_lng AS customer_lng
    
FROM
    orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id

JOIN sellers s
  ON oi.seller_id = s.seller_id

JOIN customers c
  ON o.customer_id = c.customer_id
  
LEFT JOIN (
    SELECT
        order_id,
        SUM(payment_value) AS payment_value,
        MAX(payment_type) AS payment_type
    FROM payments
    GROUP BY order_id
) p ON o.order_id = p.order_id

LEFT JOIN (
    SELECT
        review_key,
        AVG(review_score) AS review_score
    FROM reviews
    GROUP BY review_key
) r ON o.review_key = r.review_key


LEFT JOIN (
    SELECT zip_code_prefix, MAX(geolocation_lat) AS geolocation_lat, MAX(geolocation_lng) AS geolocation_lng
    FROM geolocalisation
    GROUP BY zip_code_prefix
) geo_seller
    ON geo_seller.zip_code_prefix = s.seller_zip_code_prefix
    
LEFT JOIN (
    SELECT zip_code_prefix, MAX(geolocation_lat) AS geolocation_lat, MAX(geolocation_lng) AS geolocation_lng
    FROM geolocalisation
    GROUP BY zip_code_prefix
) geo_customer
    ON geo_customer.zip_code_prefix = c.customer_zip_code_prefix
  
LEFT JOIN fact_orders f 
       ON f.order_id = o.order_id 
      AND f.order_item_id = oi.order_item_id
  
WHERE f.order_id IS NULL;

-- ajouter des clés étangères
ALTER TABLE fact_orders
ADD CONSTRAINT FK_fact_orders_customers
    FOREIGN KEY (customer_id)
    REFERENCES dim_customers(customer_id);

ALTER TABLE fact_orders
ADD CONSTRAINT FK_fact_orders_sellers
    FOREIGN KEY (seller_id)
    REFERENCES dim_sellers(seller_id);

ALTER TABLE fact_orders
ADD CONSTRAINT FK_fact_orders_products
    FOREIGN KEY (product_id)
    REFERENCES dim_products(product_id);


ALTER TABLE fact_orders
ADD CONSTRAINT FK_fact_orders_review
FOREIGN KEY (review_key) REFERENCES dim_review(review_key);