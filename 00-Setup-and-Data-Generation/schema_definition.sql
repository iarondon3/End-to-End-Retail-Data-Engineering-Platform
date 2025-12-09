-- Main Tables (No Foreign Keys)
CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE Branch (
    branch_id SERIAL PRIMARY KEY,
    country VARCHAR(100),
    state VARCHAR(100),
    city VARCHAR(100),
    street VARCHAR(255),
    phone VARCHAR(50), -- Changed to 50 based on previous fix
    active BOOLEAN
);

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    country VARCHAR(100),
    state VARCHAR(100),
    city VARCHAR(100),
    street VARCHAR(255),
    is_member BOOLEAN,
    phone VARCHAR(50), -- Changed to 50
    points_available INT
);

CREATE TABLE Coupon (
    coupon_id SERIAL PRIMARY KEY,
    code VARCHAR(50),
    type VARCHAR(50),
    value INT,
    min_purchase INT,
    max_usage_global INT,
    max_usage_customer INT,
    valid_from DATE,
    valid_until DATE,
    status VARCHAR(50),
    description VARCHAR(255)
);

CREATE TABLE Payment_Method (
    payment_method_id SERIAL PRIMARY KEY,
    method VARCHAR(100),
    active BOOLEAN
);

-- Dependent Tables (With Foreign Keys)
CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    category_id INT REFERENCES Category(category_id),
    name VARCHAR(255),
    description VARCHAR(255),
    brand VARCHAR(100),
    unit_price FLOAT,
    stock INT,
    active BOOLEAN
);

CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    branch_id INT REFERENCES Branch(branch_id),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    country VARCHAR(100),
    state VARCHAR(100),
    city VARCHAR(100),
    street VARCHAR(255),
    phone VARCHAR(50), -- Changed to 50
    position VARCHAR(100),
    active BOOLEAN
);

CREATE TABLE Sale (
    sale_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES Employee(employee_id),
    customer_id INT REFERENCES Customer(customer_id),
    branch_id INT REFERENCES Branch(branch_id),
    date DATE,
    channel VARCHAR(100),
    points_generated INT
);

CREATE TABLE Sale_Detail (
    detail_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES Product(product_id),
    sale_id INT REFERENCES Sale(sale_id),
    quantity INT
);

CREATE TABLE Redeemed_Coupon (
    redemption_id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES Sale(sale_id),
    coupon_id INT REFERENCES Coupon(coupon_id),
    amount FLOAT
);

CREATE TABLE Invoice (
    invoice_id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES Sale(sale_id)
);

CREATE TABLE Invoice_Detail (
    invoice_detail_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES Invoice(invoice_id),
    payment_method_id INT REFERENCES Payment_Method(payment_method_id),
    payment_date DATE,
    subtotal FLOAT,
    tax FLOAT,
    total FLOAT,
    discount FLOAT
);

CREATE TABLE Points_Movement (
    movement_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer(customer_id),
    sale_id INT REFERENCES Sale(sale_id),
    points INT
);
