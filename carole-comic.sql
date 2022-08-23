--
-- Base de données: `carole-comic`
--
CREATE DATABASE IF NOT EXISTS `carole-comic` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `carole-comic`;

-- --------------------------------------------------------

--
-- Structure de la table `collection`
--

DROP TABLE IF EXISTS `collection`;
CREATE TABLE IF NOT EXISTS `collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `prestige` varchar(50) DEFAULT NULL,
  `dateParution` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `comic`
--

DROP TABLE IF EXISTS `comic`;
CREATE TABLE IF NOT EXISTS `comic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn` int(11) DEFAULT NULL,
  `titre` varchar(50) DEFAULT NULL,
  `resume` text,
  `dessinateur` varchar(50) DEFAULT NULL,
  `datePublication` date DEFAULT NULL,
  `nombrePages` int(10) UNSIGNED DEFAULT NULL,
  `idSerie_fk` int(11) DEFAULT NULL,
  `idEpoque_fk` int(11) NOT NULL,
  `idEditeur_fk` int(11) NOT NULL,
  `idCollection_fk` int(11) DEFAULT NULL,
  `idUnivers_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `I_FK_COMIC_SERIE` (`idSerie_fk`),
  KEY `I_FK_COMIC_EPOQUE` (`idEpoque_fk`),
  KEY `I_FK_COMIC_EDITEUR` (`idEditeur_fk`),
  KEY `I_FK_COMIC_COLLECTION` (`idCollection_fk`),
  KEY `I_FK_COMIC_UNIVERS` (`idUnivers_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Structure de la table `editeur`
--

DROP TABLE IF EXISTS `editeur`;
CREATE TABLE IF NOT EXISTS `editeur` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `epoque`
--

DROP TABLE IF EXISTS `epoque`;
CREATE TABLE IF NOT EXISTS `epoque` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `description` text,
  `anne` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `personnage`
--

DROP TABLE IF EXISTS `personnage`;
CREATE TABLE IF NOT EXISTS `personnage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `description` text,
  `premiereApparution` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `posseder`
--

DROP TABLE IF EXISTS `posseder`;
CREATE TABLE IF NOT EXISTS `posseder` (
  `idComic` int(11) NOT NULL,
  `idPersonnage` int(11) NOT NULL,
  PRIMARY KEY (`idComic`,`idPersonnage`),
  KEY `I_FK_POSSEDER_PERSONNAGE` (`idPersonnage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `recevoir`
--

DROP TABLE IF EXISTS `recevoir`;
CREATE TABLE IF NOT EXISTS `recevoir` (
  `idComic` int(11) NOT NULL,
  `idRecompense` int(11) NOT NULL,
  `anneObtenue` year(4) DEFAULT NULL,
  PRIMARY KEY (`idComic`,`idRecompense`),
  KEY `I_FK_RECEVOIR_RECOMPENSE` (`idRecompense`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `recompense`
--

DROP TABLE IF EXISTS `recompense`;
CREATE TABLE IF NOT EXISTS `recompense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `scenariser`
--

DROP TABLE IF EXISTS `scenariser`;
CREATE TABLE IF NOT EXISTS `scenariser` (
  `idComic` int(11) NOT NULL,
  `idScenariste` int(11) NOT NULL,
  PRIMARY KEY (`idComic`,`idScenariste`),
  KEY `I_FK_SCENARISER_SCENARISTE` (`idScenariste`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `scenariste`
--

DROP TABLE IF EXISTS `scenariste`;
CREATE TABLE IF NOT EXISTS `scenariste` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `serie`
--

DROP TABLE IF EXISTS `serie`;
CREATE TABLE IF NOT EXISTS `serie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `nombreDeVolume` int(10) UNSIGNED DEFAULT NULL,
  `descriptif` text,
  `anneParution` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `univers`
--

DROP TABLE IF EXISTS `univers`;
CREATE TABLE IF NOT EXISTS `univers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;

-- --------------------------------------------------------

--
-- Contraintes pour la table `comic`
--
ALTER TABLE `comic`
  ADD CONSTRAINT `comic_ibfk_1` FOREIGN KEY (`idSerie_fk`) REFERENCES `serie` (`id`),
  ADD CONSTRAINT `comic_ibfk_2` FOREIGN KEY (`idEpoque_fk`) REFERENCES `epoque` (`id`),
  ADD CONSTRAINT `comic_ibfk_3` FOREIGN KEY (`idEditeur_fk`) REFERENCES `editeur` (`id`),
  ADD CONSTRAINT `comic_ibfk_4` FOREIGN KEY (`idCollection_fk`) REFERENCES `collection` (`id`),
  ADD CONSTRAINT `comic_ibfk_5` FOREIGN KEY (`idUnivers_fk`) REFERENCES `univers` (`id`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `scenariser`
  ADD CONSTRAINT `scenariser_ibfk_1` FOREIGN KEY (`idComic`) REFERENCES `comic` (`id`),
  ADD CONSTRAINT `scenariser_ibfk_2` FOREIGN KEY (`idScenariste`) REFERENCES `Scenariste` (`id`);
  

ALTER TABLE `recevoir`
  ADD CONSTRAINT `recvoir_ibfk_1` FOREIGN KEY (`idComic`) REFERENCES `comic` (`id`),
  ADD CONSTRAINT `recvoir_ibfk_2` FOREIGN KEY (`idRecompense`) REFERENCES `recompense` (`id`);

ALTER TABLE `posseder`
  ADD CONSTRAINT `posseder_ibfk_1` FOREIGN KEY (`idComic`) REFERENCES `comic` (`id`),
  ADD CONSTRAINT `posseder_ibfk_2` FOREIGN KEY (`idPersonnage`) REFERENCES `personnage` (`id`);