create TABLE `flash_bankaccounts`
(
    `accountId` int(11) NOT NULL,
    `type`      int(11) NOT NULL,
    `owner`     varchar(50)  NOT NULL,
    `label`     varchar(255) NOT NULL,
    `pin`       int(11) NOT NULL,
    `balance`   int(11) NOT NULL,
    `state`     int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_bankaccounts_transaction`
(
    `accountId` int(11) NOT NULL,
    `type`      int(11) NOT NULL,
    `label`     varchar(255) NOT NULL,
    `amount`    int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players_job`
(
    `flashId`   INT          NOT NULL,
    `job`       VARCHAR(255) NOT NULL,
    `job_grade` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`flashId`)
) ENGINE = InnoDB;


create TABLE `flash_bans`
(
    `identifier` varchar(55) NOT NULL,
    `name`       varchar(75) NOT NULL,
    `date`       varchar(65) NOT NULL,
    `time`       varchar(65) NOT NULL,
    `reason`     longtext    NOT NULL,
    `moderator`  varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_inventory`
(
    `inventory_owner`    varchar(80)  NOT NULL,
    `inventory_type`     int(1) NOT NULL,
    `inventory_label`    varchar(255) NOT NULL,
    `inventory_capacity` double       NOT NULL,
    `inventory_content`  text         NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_item`
(
    `item_id`          varchar(80) NOT NULL,
    `item_label`       varchar(60) NOT NULL,
    `item_description` text        NOT NULL,
    `item_weight`      double      NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into `flash_item` (`item_id`, `item_label`, `item_description`, `item_weight`)
VALUES ('pain', 'Pain', 'Du pain xd', 0.2),
       ('phone', 'Téléphone', 'Téléphone qui sert ', 0.2),
       ('water', 'Eau', 'Eau', 0.2);

CREATE TABLE `flash_loadout`
(
    `loadout_owner`    varchar(80) NOT NULL,
    `loadout_type`     int(1) NOT NULL,
    `loadout_capacity` double      NOT NULL,
    `loadout_content`  text        NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_orga`
(
    `name`          varchar(55) NOT NULL,
    `label`         varchar(255) DEFAULT NULL,
    `boss`          text         DEFAULT NULL,
    `safe`          text         DEFAULT NULL,
    `spawn_vehicle` text         DEFAULT NULL,
    `del_vehicle`   text         DEFAULT NULL,
    `blip`          longtext     DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_orga_grades`
(
    `id`          int(11) NOT NULL,
    `orgaId`      varchar(55)  NOT NULL,
    `grade_id`    int(11) NOT NULL,
    `grade_name`  varchar(55)  NOT NULL,
    `grade_label` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_orga_grades_permissions`
(
    `id`         int(11) NOT NULL,
    `orga_name`  varchar(55)  NOT NULL,
    `gradeId`    int(11) NOT NULL,
    `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_phone_contacts`
(
    `id`      int(11) NOT NULL,
    `flashId` tinyint(11) DEFAULT NULL,
    `name`    varchar(50)          DEFAULT NULL,
    `number`  varchar(50)          DEFAULT NULL,
    `iban`    varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_phone_mails`
(
    `id`      int(11) NOT NULL,
    `flashId` tinyint(11) DEFAULT NULL,
    `sender`  varchar(50) DEFAULT NULL,
    `subject` varchar(50) DEFAULT NULL,
    `message` text        DEFAULT NULL,
    `read`    tinyint(4) DEFAULT 0,
    `mailid`  int(11) DEFAULT NULL,
    `date`    timestamp NULL DEFAULT current_timestamp (),
    `button`  text        DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_phone_messages`
(
    `id`       int(11) NOT NULL,
    `flashId`  tinyint(11) DEFAULT NULL,
    `number`   varchar(50) DEFAULT NULL,
    `messages` text        DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_phone_tweets`
(
    `id`        int(5) NOT NULL,
    `flashId`   tinyint(11) DEFAULT NULL,
    `firstName` varchar(50)  DEFAULT NULL,
    `lastName`  varchar(50)  DEFAULT NULL,
    `message`   varchar(50)  DEFAULT NULL,
    `url`       varchar(255) DEFAULT NULL,
    `time`      varchar(50)  DEFAULT NULL,
    `picture`   varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players`
(
    `flashId`        int(11) NOT NULL,
    `identifier`     varchar(80) NOT NULL,
    `rankId`         varchar(50) NOT NULL,
    `identity`       text        NOT NULL,
    `cash`           int(11) NOT NULL,
    `skin`           text        NOT NULL,
    `outfits`        text        NOT NULL,
    `selectedOutfit` varchar(80) NOT NULL DEFAULT 'default',
    `accessories`    text        NOT NULL,
    `number`         varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players_identifiers`
(
    `flashId`  int(11) NOT NULL,
    `license`  varchar(150) NOT NULL,
    `steam`    varchar(150) NOT NULL,
    `live`     varchar(150) NOT NULL,
    `xbl`      varchar(150) NOT NULL,
    `discord`  varchar(150) NOT NULL,
    `endpoint` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players_phone`
(
    `flashId`        tinyint(4) NOT NULL,
    `number`         varchar(85) NOT NULL,
    `profilepicture` text        NOT NULL,
    `background`     text        NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players_positions`
(
    `flashId`  int(11) NOT NULL,
    `position` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_ranks`
(
    `position`  int(11) NOT NULL,
    `id`        varchar(50)  NOT NULL,
    `label`     varchar(255) NOT NULL,
    `weight`    int(11) NOT NULL DEFAULT 0,
    `baseColor` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks` (`position`, `id`, `label`, `weight`, `baseColor`)
VALUES (4, 'fonda', 'Fondateur', 90000000, '~r~'),
       (1, 'member', 'Membre', 0, '~m~');

CREATE TABLE `flash_ranks_permissions`
(
    `id`         int(50) NOT NULL,
    `rankId`     varchar(50)  NOT NULL,
    `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks_permissions` (`id`, `rankId`, `permission`)
VALUES (1, 'fonda', 'admin.open'),
       (3, 'fonda', 'admin.vehdelete'),
       (4, 'fonda', 'admin.giveitem'),
       (5, 'fonda', 'admin.giveweapon'),
       (6, 'fonda', 'admin.kickplayer'),
       (7, 'fonda', 'admin.removeplayeritem'),
       (8, 'fonda', 'admin.removeplayerweapon'),
       (9, 'fonda', 'admin.vehspawn'),
       (10, 'fonda', 'admin.teleport'),
       (11, 'fonda', 'admin.ban'),
       (12, 'fonda', 'admin.unban'),
       (13, 'fonda', 'admin.banlist'),
       (14, 'fonda', 'admin.noclip'),
       (15, 'fonda', 'admin.report'),
       (16, 'fonda', 'admin.names'),
       (17, 'fonda', 'admin.blips'),
       (18, 'fonda', 'admin.tpwaypoint'),
       (20, 'fonda', 'admin.playerinv'),
       (21, 'fonda', 'admin.organisation'),
       (22, 'fonda', 'admin.openOrgaGrade'),
       (23, 'fonda', 'admin.moveOrgaPoint'),
       (24, 'fonda', 'admin.deleteOrga'),
       (25, 'fonda', 'admin.accessRankManagerAndManageRank'),
       (26, 'fonda', 'admin.createGroup'),
       (79, 'fonda', 'admin.teleport'),
       (80, 'fonda', 'admin.teleport'),
       (85, 'fonda', 'admin.deleteRank'),
       (86, 'fonda', 'admin.playerList'),
       (87, 'fonda', 'admin.deleteGrade'),
       (106, 'fonda', 'admin.createOrganisation');

ALTER TABLE `flash_bans`
    ADD PRIMARY KEY (`identifier`),
  ADD UNIQUE KEY `identifier` (`identifier`);

ALTER TABLE `flash_inventory`
    ADD PRIMARY KEY (`inventory_owner`),
  ADD UNIQUE KEY `inventory_owner` (`inventory_owner`);

ALTER TABLE `flash_item`
    ADD PRIMARY KEY (`item_id`),
  ADD UNIQUE KEY `item_id` (`item_id`);

ALTER TABLE `flash_loadout`
    ADD PRIMARY KEY (`loadout_owner`),
  ADD UNIQUE KEY `loadout_owner` (`loadout_owner`);

ALTER TABLE `flash_orga`
    ADD PRIMARY KEY (`name`);

ALTER TABLE `flash_orga_grades`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `flash_orga_grades_permissions`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `flash_phone_contacts`
    ADD PRIMARY KEY (`id`),
  ADD KEY `flashId` (`flashId`);

ALTER TABLE `flash_phone_mails`
    ADD PRIMARY KEY (`id`),
  ADD KEY `flashId` (`flashId`);

ALTER TABLE `flash_phone_messages`
    ADD PRIMARY KEY (`id`),
  ADD KEY `flashId` (`flashId`),
  ADD KEY `number` (`number`);

ALTER TABLE `flash_phone_tweets`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `flash_players`
    ADD PRIMARY KEY (`flashId`),
  ADD UNIQUE KEY `flashId` (`flashId`);

ALTER TABLE `flash_players_identifiers`
    ADD PRIMARY KEY (`flashId`),
  ADD UNIQUE KEY `flashId` (`flashId`);

ALTER TABLE `flash_players_phone`
    ADD PRIMARY KEY (`flashId`);

ALTER TABLE `flash_players_positions`
    ADD PRIMARY KEY (`flashId`),
  ADD UNIQUE KEY `flashId` (`flashId`);

ALTER TABLE `flash_ranks`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `flash_ranks_permissions`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `flash_orga_grades`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

ALTER TABLE `flash_orga_grades_permissions`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `flash_phone_contacts`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12434;

ALTER TABLE `flash_phone_mails`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67023;

ALTER TABLE `flash_phone_messages`
    MODIFY `id` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6732;

ALTER TABLE `flash_phone_tweets`
    MODIFY `id` int (5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `flash_players`
    MODIFY `flashId` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `flash_players_positions`
    MODIFY `flashId` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `flash_ranks_permissions`
    MODIFY `id` int (50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;
COMMIT;

