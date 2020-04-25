$('document').ready(function() {
    NDProgBar = {};

    NDProgBar.Progress = function(data) {
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text(data.label);
        $("#progress-bar").stop().css({"width": 0, "background-color": "#ff5f00"}).animate({
          width: '100%'
        }, {
          duration: parseInt(data.duration),
          complete: function() {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
            $.post('http://ND_progbar/actionFinish', JSON.stringify({
                })
            );
          }
        });
    };

    NDProgBar.ProgressCancel = function() {
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text("CANCELLED");
        $("#progress-bar").stop().css( {"width": "100%", "background-color": "#ff0000"});

        setTimeout(function () {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
            $.post('http://ND_progbar/actionCancel', JSON.stringify({
                })
            );
        }, 1000);
    };

    NDProgBar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };

    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'ND_progress':
                NDProgBar.Progress(event.data);
                break;
            case 'ND_progress_cancel':
                NDProgBar.ProgressCancel();
                break;
        }
    })
});
