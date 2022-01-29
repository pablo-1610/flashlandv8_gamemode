MI.Phone.Settings = {};
MI.Phone.Settings.Background = "background-1";
MI.Phone.Settings.OpenedTab = null;
MI.Phone.Settings.Backgrounds = {
    'background-1': {
        label: "Standard"
    }
};

var PressedBackground = null;
var PressedBackgroundObject = null;
var OldBackground = null;
var IsChecked = null;

$(document).on('click', '.settings-app-tab', function(e){
    e.preventDefault();
    var PressedTab = $(this).data("settingstab");

    if (PressedTab == "background") {
        MI.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        MI.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "profilepicture") {
        MI.Phone.Animations.TopSlideDown(".settings-"+PressedTab+"-tab", 200, 0);
        MI.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "numberrecognition") {
        var checkBoxes = $(".numberrec-box");
        MI.Phone.Data.AnonymousCall = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", MI.Phone.Data.AnonymousCall);

        if (!MI.Phone.Data.AnonymousCall) {
            $("#numberrecognition > p").html('Désactivé');
        } else {
            $("#numberrecognition > p").html('Activé');
        }
    }
});

$(document).on('click', '#accept-background', function(e){
    e.preventDefault();
    var hasCustomBackground = MI.Phone.Functions.IsBackgroundCustom();

    if (hasCustomBackground === false) {
        MI.Phone.Notifications.Add("fas fa-paint-brush", MI.Phone.Functions.Lang("SETTINGS_TITLE"), MI.Phone.Settings.Backgrounds[MI.Phone.Settings.Background].label+" is ingesteld!")
        MI.Phone.Animations.TopSlideUp(".settings-"+MI.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('/html/img/backgrounds/"+MI.Phone.Settings.Background+".png')"})
    } else {
        MI.Phone.Notifications.Add("fas fa-paint-brush", MI.Phone.Functions.Lang("SETTINGS_TITLE"), MI.Phone.Functions.Lang("BACKGROUND_SET"))
        MI.Phone.Animations.TopSlideUp(".settings-"+MI.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $(".phone-background").css({"background-image":"url('"+MI.Phone.Settings.Background+"')"});
    }

    $.post('http://qb-phone_deluxe/SetBackground', JSON.stringify({
        background: MI.Phone.Settings.Background,
    }))
});

MI.Phone.Functions.LoadMetaData = function(MetaData) {
    if (MetaData.background !== null && MetaData.background !== undefined) {
        MI.Phone.Settings.Background = MetaData.background;
    } else {
        MI.Phone.Settings.Background = "background-1";
    }

    var hasCustomBackground = MI.Phone.Functions.IsBackgroundCustom();

    if (!hasCustomBackground) {
        $(".phone-background").css({"background-image":"url('/html/img/backgrounds/"+MI.Phone.Settings.Background+".png')"})
    } else {
        $(".phone-background").css({"background-image":"url('"+MI.Phone.Settings.Background+"')"});
    }

    if (MetaData.profilepicture == "default") {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+MetaData.profilepicture+'">');
    }
}

$(document).on('click', '#cancel-background', function(e){
    e.preventDefault();
    MI.Phone.Animations.TopSlideUp(".settings-"+MI.Phone.Settings.OpenedTab+"-tab", 200, -100);
});

MI.Phone.Functions.IsBackgroundCustom = function() {
    var retval = true;
    $.each(MI.Phone.Settings.Backgrounds, function(i, background){
        if (MI.Phone.Settings.Background == i) {
            retval = false;
        }
    });
    return retval
}

$(document).on('click', '.background-option', function(e){
    e.preventDefault();
    PressedBackground = $(this).data('background');
    PressedBackgroundObject = this;
    OldBackground = $(this).parent().find('.background-option-current');
    IsChecked = $(this).find('.background-option-current');

    if (IsChecked.length === 0) {
        if (PressedBackground != "custom-background") {
            MI.Phone.Settings.Background = PressedBackground;
            $(OldBackground).fadeOut(50, function(){
                $(OldBackground).remove();
            });
            $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            MI.Phone.Animations.TopSlideDown(".background-custom", 200, 13);
        }
    }
});

$(document).on('click', '#accept-custom-background', function(e){
    e.preventDefault();

    MI.Phone.Settings.Background = $(".custom-background-input").val();
    $(OldBackground).fadeOut(50, function(){
        $(OldBackground).remove();
    });
    $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
    MI.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

$(document).on('click', '#cancel-custom-background', function(e){
    e.preventDefault();

    MI.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

// Profile Picture

var PressedProfilePicture = null;
var PressedProfilePictureObject = null;
var OldProfilePicture = null;
var ProfilePictureIsChecked = null;

$(document).on('click', '#accept-profilepicture', function(e){
    e.preventDefault();
    var ProfilePicture = MI.Phone.Data.MetaData.profilepicture;
    if (ProfilePicture === "default") {
        MI.Phone.Notifications.Add("fas fa-paint-brush", MI.Phone.Functions.Lang("SETTINGS_TITLE"), MI.Phone.Functions.Lang("POFILE_DEFAULT"))
        MI.Phone.Animations.TopSlideUp(".settings-"+MI.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        MI.Phone.Notifications.Add("fas fa-paint-brush", MI.Phone.Functions.Lang("SETTINGS_TITLE"), MI.Phone.Functions.Lang("PROFILE_SET"))
        MI.Phone.Animations.TopSlideUp(".settings-"+MI.Phone.Settings.OpenedTab+"-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="'+ProfilePicture+'">');
    }
    $.post('http://qb-phone_deluxe/UpdateProfilePicture', JSON.stringify({
        profilepicture: ProfilePicture,
    }));
});

$(document).on('click', '#accept-custom-profilepicture', function(e){
    e.preventDefault();
    MI.Phone.Data.MetaData.profilepicture = $(".custom-profilepicture-input").val();
    $(OldProfilePicture).fadeOut(50, function(){
        $(OldProfilePicture).remove();
    });
    $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
    MI.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});

$(document).on('click', '.profilepicture-option', function(e){
    e.preventDefault();
    PressedProfilePicture = $(this).data('profilepicture');
    PressedProfilePictureObject = this;
    OldProfilePicture = $(this).parent().find('.profilepicture-option-current');
    ProfilePictureIsChecked = $(this).find('.profilepicture-option-current');
    if (ProfilePictureIsChecked.length === 0) {
        if (PressedProfilePicture != "custom-profilepicture") {
            MI.Phone.Data.MetaData.profilepicture = PressedProfilePicture
            $(OldProfilePicture).fadeOut(50, function(){
                $(OldProfilePicture).remove();
            });
            $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            MI.Phone.Animations.TopSlideDown(".profilepicture-custom", 200, 13);
        }
    }
});

$(document).on('click', '#cancel-profilepicture', function(e){
    e.preventDefault();
    MI.Phone.Animations.TopSlideUp(".settings-"+MI.Phone.Settings.OpenedTab+"-tab", 200, -100);
});


$(document).on('click', '#cancel-custom-profilepicture', function(e){
    e.preventDefault();
    MI.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});