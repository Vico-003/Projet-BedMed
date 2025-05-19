
-- Création de la base de données
DROP DATABASE IF EXISTS bedmed;
CREATE DATABASE bedmed;
USE bedmed;

-- Table Admin (Suppression du champ rôle)
CREATE TABLE Admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifiant VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
);

-- Table Soignant (Ajout de la gestion des horaires via une table emploi_temps)
CREATE TABLE Soignant (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifiant VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    nom VARCHAR(100),
    prenom VARCHAR(100)
);

-- Table Emploi du Temps pour gérer les horaires des soignants
CREATE TABLE Emploi_Temps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_soignant INT NOT NULL,
    jour VARCHAR(20) NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    FOREIGN KEY (id_soignant) REFERENCES Soignant(id)
);

-- Table Patient
CREATE TABLE Patient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifiant VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    historique TEXT
);

-- Table Chambre (Ajout de l'étage)
CREATE TABLE Chambre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    etage INT NOT NULL,
    humidite FLOAT,
    temperature FLOAT
);

-- Table Lit
CREATE TABLE Lit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    position VARCHAR(100),
    confort VARCHAR(100),
    id_chambre INT,
    id_patient INT,
    FOREIGN KEY (id_chambre) REFERENCES Chambre(id),
    FOREIGN KEY (id_patient) REFERENCES Patient(id)
);

-- Table Equipement
CREATE TABLE Equipement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100),
    etat VARCHAR(100)
);

-- Table Appel
CREATE TABLE Appel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    statut VARCHAR(100),
    id_patient INT,
    id_soignant INT,
    FOREIGN KEY (id_patient) REFERENCES Patient(id),
    FOREIGN KEY (id_soignant) REFERENCES Soignant(id)
);

-- Ajout de trois comptes Admin (Sans rôle)
INSERT INTO Admin (identifiant, mot_de_passe) VALUES 
('admin1', '$2b$12$4oKJNm9vQxmmxsvii/FQ9OjpQu5xwmDrH/PGBuFpYqn.elc0s5k/e'),
('admin2', '$2b$12$g43Nk8wwxKCNhjJup.ur3.5TJrtlpeDghPdopWbcIS7PAXQnhNd/2'),
('admin3', '$2b$12$s1bqP7A0TNkb4K03Et3DQe/xMSWA3Qw.GjXQZo6b5ZIUjOmI3Ndui');

-- Ajout de trois comptes Soignant
INSERT INTO Soignant (identifiant, mot_de_passe, nom, prenom) VALUES 
('soignant1', '$2b$12$wmrZ8j78dtJHXWV5WJbjH.wggPNN9qA4GfUjvYPfkL1pxB5qgFPJu', 'Dupont', 'Jean'),
('soignant2', '$2b$12$ISQu6oK3o46jHK4YpS2I0uV51Wl7vI0QNpDgOZO7erymTpYUiobmK', 'Morel', 'Sophie'),
('soignant3', '$2b$12$rO7Sy04H4JQ2MOyEUjzMSuog0LIQxHkt6LG0Er9.twABIS9pCAqna', 'Durand', 'Marc');

-- Ajout des horaires des soignants dans Emploi_Temps
INSERT INTO Emploi_Temps (id_soignant, jour, heure_debut, heure_fin) VALUES 
(1, 'Lundi', '08:00:00', '16:00:00'),
(1, 'Mardi', '08:00:00', '16:00:00'),
(2, 'Mercredi', '10:00:00', '18:00:00'),
(2, 'Jeudi', '10:00:00', '18:00:00'),
(3, 'Vendredi', '07:00:00', '15:00:00'),
(3, 'Samedi', '07:00:00', '15:00:00');

-- Ajout de trois comptes Patient
INSERT INTO Patient (identifiant, mot_de_passe, nom, prenom, historique) VALUES 
('patient1', '$2b$12$5eqrxaJIy950B.rjHLhI0uvXgNizyqXkoSsWn6NrSbSK8uldgI1Ri', 'Martin', 'Alice', 'Aucun antécédent'),
('patient2', '$2b$12$O9lOyjBw15C3yyNzHN61iurI9Obh/M/c9IMVbhy9NQxdKHu/5.2Mu', 'Bernard', 'Lucas', 'Allergies'),
('patient3', '$2b$12$uPv/pUQ4FW0bC5i.SWhmYed0jljykWJOsX9eQaAwtbCFiZ/fQrTti', 'Lemoine', 'Emma', 'Diabète type 1');

-- Ajout de trois chambres avec étages
INSERT INTO Chambre (numero, etage, humidite, temperature) VALUES 
(101, 1, 50.5, 22.0),
(202, 2, 48.3, 21.5),
(303, 3, 49.8, 23.0);

-- Ajout de trois lits
INSERT INTO Lit (position, confort, id_chambre, id_patient) VALUES 
('Haut', 'Standard', 1, 1),
('Bas', 'Confort', 2, 2),
('Moyen', 'Luxe', 3, 3);

-- Ajout de trois équipements
INSERT INTO Equipement (type, etat) VALUES 
('Respirateur', 'Fonctionnel'),
('Monitor Cardiaque', 'En Réparation'),
('Perfusion', 'Fonctionnel');

-- Ajout de trois appels
INSERT INTO Appel (date, statut, id_patient, id_soignant) VALUES 
(NOW(), 'Urgence', 1, 1),
(NOW(), 'Rappel', 2, 2),
(NOW(), 'Consultation', 3, 3);
