use rushi;

INSERT INTO users(email, signup_date, country) VALUES 
('alie@gmail.com','2024-05-10','India'),
('bob@gmail.com','2024-06-15','USA'),
('carol@gmail.com','2024-07-20','UK');

INSERT INTO products (name, category, price) VALUES
('T-shirt', 'Apparel', 299.00),
('Coffee Mug', 'Home', 149.00),
('Notebook', 'Stationery', 99.00);

INSERT INTO orders (user_id, order_date, total_amount) VALUES
(1, '2025-01-05', 598.00),
(1, '2025-02-10', 149.00),
(2, '2025-02-11', 99.00),
(3, '2025-03-01', 299.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 299.00),
(2, 2, 1, 149.00),
(3, 3, 1, 99.00),
(4, 1, 1, 299.00);
