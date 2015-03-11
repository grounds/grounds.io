# Add new language support

1. Send a pull request to add support for this new language stack to
[grounds-images](https://github.com/grounds/grounds-images).

    >You may skip this step if grounds-images already supports this
    language or if a pull request already exist for the same
    purpose.

2. Assign a label to your language code in `config/editor.yml`:

    e.g. For PHP:

        php: 'PHP'

3. Add to `app/assets/javascripts/grounds/utils.js` an hello world
example:

    e.g. For PHP:

        utils.samples['php'] = { mode: 'php', code: [
        '<?php',
        '',
        'print("Hello world\\n");'
        ]};

    N.B. `mode` may differ from the language code and correspond to
    [Ace](http://ace.c9.io/) mode. You can find a list of Ace modes
    [here](https://github.com/ajaxorg/ace/tree/master/lib/ace/mode).

4. Require Ace mode from `vendor/assets/javascripts`:

    e.g. For PHP:

        //= require ace/mode-php

5. Run the full test suite

        make test

6. Send a pull request and mark it blocked by your grounds-images pull
request.
    >If grounds-images already supports this language, don't mark it.
    If a pull request already exists to add support for this language
    to grounds-images, mark yours blocked by it.

**Thanks for your contribution!**
