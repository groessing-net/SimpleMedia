<?php
/**
 * SimpleMedia.
 *
 * @copyright Erik Spaan & Axel Guckelsberger (ZKM)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Erik Spaan & Axel Guckelsberger <erik@zikula.nl>.
 * @link https://github.com/zikula-ev/SimpleMedia
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Event handler base class for view-related events.
 */
class SimpleMedia_Listener_Base_View
{
    /**
     * Listener for the `view.init` event.
     *
     * Occurs just before `Zikula_View#__construct()` finishes.
     * The subject is the Zikula_View instance.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function init(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `view.postfetch` event.
     *
     * Filter of result of a fetch.
     * Receives `Zikula_View` instance as subject,
     * args are `array('template' => $template)`,
     * $data was the result of the fetch to be filtered.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function postFetch(Zikula_Event $event)
    {
    }
}