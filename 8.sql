CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    external_id VARCHAR(50) UNIQUE,
    amount NUMERIC
);

INSERT INTO orders (external_id, amount) VALUES
('EXAMPLE1', 100),
('EXAMPLE2', 200),
('EXAMPLE3', 150);

CREATE UNIQUE INDEX external_id_index ON orders (external_id);
