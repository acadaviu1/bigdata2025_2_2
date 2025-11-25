-- Seleccionar el catálogo
CREATE CATALOG IF NOT EXISTS global_real_estate;
USE CATALOG global_real_estate;

-- =====================================================
-- Schema: propiedades (Detalles físicos del inmueble)
-- =====================================================
CREATE SCHEMA IF NOT EXISTS propiedades_schema;

-- Tabla propiedad
CREATE TABLE IF NOT EXISTS propiedades_schema.tbl_propiedad (
    id_propiedad STRING NOT NULL,  -- Mapeado de 'property_id'
    tipo_propiedad STRING,         -- 'property_type'
    estado_muebles STRING,         -- 'furnishing_status'
    tamano_pies_cdros INT,         -- 'property_size_sqft'
    ano_construccion INT,          -- 'constructed_year'
    habitaciones INT,              -- 'rooms'
    banos INT,                     -- 'bathrooms'
    tiene_garaje INT,              -- 'garage' (1 o 0)
    tiene_jardin INT,              -- 'garden' (1 o 0)
    duenos_previos INT,            -- 'previous_owners'
    PRIMARY KEY (id_propiedad)
);

-- =====================================================
-- Schema: ubicacion (Datos geográficos y del entorno)
-- =====================================================
CREATE SCHEMA IF NOT EXISTS ubicacion_schema;

-- Tabla entorno
-- Nota: Dado que el CSV es plano, usamos id_propiedad como enlace 1:1
CREATE TABLE IF NOT EXISTS ubicacion_schema.tbl_entorno (
    id_entorno STRING NOT NULL,    -- Se puede usar el mismo 'property_id'
    pais STRING,                   -- 'country'
    ciudad STRING,                 -- 'city'
    casos_crimenes INT,            -- 'crime_cases_reported'
    casos_legales INT,             -- 'legal_cases_on_property'
    rating_vecindario INT,         -- 'neighbourhood_rating'
    puntaje_conectividad INT,      -- 'connectivity_score'
    PRIMARY KEY (id_entorno)
);

-- =====================================================
-- Schema: finanzas (Perfil financiero del solicitante)
-- =====================================================
CREATE SCHEMA IF NOT EXISTS finanzas_schema;

-- Tabla perfil_financiero
CREATE TABLE IF NOT EXISTS finanzas_schema.tbl_perfil_financiero (
    id_solicitud STRING NOT NULL,  -- Se puede usar el mismo 'property_id' o generar nuevo
    salario_cliente INT,           -- 'customer_salary'
    monto_prestamo INT,            -- 'loan_amount'
    anos_prestamo INT,             -- 'loan_tenure_years'
    gastos_mensuales INT,          -- 'monthly_expenses'
    pago_inicial INT,              -- 'down_payment'
    ratio_emi_ingreso DOUBLE,      -- 'emi_to_income_ratio'
    PRIMARY KEY (id_solicitud)
);

-- =====================================================
-- Schema: transacciones (Tabla de hechos / Decisiones)
-- =====================================================
CREATE SCHEMA IF NOT EXISTS transacciones_schema;

-- Tabla evaluacion_compra
CREATE TABLE IF NOT EXISTS transacciones_schema.tbl_evaluacion_compra (
    id_transaccion STRING NOT NULL,
    id_propiedad STRING,
    id_entorno STRING,
    id_solicitud STRING,
    precio DOUBLE,                 -- 'price'
    puntaje_satisfaccion INT,      -- 'satisfaction_score'
    decision_compra INT,           -- 'decision' (Target variable: 0 o 1)
    
    PRIMARY KEY (id_transaccion),
    
    -- Relaciones (Foreign Keys)
    FOREIGN KEY (id_propiedad) REFERENCES propiedades_schema.tbl_propiedad(id_propiedad),
    FOREIGN KEY (id_entorno) REFERENCES ubicacion_schema.tbl_entorno(id_entorno),
    FOREIGN KEY (id_solicitud) REFERENCES finanzas_schema.tbl_perfil_financiero(id_solicitud)
);