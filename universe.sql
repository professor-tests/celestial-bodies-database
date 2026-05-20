-- تنظيف البيئة
DROP TABLE IF EXISTS moon CASCADE;
DROP TABLE IF EXISTS planet CASCADE;
DROP TABLE IF EXISTS star CASCADE;
DROP TABLE IF EXISTS galaxy CASCADE;
DROP TABLE IF EXISTS galaxy_type CASCADE;
--    إنشاء جدول المجرات
CREATE TABLE galaxy_type (
    galaxy_type_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    is_common BOOLEAN NOT NULL,
    average_mass_multiplier NUMERIC(5,2),
    discovered_year INT
);
--  إنشاء جدول المجرات 2
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    galaxy_type_id INT REFERENCES galaxy_type(galaxy_type_id) NOT NULL,
    name VARCHAR(100) UNIQUE NOT NULL,
    distance_from_earth_ly NUMERIC(15,2) NOT NULL,
    estimated_stars_billion INT NOT NULL,
    has_supermassive_black_hole BOOLEAN NOT NULL,
    diameter_light_years INT
);
--  إنشاء جدول النجوم
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
    name VARCHAR(100) UNIQUE NOT NULL,
    spectral_type VARCHAR(10) NOT NULL,
    surface_temperature_k INT NOT NULL,
    solar_masses NUMERIC(8,3) NOT NULL,
    has_exoplanets BOOLEAN NOT NULL
);
--  إنشاء جدول الكواكب
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    star_id INT REFERENCES star(star_id) NOT NULL,
    name VARCHAR(100) UNIQUE NOT NULL,
    orbital_period_days NUMERIC(10,2) NOT NULL,
    radius_km INT NOT NULL,
    is_habitable BOOLEAN NOT NULL,
    moons_count INT NOT NULL
);
--  إنشاء جدول الأقمار
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    planet_id INT REFERENCES planet(planet_id) NOT NULL,
    name VARCHAR(100) UNIQUE NOT NULL,
    radius_km INT NOT NULL,
    orbital_period_days NUMERIC(10,2) NOT NULL,
    has_atmosphere BOOLEAN NOT NULL,
    discovery_year INT
);

-- ============================================================================

-- إدخال بيانات جدول أنواع المجرات 
INSERT INTO galaxy_type (name, description, is_common, average_mass_multiplier, discovered_year) VALUES
('Spiral', 'Galaxies with flat, rotating disks and spiral arms', true, 1.00, 1926),
('Elliptical', 'Smooth, nearly featureless images and elliptical shape', true, 5.50, 1926),
('Irregular', 'Galaxies without a distinct regular shape', false, 0.25, 1930);

-- إدخال بيانات جدول المجرات 2
INSERT INTO galaxy (galaxy_type_id, name, distance_from_earth_ly, estimated_stars_billion, has_supermassive_black_hole, diameter_light_years) VALUES
(1, 'Milky Way', 0.00, 400, true, 100000),
(1, 'Andromeda', 2537000.00, 1000, true, 220000),
(1, 'Triangulum', 2730000.00, 40, false, 60000),
(3, 'Large Magellanic Cloud', 163000.00, 30, false, 14000),
(2, 'Messier 87', 53490000.00, 12000, true, 120000),
(1, 'Sombrero Galaxy', 29350000.00, 800, true, 50000);

-- إدخال بيانات جدول النجوم 
INSERT INTO star (galaxy_id, name, spectral_type, surface_temperature_k, solar_masses, has_exoplanets) VALUES
(1, 'Sun', 'G2V', 5778, 1.000, true),
(1, 'Proxima Centauri', 'M5.5Vc', 3042, 0.122, true),
(1, 'Sirius A', 'A1V', 9940, 2.063, false),
(1, 'Kepler-11', 'G6V', 5680, 0.954, true),
(1, 'TRAPPIST-1', 'M8V', 2566, 0.089, true),
(2, 'Andromeda Alpha', 'B8IV', 13800, 3.600, false);

-- إدخال بيانات جدول الكواكب 
INSERT INTO planet (star_id, name, orbital_period_days, radius_km, is_habitable, moons_count) VALUES
(1, 'Mercury', 87.97, 2439, false, 0),
(1, 'Venus', 224.70, 6051, false, 0),
(1, 'Earth', 365.25, 6371, true, 1),
(1, 'Mars', 686.98, 3389, false, 2),
(1, 'Jupiter', 4332.59, 69911, false, 95),
(1, 'Saturn', 10759.22, 58232, false, 146),
(2, 'Proxima Centauri b', 11.18, 6500, true, 0),
(4, 'Kepler-11b', 10.30, 12500, false, 0),
(4, 'Kepler-11c', 13.02, 20000, false, 0),
(5, 'TRAPPIST-1b', 1.51, 7140, false, 0),
(5, 'TRAPPIST-1c', 2.42, 7010, false, 0),
(5, 'TRAPPIST-1d', 4.05, 5000, true, 0);

-- إدخال بيانات جدول الأقمار
INSERT INTO moon (planet_id, name, radius_km, orbital_period_days, has_atmosphere, discovery_year) VALUES
(3, 'Moon', 1737, 27.32, false, NULL),
(4, 'Phobos', 11, 0.32, false, 1877),
(4, 'Deimos', 6, 1.26, false, 1877),
(5, 'Io', 1821, 1.77, true, 1610),
(5, 'Europa', 1560, 3.55, true, 1610),
(5, 'Ganymede', 2634, 7.15, true, 1610),
(5, 'Callisto', 2410, 16.69, true, 1610),
(6, 'Mimas', 198, 0.94, false, 1789),
(6, 'Enceladus', 252, 1.37, true, 1789),
(6, 'Tethys', 531, 1.89, false, 1684),
(6, 'Dione', 561, 2.74, false, 1684),
(6, 'Rhea', 763, 4.52, false, 1672),
(6, 'Titan', 2574, 15.95, true, 1655),
(6, 'Hyperion', 135, 21.28, false, 1848),
(6, 'Iapetus', 734, 79.33, false, 1671),
(6, 'Phoebe', 106, 550.30, false, 1898),
(6, 'Janus', 89, 0.69, false, 1966),
(6, 'Epimetheus', 58, 0.69, false, 1966),
(6, 'Prometheus', 43, 0.61, false, 1980),
(6, 'Pandora', 40, 0.63, false, 1980);
