--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_Config = {
    prefix = "[^6FlashLand^7]",
    environment = "DEV",
    enableErrorsLog = true,
    enableSqlLog = true,
    startRank = "member",

    genericBlipSize = 1.0,
    genericSubBlipSize = 0.9,

    Staff = {
        permissions = {
            ["open"] = "admin.open",
            ["noclip"] = "admin.noclip",
        }
    },

    Color = {
        { name = "Rouge", color = "~r~" },
        { name = "Bleu", color = "~b~" },
        { name = "Vert", color = "~g~" },
        { name = "Jaune", color = "~y~" },
        { name = "Violet", color = "~p~" },
        { name = "Gris Clair", color = "~c~" },
        { name = "Gris Foncé", color = "~m~" },
        { name = "Noir", color = "~u~" },
        { name = "Orange", color = "~o~" },
    },

    StaffPermission = {
        ["admin.open"] = { label = "Ouvrir Menu", description = "Ouvrir le menu d'administration via le F5 !", perm = "admin.open" },
        ["admin.playerList"] = { label = "Liste des joueurs", description = "Permet d'accéder à la liste des joueurs !", perm = "admin.playerList" },
        ["admin.playerinv"] = { label = "Inventaire Joueur", description = "Permet d'accéder à la liste des items du joueur !", perm = "admin.playerinv" },
        ["admin.giveitem"] = { label = "Donner Item", description = "Permet d'accéder à la liste des items et d'en give un montant selectionné !", perm = "admin.giveitem" },
        ["admin.removeplayeritem"] = { label = "Enlever Item", description = "Permet retirer un/ou des item(s) du joueur !", perm = "admin.removeplayeritem" },
        ["admin.giveweapon"] = { label = "Donner Arme", description = "Permet d'accéder à la liste des armes et d'en donner !", perm = "admin.giveweapon" },
        ["admin.removeplayerweapon"] = { label = "Enlever Arme", description = "Permet d'accéder à la liste des armes du joueur et de lui en retirer !", perm = "admin.removeplayerweapon" },
        ["admin.kickplayer"] = { label = "Déconnecter Joueur", description = "Permet de ~r~DECONNECTER ~s~le joueur du serveur !", perm = "admin.kickplayer" },
        ["admin.teleport"] = { label = "Téléporter Joueur", description = "Permet de ce téléporter à une personne ou de la téléporter sur soi !", perm = "admin.teleport" },
        ["admin.vehspawn"] = { label = "Spawn Véhicule", description = "Permet de faire spawn un véhicule via son nom !", perm = "admin.vehspawn" },
        ["admin.vehdelete"] = { label = "Supprimer Véhicule", description = "Supprimer un véhicule selectionné !", perm = "admin.vehdelete" },
        ["admin.noclip"] = { label = "Noclip", description = "Permet d'activer le noclip !", perm = "admin.noclip" },
        ["admin.names"] = { label = "Gamertag", description = "Permet d'afficher les noms des joueurs !", perm = "admin.names" },
        ["admin.blips"] = { label = "Blips Joueur", description = "Permet d'activer les blips des joueurs !", perm = "admin.blips" },
        ["admin.tpwaypoint"] = { label = "Téléporter Point", description = "Permet de ce téléporter sur un marker placé !", perm = "admin.tpwaypoint" },
        ["admin.banlist"] = { label = "Voir Ban(s)", description = "Permet d'accéder à la liste des bannies du serveur !", perm = "admin.banlist" },
        ["admin.ban"] = { label = "Bannir", description = "Permet de ~r~BANNIR ~s~ un joueur pendant un temps de jour selectionné !", perm = "admin.ban" },
        ["admin.unban"] = { label = "Débannir", description = "Permet de ~r~DEBANNIR ~s~un joueur qui est actuellement bannie du serveur !", perm = "admin.unban" },
        ["admin.report"] = { label = "Voir Report(s)", description = "Permet d'accéder à au report !", perm = "admin.report" },
        ["admin.organisation"] = { label = "Gestion Organisation", description = "Permet de voir les paramètres d'une organisation et non d'intéragir avec !", perm = "admin.organisation" },
        ["admin.createOrganisation"] = { label = "Créer Organisation", description = "Permet de créer une organisation", perm = "admin.createOrganisation" },
        ["admin.openorgagrade"] = { label = "Organisation Grade", description = "Permet d'accéder au(x) grade(s) d'une organisation sélectionnée !", perm = "admin.openorgagrade" },
        ["admin.managePermissionOrganisationGrade"] = { label = "Gérer Grade Organisation", description = "Permet de mettre/retirer les permissions d'un grade pour une organisation !", perm = "admin.openorgagrade" },
        ["admin.moveorgapoint"] = { label = "Organisation Point", description = "Permet de modifié l'emplacement des markers et blips d'une organisation !", perm = "admin.moveorgapoint" },
        ["admin.deleteorga"] = { label = "Supprimer Organisation", description = "Permet de ~r~SUPPRIMER ~s~une organisation en jeux !", perm = "admin.deleteorga" },
        ["admin.accessrankmanagerandmanageRank"] = { label = "Gestion Permission", description = "Permet d'accéder et gérer les permissions des différents rôle en jeux mais pas de son role et des rôles supérieur !", perm = "admin.accessrankmanagerandmanageRank" },
        ["admin.createGroup"] = { label = "Créer un grade d'administration", description = "Permet de ~g~CREER ~s~un grade d'administration et de lui attribuer les perms voulu pour ce grade !", perm = "admin.createGroup" },
        ["admin.deleteRank"] = { label = "Supprimer grade d'administration", description = "Permet de supprimer un grade d'administration !", perm = "admin.deleteRank" },
        ["admin.changeJob"] = { label = "Changer le job", description = "Permet de changer le job d'un joueur !", perm = "admin.changeJob" },
        ["admin.changeOrga"] = { label = "Changer l'organisation", description = "Permet de changer l'organisation d'un joueur !", perm = "admin.changeOrga" },
    },

    OrganisationPermission = {
        ["orga.delVehicle"] = { label = "Ranger un véhicule", description = "Permet de ranger un véhicule dans le garage !", perm = "orga.delVehicle" },
        ["orga.openSafe"] = { label = "Ouvrir le coffre", description = "Permet d'ouvrir le coffre de l'organisation !", perm = "orga.openSafe" },
        ["orga.safeDepositItem"] = { label = "Déposer item dans le coffre", description = "Permet d'ouvrir le coffre de l'organisation !", perm = "orga.safeDepositItem" },
        ["orga.safeRecoverItem"] = { label = "Prendre item dans le coffre", description = "Permet d'ouvrir le coffre de l'organisation !", perm = "orga.safeRecoverItem" },
        ["orga.safeDepositWeapon"] = { label = "Déposer arme dans coffre", description = "Permet d'ouvrir le coffre de l'organisation !", perm = "orga.safeDepositWeapon" },
        ["orga.safeRecoverWeapon"] = { label = "Prendre arme dans le coffre", description = "Permet d'ouvrir le coffre de l'organisation !", perm = "orga.safeRecoverWeapon" },
        ["orga.openSpawnVehicle"] = { label = "Faire spawn un véhicule", description = "Permet de faire spawn un véhicule du garage !", perm = "orga.openSpawnVehicle" },
        ["orga.openBossMenu"] = { label = "Ouvrir l'action patron", description = "Permet d'ouvrir l'action patron de l'organisation !", perm = "orga.openBossMenu" },
        ["orga.bossManageOrganisationGrade"] = { label = "Gérer les grades", description = "Permet de gérer les grades de l'organisation !", perm = "orga.bossManageOrganisationGrade" },
        ["orga.bossManageMember"] = { label = "Gérer les membres", description = "Permet de gérer les membres de l'organisation !", perm = "orga.bossManageMember" },
        ["orga.bossMember"] = { label = "Accéder à la liste des membres", description = "Permet d'accéder à la liste des membres de l'organisation !", perm = "orga.bossMember" },
        ["orga.createGrade"] = { label = "Créer un grade", description = "Permet de créer un grade !", perm = "orga.createGrade" },
        ["orga.deleteGrade"] = { label = "Supprimer un grade", description = "Permet de supprimer un grade !", perm = "orga.deleteGrade" },
    }
}