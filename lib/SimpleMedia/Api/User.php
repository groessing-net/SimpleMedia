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
 * This is the User api helper class.
 */
class SimpleMedia_Api_User extends SimpleMedia_Api_Base_User
{
    // feel free to add own api methods here

    /**
     * Returns available user panel links.
	 * OVERRIDE:
     * CHECK
	 * - removed direct media viewing, always via collections
	 * - Removed tree from the collection template, since that is not usefull in the frontend.
     *
     * @return array Array of user links.
     */
    public function getlinks()
    {
        $links = array();

        if (SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            $links[] = array('url' => ModUtil::url($this->name, 'admin', 'main'),
                             'text' => $this->__('Backend'),
                             'title' => $this->__('Switch to administration area.'),
                             'class' => 'z-icon-es-options');
        }

        $controllerHelper = new SimpleMedia_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'user', 'action' => 'getlinks');
        $allowedObjectTypes = $controllerHelper->getObjectTypes('api', $utilArgs);

        if (in_array('collection', $allowedObjectTypes)
            && SecurityUtil::checkPermission($this->name . ':Collection:', '::', ACCESS_READ)) {
            $links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'collection')),
                             'text' => $this->__('Collections'),
                             'title' => $this->__('Collection list'));
        }
        /*
        if (in_array('medium', $allowedObjectTypes)
            && SecurityUtil::checkPermission($this->name . ':Medium:', '::', ACCESS_READ)) {
            $links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'medium')),
                             'text' => $this->__('Media'),
                             'title' => $this->__('Medium list'));
        }
        */
        if (in_array('medium', $allowedObjectTypes)
            && SecurityUtil::checkPermission($this->name . ':Medium:', '::', ACCESS_ADD)) {
            $links[] = array('url' => ModUtil::url($this->name, 'user', 'multiUpload'),
                'text' => $this->__('MultiUpload'),
                'title' => $this->__('Upload several Media at once'));
        }

        return $links;
    }
}
