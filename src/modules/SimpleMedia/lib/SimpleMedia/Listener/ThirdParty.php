<?php
/**
 * SimpleMedia.
 *
 * @copyright Axel Guckelsberger
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Axel Guckelsberger <info@guite.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Mon Nov 05 23:27:05 CET 2012.
 */

/**
 * Event handler implementation class for special purposes and 3rd party api support.
 */
class SimpleMedia_Listener_ThirdParty extends SimpleMedia_Listener_Base_ThirdParty
{
    /**
     * Listener for pending content items.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function pendingContentListener(Zikula_Event $event)
    {
        parent::pendingContentListener($event);
    }

    /**
     * Listener for the `module.content.gettypes` event.
     *
     * This event occurs when the Content module is 'searching' for Content plugins.
     * The subject is an instance of Content_Types.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function contentGetTypes(Zikula_Event $event)
    {
        parent::contentGetTypes($event);
    }

    /**
     * Listener for the `module.scribite.editorhelpers` event.
     * 
     * This occurs when Scribite adds pagevars to the editor page.
     * SimpleMedia will use this to add a javascript helper to add media items.
     * 
     * @param Zikula_Event $event
     */
    public static function getEditorHelpers(Zikula_Event $event)
    {
        $event->getSubject()->add(array('module' => 'SimpleMedia',
            'type' => 'javascript',
            'path' => 'modules/SimpleMedia/javascript/SimpleMedia_finder.js'));
    }
    
    /**
     * Listener for `moduleplugin.tinymce.externalplugins` event.
     * adds external plugin to TinyMCE
     * 
     * @param Zikula_Event $event 
     */
    public static function getTinyMcePlugins(Zikula_Event $event)
    {
        $event->getSubject()->add(array('name' => 'simplemedia',
                 'path' => 'modules/SimpleMedia/docs/scribite/plugins/TinyMCE/vendor/tiny_mce/plugins/simplemedia/editor_plugin.js'));
    }
    
    /**
     * Listener for `moduleplugin.ckeditor.externalplugins` event
     * add external plugin to CKEditor
     * 
     * @param Zikula_Event $event 
     */
    public static  function getCKEditorPlugins(Zikula_Event $event)
    {
        $event->getSubject()->add(array('name' => 'simplemedia',
                 'path' => 'modules/SimpleMedia/docs/scribite/plugins/CKEditor/vendor/ckeditor/plugins/simplemedia/',
                 'file' => 'plugin.js',
                 'img' => 'ed_simplemedia.gif'));
    }
    
}
