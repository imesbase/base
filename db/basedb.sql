-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 25 avr. 2019 à 09:46
-- Version du serveur :  5.7.19
-- Version de PHP :  5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `basedb`
--

-- --------------------------------------------------------

--
-- Structure de la table `abscence`
--

DROP TABLE IF EXISTS `abscence`;
CREATE TABLE IF NOT EXISTS `abscence` (
  `seance_idseance` int(11) NOT NULL,
  `eleve_ideleve` int(11) NOT NULL,
  `justificatif` enum('oui','non') NOT NULL,
  `observation` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`seance_idseance`,`eleve_ideleve`),
  KEY `fk_seance_has_eleve_eleve1_idx` (`eleve_ideleve`),
  KEY `fk_seance_has_eleve_seance1_idx` (`seance_idseance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `eleve`
--

DROP TABLE IF EXISTS `eleve`;
CREATE TABLE IF NOT EXISTS `eleve` (
  `ideleve` int(11) NOT NULL AUTO_INCREMENT,
  `matricule` varchar(45) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `date_naiss` date NOT NULL,
  `nationalite` varchar(45) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `email` varchar(75) NOT NULL,
  `CNI_passeport` varchar(45) NOT NULL,
  PRIMARY KEY (`ideleve`),
  UNIQUE KEY `matricule_UNIQUE` (`matricule`),
  UNIQUE KEY `ideleve_UNIQUE` (`ideleve`),
  UNIQUE KEY `CNI_passeport_UNIQUE` (`CNI_passeport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `eleve_has_evaluation`
--

DROP TABLE IF EXISTS `eleve_has_evaluation`;
CREATE TABLE IF NOT EXISTS `eleve_has_evaluation` (
  `eleve_ideleve` int(11) NOT NULL,
  `evaluation_idevaluation` int(11) NOT NULL,
  `note` float DEFAULT NULL,
  PRIMARY KEY (`eleve_ideleve`,`evaluation_idevaluation`),
  KEY `fk_eleve_has_evaluation_evaluation1_idx` (`evaluation_idevaluation`),
  KEY `fk_eleve_has_evaluation_eleve1_idx` (`eleve_ideleve`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
CREATE TABLE IF NOT EXISTS `evaluation` (
  `idevaluation` int(11) NOT NULL AUTO_INCREMENT,
  `jour` datetime NOT NULL,
  `sujet` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `coef` double NOT NULL,
  PRIMARY KEY (`idevaluation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `evaluation_has_surveillant`
--

DROP TABLE IF EXISTS `evaluation_has_surveillant`;
CREATE TABLE IF NOT EXISTS `evaluation_has_surveillant` (
  `evaluation_idevaluation` int(11) NOT NULL,
  `surveillant_idsurveillant` int(11) NOT NULL,
  PRIMARY KEY (`evaluation_idevaluation`,`surveillant_idsurveillant`),
  KEY `fk_evaluation_has_surveillant_surveillant1_idx` (`surveillant_idsurveillant`),
  KEY `fk_evaluation_has_surveillant_evaluation1_idx` (`evaluation_idevaluation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
CREATE TABLE IF NOT EXISTS `groupe` (
  `idgroupe` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `annee_scolaire` varchar(9) NOT NULL,
  `semestre` varchar(45) NOT NULL,
  PRIMARY KEY (`idgroupe`),
  UNIQUE KEY `idgroupe_UNIQUE` (`idgroupe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `inscription`
--

DROP TABLE IF EXISTS `inscription`;
CREATE TABLE IF NOT EXISTS `inscription` (
  `eleve_ideleve` int(11) NOT NULL,
  `groupe_idgroupe` int(11) NOT NULL,
  PRIMARY KEY (`eleve_ideleve`,`groupe_idgroupe`),
  KEY `fk_eleve_has_groupe_groupe1_idx` (`groupe_idgroupe`),
  KEY `fk_eleve_has_groupe_eleve1_idx` (`eleve_ideleve`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

DROP TABLE IF EXISTS `matiere`;
CREATE TABLE IF NOT EXISTS `matiere` (
  `idmatiere` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `syllabus` varchar(45) DEFAULT NULL,
  `coefficient` float NOT NULL,
  PRIMARY KEY (`idmatiere`),
  UNIQUE KEY `idmatiere_UNIQUE` (`idmatiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `matiere_has_groupe`
--

DROP TABLE IF EXISTS `matiere_has_groupe`;
CREATE TABLE IF NOT EXISTS `matiere_has_groupe` (
  `matiere_idmatiere` int(11) NOT NULL,
  `groupe_idgroupe` int(11) NOT NULL,
  `prof_idprof` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`matiere_idmatiere`,`groupe_idgroupe`,`prof_idprof`),
  KEY `fk_matiere_has_groupe_groupe1_idx` (`groupe_idgroupe`),
  KEY `fk_matiere_has_groupe_matiere1_idx` (`matiere_idmatiere`),
  KEY `fk_matiere_has_groupe_prof1_idx` (`prof_idprof`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `prof`
--

DROP TABLE IF EXISTS `prof`;
CREATE TABLE IF NOT EXISTS `prof` (
  `idprof` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `prenom` varchar(45) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `date_naiss` date NOT NULL,
  `CNI_passeport` varchar(45) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `fonction_niveau` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idprof`),
  UNIQUE KEY `CIN_Passeport_UNIQUE` (`CNI_passeport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

DROP TABLE IF EXISTS `seance`;
CREATE TABLE IF NOT EXISTS `seance` (
  `idseance` int(11) NOT NULL,
  `date_heure` datetime NOT NULL,
  `salle` varchar(45) NOT NULL,
  `observation` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idseance`),
  UNIQUE KEY `idseance_UNIQUE` (`idseance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `surveillant`
--

DROP TABLE IF EXISTS `surveillant`;
CREATE TABLE IF NOT EXISTS `surveillant` (
  `idsurveillant` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `date_naissance` date NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `fonction` varchar(45) NOT NULL,
  `CNI_passeport` varchar(45) NOT NULL,
  PRIMARY KEY (`idsurveillant`),
  UNIQUE KEY `idsurveillant_UNIQUE` (`idsurveillant`),
  UNIQUE KEY `CNI_passeport_UNIQUE` (`CNI_passeport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `abscence`
--
ALTER TABLE `abscence`
  ADD CONSTRAINT `fk_seance_has_eleve_eleve1` FOREIGN KEY (`eleve_ideleve`) REFERENCES `eleve` (`ideleve`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_seance_has_eleve_seance1` FOREIGN KEY (`seance_idseance`) REFERENCES `seance` (`idseance`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `eleve_has_evaluation`
--
ALTER TABLE `eleve_has_evaluation`
  ADD CONSTRAINT `fk_eleve_has_evaluation_eleve1` FOREIGN KEY (`eleve_ideleve`) REFERENCES `eleve` (`ideleve`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eleve_has_evaluation_evaluation1` FOREIGN KEY (`evaluation_idevaluation`) REFERENCES `evaluation` (`idevaluation`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `evaluation_has_surveillant`
--
ALTER TABLE `evaluation_has_surveillant`
  ADD CONSTRAINT `fk_evaluation_has_surveillant_evaluation1` FOREIGN KEY (`evaluation_idevaluation`) REFERENCES `evaluation` (`idevaluation`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_evaluation_has_surveillant_surveillant1` FOREIGN KEY (`surveillant_idsurveillant`) REFERENCES `surveillant` (`idsurveillant`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `inscription`
--
ALTER TABLE `inscription`
  ADD CONSTRAINT `fk_eleve_has_groupe_eleve1` FOREIGN KEY (`eleve_ideleve`) REFERENCES `eleve` (`ideleve`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eleve_has_groupe_groupe1` FOREIGN KEY (`groupe_idgroupe`) REFERENCES `groupe` (`idgroupe`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `matiere_has_groupe`
--
ALTER TABLE `matiere_has_groupe`
  ADD CONSTRAINT `fk_matiere_has_groupe_groupe1` FOREIGN KEY (`groupe_idgroupe`) REFERENCES `groupe` (`idgroupe`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_matiere_has_groupe_matiere1` FOREIGN KEY (`matiere_idmatiere`) REFERENCES `matiere` (`idmatiere`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_matiere_has_groupe_prof1` FOREIGN KEY (`prof_idprof`) REFERENCES `prof` (`idprof`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
