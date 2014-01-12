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
 * Delete operation.
 * @param object $entity The treated object.
 * @param array  $params Additional arguments.
 *
 * @return bool False on failure or true if everything worked well.
 */
function SimpleMedia_operation_delete(&$entity, $params)
{
    $dom = ZLanguage::getModuleDomain('SimpleMedia');


    // initialise the result flag
    $result = false;

    // get entity manager
    $serviceManager = ServiceUtil::getManager();
    $entityManager = $serviceManager->getService('doctrine.entitymanager');
    
    // delete entity
    try {
        $entityManager->remove($entity);
        $entityManager->flush();
        $result = true;
    } catch (\Exception $e) {
        LogUtil::registerError($e->getMessage());
    }

    // return result of this operation
    return $result;
}
