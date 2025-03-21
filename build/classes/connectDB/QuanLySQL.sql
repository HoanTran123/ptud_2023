-- MySQL: employee table

CREATE TABLE employee (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT '',
    type INT NOT NULL DEFAULT 0,
    sex INT NOT NULL DEFAULT 0,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(11) NOT NULL,
    address VARCHAR(255) NOT NULL,
    status INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (email)
);

-- MySQL: passenger table

CREATE TABLE passenger (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    sex INT NOT NULL DEFAULT 0,
    phone VARCHAR(10) NOT NULL,
    address VARCHAR(255) NOT NULL,
    identify_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (identify_number)
);

-- MySQL: payment table

CREATE TABLE payment (
    id INT NOT NULL AUTO_INCREMENT,
    status INT NOT NULL,
    type INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    passenger_id INT,
    PRIMARY KEY (id),
    UNIQUE KEY (passenger_id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(id)
);

-- MySQL: train table

CREATE TABLE train (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    `from` VARCHAR(100) NOT NULL,
    `to` VARCHAR(100) NOT NULL,
    time_run TIMESTAMP NOT NULL,
    carriage_count INT NOT NULL,
    type VARCHAR(100) NOT NULL,
    status INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    employee_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

-- MySQL: carriage table

CREATE TABLE carriage (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    seat_count INT NOT NULL,
    status INT NOT NULL DEFAULT 0,
    seat_row_count INT NOT NULL,
    row_count INT NOT NULL,
    type INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    train_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (train_id) REFERENCES train(id)
);

-- MySQL: orders table (renamed from "order" due to MySQL reserved keyword)

CREATE TABLE orders (
    id INT NOT NULL AUTO_INCREMENT,
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0,
    status INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    passenger_id INT,
    employee_id INT,
    payment_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (payment_id) REFERENCES payment(id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(id)
);

-- MySQL: seat table

CREATE TABLE seat (
    id INT NOT NULL AUTO_INCREMENT,
    type INT NOT NULL DEFAULT 0,
    status INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    carriage_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (carriage_id) REFERENCES carriage(id)
);

-- MySQL: ticket table

CREATE TABLE ticket (
    id INT NOT NULL AUTO_INCREMENT,
    code VARCHAR(255) NOT NULL,
    type INT NOT NULL,
    status INT NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    train_id INT,
    carriage_id INT,
    seat_id INT,
    PRIMARY KEY (id),
    UNIQUE KEY (seat_id),
    UNIQUE KEY (code),
    FOREIGN KEY (carriage_id) REFERENCES carriage(id),
    FOREIGN KEY (seat_id) REFERENCES seat(id),
    FOREIGN KEY (train_id) REFERENCES train(id)
);

-- MySQL: order_detail table

CREATE TABLE order_detail (
    id INT NOT NULL AUTO_INCREMENT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    passenger_id INT,
    order_id INT,
    ticket_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (ticket_id) REFERENCES ticket(id)
);
