var loadFoundation = function() {
    $(document).foundation();
}
$(document).ready(loadFoundation);
$(document).on('page:load', loadFoundation);
