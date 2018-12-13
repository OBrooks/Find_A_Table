(function () {
    $(document).on('click', '.toggle-window', function (e) {
        e.preventDefault();
        var panel = $(this).parent().parent();
        var messages_list = panel.find('.messages-list');

        panel.find('.messenger-body').toggle();
        panel.attr('class', 'messenger messenger-default');

        if (panel.find('.messenger-body').is(':visible')) {
            var height = messages_list[0].scrollHeight;
            messages_list.scrollTop(height);
        }
    });

})();
