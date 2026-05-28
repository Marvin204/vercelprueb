-- =========================
-- BASE DE DATOS
-- =========================
CREATE DATABASE IF NOT EXISTS sistema_rrhh;
USE sistema_rrhh;

-- =========================
-- EMPLEADOS
-- =========================
CREATE TABLE empleados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  dpi VARCHAR(20),
  estado VARCHAR(20) DEFAULT 'activo'
);

-- =========================
-- NÓMINA (ENCABEZADO)
-- =========================
CREATE TABLE nomina (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tipo_periodo VARCHAR(50),
  periodo VARCHAR(50),
  fecha_inicio DATE,
  fecha_fin DATE,
  estado VARCHAR(20) DEFAULT 'abierta',
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- DETALLE NÓMINA
-- =========================
CREATE TABLE detalle_nomina (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT,
  nomina_id INT,
  salario_base DECIMAL(10,2) DEFAULT 0,
  horas_extra DECIMAL(10,2) DEFAULT 0,
  bonificaciones DECIMAL(10,2) DEFAULT 0,
  deducciones DECIMAL(10,2) DEFAULT 0,
  salario_final DECIMAL(10,2) DEFAULT 0,

  FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE,
  FOREIGN KEY (nomina_id) REFERENCES nomina(id) ON DELETE CASCADE
);

-- =========================
-- DOCUMENTOS (EXPEDIENTE)
-- =========================
CREATE TABLE documentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT,
  tipo_documento VARCHAR(50),
  ruta VARCHAR(255),

  FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE
);

-- =========================
-- ESTADO EXPEDIENTE
-- =========================
CREATE TABLE estado_expediente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT,
  estado VARCHAR(50),

  FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE
);

-- =========================
-- REGISTRO ACADÉMICO
-- =========================
CREATE TABLE registro_academico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT,
  titulo VARCHAR(150),
  institucion VARCHAR(150),
  fecha_graduacion DATE,

  FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE
);

-- =========================
-- ÍNDICES (OPTIMIZACIÓN)
-- =========================
CREATE INDEX idx_detalle_nomina_nomina ON detalle_nomina(nomina_id);
CREATE INDEX idx_detalle_nomina_empleado ON detalle_nomina(empleado_id);
CREATE INDEX idx_documentos_empleado ON documentos(empleado_id);
CREATE INDEX idx_academico_empleado ON registro_academico(empleado_id);