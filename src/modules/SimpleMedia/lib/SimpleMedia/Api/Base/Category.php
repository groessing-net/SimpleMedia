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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Sat Oct 27 20:20:22 CEST 2012.
 */

/**
 * Category api base class.
 */
class SimpleMedia_Api_Base_Category extends Zikula_AbstractApi
{
    /**
     * Retrieves the main/default category of SimpleMedia.
     *
     * @param string $args['ot'] The object type to be treated (optional)
     *
     * @return mixed Category array on success, false on failure
     */
    public function getMainCat($args)
    {
        $objectType = $this->determineObjectType($args, 'getMainCat');
    
        return CategoryRegistryUtil::getRegisteredModuleCategory('SimpleMedia', ucwords($objectType), 'Main', 32); // 32 == /__System/Modules/Global
    }
    
    /**
     * Determine object type using controller util methods.
     *
     * @param string $args['ot'] The object type to retrieve (optional)
     * @param string $methodName Name of calling method
     */
    protected function determineObjectType($args, $methodName = '')
    {
        $objectType = isset($args['ot']) ? $args['ot'] : '';
        $controllerHelper = new SimpleMedia_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'category', 'action' => $methodName);
        if (!in_array($objectType, $controllerHelper->getObjectTypes('api', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('api', $utilArgs);
        }
        return $objectType;
    }
}