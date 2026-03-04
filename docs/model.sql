-- =====================================================
-- DATABASE MODELING - PSICO-AGENDA EASY
-- Psychological Appointment Scheduling System
-- =====================================================
-- Users Table (Psychologists)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    birth_date DATE,
    phone VARCHAR(20),
    plan VARCHAR(50),
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
-- Clinics Table
CREATE TABLE clinics (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
-- Patients Table
CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    professional_id INT NOT NULL,
    clinic_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20) NOT NULL,
    birth_date DATE,
    cpf VARCHAR(14) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (professional_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Appointment Records Table
CREATE TABLE appointment_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    professional_id INT NOT NULL,
    observations TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (professional_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Appointments Table
CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    professional_id INT NOT NULL,
    clinic_id INT NOT NULL,
    appointment_record_id INT,
    date DATETIME NOT NULL,
    duration INT DEFAULT 50,
    status ENUM('scheduled', 'completed', 'cancelled', 'no_show') DEFAULT 'scheduled',
    paid BOOLEAN DEFAULT FALSE,
    session_value DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (professional_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (appointment_record_id) REFERENCES appointment_records(id) ON DELETE SET NULL ON UPDATE CASCADE
);
 
-- =====================================================
-- INDEXES
-- =====================================================
 
-- Users Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_deleted_at ON users(deleted_at);
CREATE INDEX idx_users_plan ON users(plan);
 
-- Clinics Indexes
CREATE INDEX idx_clinics_deleted_at ON clinics(deleted_at);
 
-- Patients Indexes
CREATE INDEX idx_patients_professional_id ON patients(professional_id);
CREATE INDEX idx_patients_clinic_id ON patients(clinic_id);
CREATE INDEX idx_patients_email ON patients(email);
CREATE INDEX idx_patients_cpf ON patients(cpf);
CREATE INDEX idx_patients_deleted_at ON patients(deleted_at);
 
-- Appointments Indexes
CREATE INDEX idx_appointments_patient_id ON appointments(patient_id);
CREATE INDEX idx_appointments_professional_id ON appointments(professional_id);
CREATE INDEX idx_appointments_clinic_id ON appointments(clinic_id);
CREATE INDEX idx_appointments_appointment_record_id ON appointments(appointment_record_id);
CREATE INDEX idx_appointments_date ON appointments(date);
CREATE INDEX idx_appointments_status ON appointments(status);
CREATE INDEX idx_appointments_deleted_at ON appointments(deleted_at);
CREATE INDEX idx_appointments_paid ON appointments(paid);
CREATE INDEX idx_appointments_professional_date ON appointments(professional_id, date);
CREATE INDEX idx_appointments_patient_date ON appointments(patient_id, date);
 
-- Appointment Records Indexes
CREATE INDEX idx_appointment_records_patient_id ON appointment_records(patient_id);
CREATE INDEX idx_appointment_records_professional_id ON appointment_records(professional_id);
CREATE INDEX idx_appointment_records_deleted_at ON appointment_records(deleted_at);