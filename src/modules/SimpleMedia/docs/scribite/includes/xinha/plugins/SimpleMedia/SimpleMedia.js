// SimpleMedia plugin for Xinha
// developed by Erik Spaan & Axel Guckelsberger
//
// requires SimpleMedia module (https://github.com/zikula-ev/SimpleMedia)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function SimpleMedia(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'SimpleMedia',
        tooltip  : 'Insert SimpleMedia object',
     // image    : _editor_url + 'plugins/SimpleMedia/img/ed_SimpleMedia.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=SimpleMedia&type=external&func=finder&editor=xinha';
            SimpleMediaFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('SimpleMedia', 'insertimage', 1);
}

SimpleMedia._pluginInfo = {
    name          : 'SimpleMedia for xinha',
    version       : '2.0.0',
    developer     : 'Erik Spaan & Axel Guckelsberger',
    developer_url : 'https://github.com/zikula-ev/SimpleMedia',
    sponsor       : 'ModuleStudio 0.6.1',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
