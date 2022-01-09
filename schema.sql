SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

create TABLE `flash_bankaccounts` (
                                      `accountId` int(11) NOT NULL,
                                      `type` int(11) NOT NULL,
                                      `owner` varchar(50) NOT NULL,
                                      `label` varchar(255) NOT NULL,
                                      `pin` int(11) NOT NULL,
                                      `balance` int(11) NOT NULL,
                                      `state` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_bankaccounts_transaction` (
                                                  `accountId` int(11) NOT NULL,
                                                  `type` int(11) NOT NULL,
                                                  `label` varchar(255) NOT NULL,
                                                  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_inventory` (
                                   `inventory_owner` varchar(80) NOT NULL,
                                   `inventory_type` int(1) NOT NULL,
                                   `inventory_label` varchar(255) NOT NULL,
                                   `inventory_capacity` double NOT NULL,
                                   `inventory_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_item` (
                              `item_id` varchar(80) NOT NULL,
                              `item_label` varchar(60) NOT NULL,
                              `item_description` text NOT NULL,
                              `item_weight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_loadout` (
                                 `loadout_owner` varchar(80) NOT NULL,
                                 `loadout_type` int(1) NOT NULL,
                                 `loadout_capacity` double NOT NULL,
                                 `loadout_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



create TABLE `flash_players` (
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

create TABLE `flash_players_identifiers` (
  `flashId` int(11) NOT NULL,
  `license` varchar(150) NOT NULL,
  `steam` varchar(150) NOT NULL,
  `live` varchar(150) NOT NULL,
  `xbl` varchar(150) NOT NULL,
  `discord` varchar(150) NOT NULL,
  `endpoint` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_players_positions` (
  `flashId` int(11) NOT NULL,
  `position` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

create TABLE `flash_ranks` (
  `id` varchar(50) NOT NULL,
  `label` varchar(255) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `baseColor` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into `flash_ranks` (`id`, `label`, `weight`, `baseColor`) VALUES
('fonda', 'Fondateur', 90000000, '~r~'),
('member', 'Membre', 0, '~m~');

create TABLE `flash_ranks_permissions` (
  `id` int(50) NOT NULL,
  `rankId` varchar(50) NOT NULL,
  `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `flash_bans` (
  `identifier` varchar(55) NOT NULL,
  `name` varchar(75) NOT NULL,
  `date` varchar(65) NOT NULL,
  `time` varchar(65) NOT NULL,
  `reason` longtext NOT NULL,
  `moderator` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `flash_ranks_permissions` (`id`, `rankId`, `permission`) VALUES
(1, 'fonda', 'admin.open'),
(2, 'mod', 'admin.open'),
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
(20, 'fonda', 'admin.playerinv');

ALTER TABLE `flash_bans`
  ADD PRIMARY KEY (`identifier`),
  ADD UNIQUE KEY `identifier` (`identifier`);
COMMIT;

alter table `flash_bankaccounts`
  ADD PRIMARY KEY (`accountId`);

alter table `flash_bankaccounts_transaction`
  ADD PRIMARY KEY (`accountId`);

alter table `flash_inventory`
  ADD PRIMARY KEY (`inventory_owner`);

alter table `flash_item`
  ADD PRIMARY KEY (`item_id`);

alter table `flash_loadout`
  ADD PRIMARY KEY (`loadout_owner`);

alter table `flash_players`
  ADD PRIMARY KEY (`flashId`),
  ADD UNIQUE KEY `id` (`flashId`),
  ADD UNIQUE KEY `identifier` (`identifier`);

alter table `flash_players_identifiers`
  ADD PRIMARY KEY (`flashId`);

alter table `flash_players_positions`
  ADD PRIMARY KEY (`flashId`);

alter table `flash_ranks`
  ADD PRIMARY KEY (`id`);

alter table `flash_ranks_permissions`
  ADD PRIMARY KEY (`id`);

alter table `flash_bankaccounts`
  MODIFY `accountId` int(11) NOT NULL AUTO_INCREMENT;

alter table `flash_players`
  MODIFY `flashId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

alter table `flash_ranks_permissions`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;