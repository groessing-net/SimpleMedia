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
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Event handler implementation class for error-related events.
 */
class SimpleMedia_Listener_Errors extends SimpleMedia_Listener_Base_Errors
{
    /**
     * Listener for the `setup.errorreporting` event.
     *
     * Invoked during `System::init()`.
     * Used to activate `set_error_handler()`.
     * Event must `stop()`.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function setupErrorReporting(Zikula_Event $event)
    {
        parent::setupErrorReporting($event);
    }
    
    /**
     * Listener for the `systemerror` event.
     *
     * Invoked on any system error.
     * args gets `array('errorno' => $errno, 'errstr' => $errstr, 'errfile' => $errfile, 'errline' => $errline, 'errcontext' => $errcontext)`.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function systemError(Zikula_Event $event)
    {
        parent::systemError($event);
    }
}
