CKEDITOR.plugins.add('SimpleMedia', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertSimpleMedia', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=SimpleMedia&type=external&func=finder&editor=ckeditor';
                // call method in SimpleMedia_finder.js and provide current editor
                SimpleMediaFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('simplemedia', {
            label: editor.lang.SimpleMedia.title,
            command: 'insertSimpleMedia',
         // icon: this.path + 'images/ed_simplemedia.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
