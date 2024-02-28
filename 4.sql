CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    amount NUMERIC
);


CREATE TABLE order_products (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price NUMERIC,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO orders (id, amount) VALUES
(1, 0), (2, 0), (3, 0);

INSERT INTO order_products (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 10), 
(1, 2, 1, 20), 
(2, 3, 3, 15); 

CREATE OR REPLACE FUNCTION calculate_average_price()
RETURNS NUMERIC AS $$
DECLARE
    avg_price NUMERIC;
BEGIN
    SELECT AVG(price) INTO avg_price
    FROM order_products;
    RETURN avg_price;
END;
$$ LANGUAGE plpgsql;
