drop database amber;
create database amber;
use amber;
CREATE TABLE Company (
    company_code VARCHAR(50) PRIMARY KEY,
    founder VARCHAR(50)
);

CREATE TABLE Lead_Manager (
    lead_manager_code VARCHAR(50) PRIMARY KEY,
    company_code VARCHAR(50),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

CREATE TABLE Senior_Manager (
    senior_manager_code VARCHAR(50) PRIMARY KEY,
    lead_manager_code VARCHAR(50),
    company_code VARCHAR(50),
    FOREIGN KEY (lead_manager_code) REFERENCES Lead_Manager(lead_manager_code),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

CREATE TABLE Manager (
    manager_code VARCHAR(50) PRIMARY KEY,
    senior_manager_code VARCHAR(50),
    lead_manager_code VARCHAR(50),
    company_code VARCHAR(50),
    FOREIGN KEY (senior_manager_code) REFERENCES Senior_Manager(senior_manager_code),
    FOREIGN KEY (lead_manager_code) REFERENCES Lead_Manager(lead_manager_code),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

CREATE TABLE Empleado (
    employee_code VARCHAR(50) PRIMARY KEY,
    manager_code VARCHAR(50),
    senior_manager_code VARCHAR(50),
    lead_manager_code VARCHAR(50),
    company_code VARCHAR(50),
    FOREIGN KEY (manager_code) REFERENCES Manager(manager_code),
    FOREIGN KEY (senior_manager_code) REFERENCES Senior_Manager(senior_manager_code),
    FOREIGN KEY (lead_manager_code) REFERENCES Lead_Manager(lead_manager_code),
    FOREIGN KEY (company_code) REFERENCES Company(company_code)
);

-- Insertar datos en la tabla Company
INSERT INTO Company (company_code, founder) VALUES
('C1', 'Monika'),
('C2', 'Samantha'),

('C10', 'Carlos');

-- Insertar datos en la tabla Lead_Manager
INSERT INTO Lead_Manager (lead_manager_code, company_code) VALUES
('LM1', 'C1'),
('LM2', 'C2'),

('LM3', 'C10'); #1

-- Insertar datos en la tabla Senior_Manager
INSERT INTO Senior_Manager (senior_manager_code, lead_manager_code, company_code) VALUES
('SM1', 'LM1', 'C1'),
('SM2', 'LM1', 'C1'),
('SM3', 'LM2', 'C2'),

('SM4', 'LM3', 'C10'),
('SM5', 'LM3', 'C10');#2

-- Insertar datos en la tabla Manager
INSERT INTO Manager (manager_code, senior_manager_code, lead_manager_code, company_code) VALUES
('M1', 'SM1', 'LM1', 'C1'),
('M2', 'SM3', 'LM2', 'C2'),
('M3', 'SM3', 'LM2', 'C2'),

('M4', 'SM4', 'LM3', 'C10'),
('M5', 'SM5', 'LM3', 'C10'),
('M6', 'SM4', 'LM3', 'C10'),
('M7', 'SM5', 'LM3', 'C10');#4

-- Insertar datos en la tabla Empleado
INSERT INTO Empleado (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code) VALUES
('E1', 'M1', 'SM1', 'LM1', 'C1'),
('E2', 'M1', 'SM1', 'LM1', 'C1'),
('E3', 'M2', 'SM3', 'LM2', 'C2'),
('E4', 'M3', 'SM3', 'LM2', 'C2'),

('E5','M4', 'SM4', 'LM3', 'C10'),
('E6','M7', 'SM5', 'LM3', 'C10'),
('E7','M6', 'SM4', 'LM3', 'C10'),
('E8','M7', 'SM5', 'LM3', 'C10');#4
SELECT 
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS lead_manager,
    COUNT(DISTINCT sm.senior_manager_code) AS senior_manager,
    COUNT(DISTINCT m.manager_code) AS managers,
    COUNT(DISTINCT e.employee_code) AS employee
FROM 
    Company c
LEFT JOIN 
    Lead_Manager lm ON c.company_code = lm.company_code
LEFT JOIN 
    Senior_Manager sm ON lm.lead_manager_code = sm.lead_manager_code
LEFT JOIN 
    Manager m ON sm.senior_manager_code = m.senior_manager_code AND lm.lead_manager_code = m.lead_manager_code AND c.company_code = m.company_code
LEFT JOIN 
    Empleado e ON m.manager_code = e.manager_code AND m.senior_manager_code = e.senior_manager_code AND m.lead_manager_code = e.lead_manager_code AND c.company_code = e.company_code
GROUP BY 
    c.company_code, c.founder
ORDER BY 
    c.company_code;