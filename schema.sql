SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `flash_bankaccounts` (
                                      `accountId` int(11) NOT NULL,
                                      `type` int(11) NOT NULL,
                                      `owner` varchar(50) NOT NULL,
                                      `pin` int(11) NOT NULL,
                                      `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_bankaccounts_transaction` (
                                                  `accountId` int(11) NOT NULL,
                                                  `type` int(11) NOT NULL,
                                                  `label` varchar(255) NOT NULL,
                                                  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_inventory` (
                                   `inventory_owner` varchar(80) NOT NULL,
                                   `inventory_type` int(1) NOT NULL,
                                   `inventory_label` varchar(255) NOT NULL,
                                   `inventory_capacity` double NOT NULL,
                                   `inventory_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_item` (
                              `item_id` varchar(80) NOT NULL,
                              `item_label` varchar(60) NOT NULL,
                              `item_description` text NOT NULL,
                              `item_weight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_loadout` (
                                 `loadout_owner` varchar(80) NOT NULL,
                                 `loadout_type` int(1) NOT NULL,
                                 `loadout_capacity` double NOT NULL,
                                 `loadout_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `flash_players` (
                                 `flashId` int(11) NOT NULL,
                                 `identifier` varchar(80) NOT NULL,
                                 `rankId` varchar(50) NOT NULL,
                                 `identity` text NOT NULL,
                                 `cash` int(11) NOT NULL,
                                 `skin` text NOT NULL,
                                 `outfits` text NOT NULL,
                                 `selectedOutfit` varchar(80) NOT NULL DEFAULT 'default',
                                 `accessories` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players_identifiers` (
  `flashId` int(11) NOT NULL,
  `license` varchar(150) NOT NULL,
  `steam` varchar(150) NOT NULL,
  `live` varchar(150) NOT NULL,
  `xbl` varchar(150) NOT NULL,
  `discord` varchar(150) NOT NULL,
  `endpoint` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_players_positions` (
  `flashId` int(11) NOT NULL,
  `position` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_ranks` (
  `id` varchar(50) NOT NULL,
  `label` varchar(255) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `baseColor` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks` (`id`, `label`, `weight`, `baseColor`) VALUES
('fonda', 'Fondateur', 90000000, '~r~'),
('member', 'Membre', 0, '~m~'),

CREATE TABLE `flash_ranks_permissions` (
  `id` int(50) NOT NULL,
  `rankId` varchar(50) NOT NULL,
  `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks_permissions` (`id`, `rankId`, `permission`) VALUES
(1, 'fonda', 'admin.open'),
(2, 'mod', 'admin.open');
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

ALTER TABLE `flash_bankaccounts`
  MODIFY `accountId` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `flash_players`
  MODIFY `flashId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

ALTER TABLE `flash_ranks_permissions`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;