
# Modélisation de la table orders
ALTER TABLE orders
MODIFY COLUMN order_id VARCHAR(50) NOT NULL,
MODIFY COLUMN customer_id VARCHAR(50) NOT NULL,
MODIFY COLUMN order_status VARCHAR(50),
MODIFY COLUMN order_purchase_timestamp DATETIME,
MODIFY COLUMN order_approved_at DATETIME,
MODIFY COLUMN order_delivered_carrier_date DATETIME,
MODIFY COLUMN order_delivered_customer_date DATETIME,
MODIFY COLUMN order_estimated_delivery_date DATETIME,
ADD COLUMN review_key INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (review_key),
ADD UNIQUE (order_id);

# Modélisation de la table sellers
ALTER TABLE sellers
MODIFY COLUMN seller_id VARCHAR(50) NOT NULL,
MODIFY COLUMN seller_zip_code_prefix VARCHAR(5),
MODIFY COLUMN seller_city VARCHAR(50),
MODIFY COLUMN seller_state VARCHAR(10),
ADD PRIMARY KEY (seller_id);

DESCRIBE sellers

# Modélisation de la table order_items
ALTER TABLE order_items
MODIFY COLUMN order_id VARCHAR(50) NOT NULL,
MODIFY COLUMN order_item_id INT NOT NULL,
MODIFY COLUMN product_id VARCHAR(50),
MODIFY COLUMN seller_id VARCHAR(50) NOT NULL,
MODIFY COLUMN shipping_limit_date DATETIME,
MODIFY COLUMN price DECIMAL(10,2),
MODIFY COLUMN freight_value DECIMAL(10,2),
ADD PRIMARY KEY (order_id, order_item_id);

DESCRIBE order_items

# Modélisation de la table payments
ALTER TABLE payments
MODIFY COLUMN order_id VARCHAR(50) NOT NULL,
MODIFY COLUMN payment_sequential INT,
MODIFY COLUMN payment_type VARCHAR(30),
MODIFY COLUMN payment_installments INT,
MODIFY COLUMN payment_value DECIMAL(10,2);

DESCRIBE payments

# Modélisation de la table products
ALTER TABLE products
MODIFY COLUMN product_id VARCHAR(50) NOT NULL,
MODIFY COLUMN product_category_name VARCHAR(100),
MODIFY COLUMN product_weight_g DECIMAL(10,2),
MODIFY COLUMN product_length_cm DECIMAL(10,2),
MODIFY COLUMN product_height_cm DECIMAL(10,2),
MODIFY COLUMN product_width_cm DECIMAL(10,2),
MODIFY COLUMN product_volume_cm3 DECIMAL(10,2),
ADD PRIMARY KEY (product_id);

DESCRIBE products

# Modélisation de la table reviews

ALTER TABLE reviews
MODIFY COLUMN review_id VARCHAR(50) NOT NULL,
MODIFY COLUMN order_id VARCHAR(50) NOT NULL,
MODIFY COLUMN review_score INT,
MODIFY COLUMN review_creation_date DATETIME,
MODIFY COLUMN review_answer_timestamp DATETIME,
ADD COLUMN review_key INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(review_key);

ALTER TABLE reviews 
RENAME COLUMN `result concatenation coms` TO `result_concatenation_coms`;

DESCRIBE reviews;

# Modélisation de la table customers

ALTER TABLE customers
MODIFY COLUMN customer_id VARCHAR(50) NOT NULL,
MODIFY COLUMN customer_unique_id VARCHAR(50),
MODIFY COLUMN customer_zip_code_prefix VARCHAR(5),
MODIFY COLUMN customer_city VARCHAR(100),
MODIFY COLUMN customer_state VARCHAR(5),
ADD PRIMARY KEY(customer_id);

# Modélisation de la table geolocalisation

ALTER TABLE geolocalisation
MODIFY COLUMN geolocation_zip_code_prefix VARCHAR(5) NOT NULL,
MODIFY COLUMN geolocation_lat DECIMAL(10,6),
MODIFY COLUMN geolocation_lng DECIMAL(10,6),
MODIFY COLUMN geolocation_city VARCHAR(100),
MODIFY COLUMN geolocation_state VARCHAR(5);


