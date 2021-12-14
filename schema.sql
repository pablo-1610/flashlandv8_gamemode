CREATE TABLE `flash_bankaccounts`
(
    `accountId` int(11) NOT NULL,
    `type`      int(11) NOT NULL,
    `owner`     varchar(50)  NOT NULL,
    `label`     varchar(255) NOT NULL,
    `pin`       int(11) NOT NULL,
    `balance`   float        NOT NULL,
    `state`     int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_bankaccounts_transaction`
(
    `accountId` int(11) NOT NULL,
    `type`      int(11) NOT NULL,
    `label`     varchar(255) NOT NULL,
    `amount`    int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_inventory`
(
    `inventory_owner`    varchar(80)  NOT NULL,
    `inventory_type`     int(1) NOT NULL,
    `inventory_label`    varchar(255) NOT NULL,
    `inventory_capacity` double       NOT NULL,
    `inventory_content`  text         NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `flash_item`
(
    `item_id`          varchar(80) NOT NULL,
    `item_label`       varchar(60) NOT NULL,
    `item_description` text        NOT NULL,
    `item_weight`      double      NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_loadout`
(
    `loadout_owner`    varchar(80) NOT NULL,
    `loadout_type`     int(1) NOT NULL,
    `loadout_capacity` double      NOT NULL,
    `loadout_content`  text        NOT NULL
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
    `accessories`    text        NOT NULL
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

CREATE TABLE `flash_players_positions`
(
    `flashId`  int(11) NOT NULL,
    `position` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_ranks`
(
    `id`        varchar(50)  NOT NULL,
    `label`     varchar(255) NOT NULL,
    `weight`    int(11) NOT NULL DEFAULT 0,
    `baseColor` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks` (`id`, `label`, `weight`, `baseColor`)
VALUES ('fonda', 'Fondateur', 90000000, '~r~'),
       ('helper', 'Helper', 60, ''),
       ('member', 'Membre', 0, '~m~'),
       ('mod', 'Moderateur', 500, '~o~'),
       ('vip', 'VIP', 50, '');

CREATE TABLE `flash_ranks_permissions`
(
    `id`         int(50) NOT NULL,
    `rankId`     varchar(50)  NOT NULL,
    `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks_permissions` (`id`, `rankId`, `permission`)
VALUES (1, 'fonda', 'commands.ban'),
       (2, 'fonda', 'commands.kick'),
       (5, 'fonda', 'admin.open'),
       (6, 'fonda', 'admin.noclip'),
       (9, 'fonda', 'admin.vehspawn'),
       (10, 'fonda', 'admin.vehdelete'),
       (11, 'fonda', 'admin.vehmax'),
       (12, 'fonda', 'admin.names'),
       (13, 'fonda', 'admin.blips'),
       (14, 'fonda', 'admin.tpwaypoint'),
       (15, 'mod', 'admin.open');

CREATE TABLE `flash_shopsfidelity`
(
    `owner`  varchar(100) NOT NULL,
    `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_shopsfidelity` (`owner`, `points`)
VALUES ('player:68', 0);

ALTER TABLE `flash_bankaccounts`
    ADD PRIMARY KEY (`accountId`);

ALTER TABLE `flash_bankaccounts_transaction`
    ADD PRIMARY KEY (`accountId`);

ALTER TABLE `flash_inventory`
    ADD PRIMARY KEY (`inventory_owner`);

ALTER TABLE `flash_item`
    ADD PRIMARY KEY (`item_id`);

ALTER TABLE `flash_loadout`
    ADD PRIMARY KEY (`loadout_owner`);

ALTER TABLE `flash_players`
    ADD PRIMARY KEY (`flashId`),
  ADD UNIQUE KEY `id` (`flashId`),
  ADD UNIQUE KEY `identifier` (`identifier`);

ALTER TABLE `flash_players_identifiers`
    ADD PRIMARY KEY (`flashId`);

ALTER TABLE `flash_players_positions`
    ADD PRIMARY KEY (`flashId`);

ALTER TABLE `flash_ranks`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `flash_ranks_permissions`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `flash_shopsfidelity`
    ADD PRIMARY KEY (`owner`);

ALTER TABLE `flash_bankaccounts`
    MODIFY `accountId` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

ALTER TABLE `flash_players`
    MODIFY `flashId` int (11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

ALTER TABLE `flash_ranks_permissions`
    MODIFY `id` int (50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;