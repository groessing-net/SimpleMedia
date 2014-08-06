<?php
/**
 * SimpleMedia.
 *
 * @copyright Erik Spaan & Axel Guckelsberger (ESP)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Erik Spaan & Axel Guckelsberger <erik@zikula.nl>.
 * @link https://github.com/zikula-ev/SimpleMedia
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de).
 */

/**
 * Event handler base class for module installer events.
 */
class SimpleMedia_Listener_Base_Installer
{
    /**
     * Listener for the `installer.module.installed` event.
     *
     * Called after a module has been successfully installed.
     * Receives `$modinfo` as args.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function moduleInstalled(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `installer.module.upgraded` event.
     *
     * Called after a module has been successfully upgraded.
     * Receives `$modinfo` as args.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function moduleUpgraded(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `installer.module.uninstalled` event.
     *
     * Called after a module has been successfully uninstalled.
     * Receives `$modinfo` as args.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function moduleUninstalled(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `installer.subscriberarea.uninstalled` event.
     *
     * Called after a hook subscriber area has been unregistered.
     * Receives args['areaid'] as the areaId. Use this to remove orphan data associated with this area.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function subscriberAreaUninstalled(Zikula_Event $event)
    {
    }
}
