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

CREATE INDEX order_id_index ON order_products (order_id);

SELECT * FROM order_products WHERE order_id = 1;