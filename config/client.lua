--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:12
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_ConfigClient = {
    RichPresence = {
        appId = 907401133717340161,
    },

    Npc = {
        showHealth = false,
        showNpcIcon = true,
    },

    Creator = {
        pedPosition = {coords = vector3(686.25, 577.69, 130.46), heading = 164.0},
        camPosition = {coords = vector3(683.78, 570.56, 130.46)},

        defaultOutFits = {
            {
                label = "Décontracté",
                values = {
                    [0] = {
                        ["tshirt_1"] = 15,
                        ["tshirt_2"] = 0,
                        ["torso_1"] = 9,
                        ["torso_2"] = 0,
                        ["arms"] = 0,
                        ["pants_1"] = 6,
                        ["pants_2"] = 0,
                        ["shoes_1"] = 5,
                        ["shoes_2"] = 0,
                    },

                    [1] = {
                        ["tshirt_1"] = 15,
                        ["tshirt_2"] = 0,
                        ["torso_1"] = 0,
                        ["torso_2"] = 0,
                        ["arms"] = 0,
                        ["pants_1"] = 7,
                        ["pants_2"] = 1,
                        ["shoes_1"] = 5,
                        ["shoes_2"] = 0,
                    }
                }
            },
        }
    },

    Skin = {
        { id = "skin", label = "Peau" },
        { id = "face", label = "Visage" },
        { id = "hair_1", label = "Cheveux", sub = "hair_color_1" },
        { id = "beard_2", label = "Taille barbe" },
        { id = "beard_1", label = "Type barbe", sub = "beard_3" }
    },

    Permission = {
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
        ["admin.moveorgapoint"] = { label = "Organisation Point", description = "Permet de modifié l'emplacement des markers et blips d'une organisation !", perm = "admin.moveorgapoint" },
        ["admin.deleteorga"] = { label = "Supprimer Organisation", description = "Permet de ~r~SUPPRIMER ~s~une organisation en jeux !", perm = "admin.deleteorga" },
        ["admin.accessrankmanagerandmanageRank"] = { label = "Gestion Permission", description = "Permet d'accéder et gérer les permissions des différents rôle en jeux mais pas de son role et des rôles supérieur !", perm = "admin.accessrankmanagerandmanageRank" },
        ["admin.createGroup"] = { label = "Créer un grade d'administration", description = "Permet de ~g~CREER ~s~un grade d'administration et de lui attribuer les perms voulu pour ce grade !", perm = "admin.createGroup" },
        ["admin.deleteRank"] = { label = "Supprimer grade d'administration", description = "Permet de supprimer un grade d'administration !", perm = "admin.deleteRank" },
    },
}