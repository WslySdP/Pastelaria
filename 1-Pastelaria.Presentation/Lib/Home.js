﻿var home = (function () {
    var config = {
        url: {
            post: '',
            get: '',
            getTarefas: ''
        }
    };

    var init = function ($config) {
        config = $config;
    }

    var post = function () {
        debugger;
        var usuario = $("#form").serializeObject();

        $.post(config.url.post, {
            usuario: $("#form").serializeObject()
        }).done(function () {
            window.location = 'Tarefas/Index';
        }).fail(function (xhr) {
            alert(xhr.responseText);
        });
    };

    //var getGrid = function () {
    //    debugger;
    //    $.get(config.url.get).success(function (data) {
    //        alert(data);
    //        $("#grid").html(data);
    //    }).error(function (xhr) {
    //        alert(xhr.responseText);
    //    });
    //};

    return {
        init: init,
        post: post
    };
})();