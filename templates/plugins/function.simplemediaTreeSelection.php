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
 * The simplemediaTreeSelection plugin retrieves tree entities based on a given one.
 *
 * Available parameters:
 *   - objectType:   Name of treated object type.
 *   - node:         Given entity as tree entry point.
 *   - target:       One of 'allParents', 'directParent', 'allChildren', 'directChildren', 'predecessors', 'successors', 'preandsuccessors'
 *   - skipRootNode: Whether root nodes are skipped or not (defaults to true). Useful for when working with many trees at once.
 *   - assign:       Variable where the results are assigned to.
 *
 * @param  array       $params All attributes passed to this function from the template.
 * @param  Zikula_View $view   Reference to the view object.
 */
function smarty_function_simplemediaTreeSelection($params, $view)
{
    if (!isset($params['objectType']) || empty($params['objectType'])) {
        $view->trigger_error(__f('Error! in %1$s: the %2$s parameter must be specified.', array('simplemediaTreeSelection', 'objectType')));

        return false;
    }

    if (!isset($params['node']) || !is_object($params['node'])) {
        $view->trigger_error(__f('Error! in %1$s: the %2$s parameter must be specified.', array('simplemediaTreeSelection', 'node')));

        return false;
    }

    $allowedTargets = array('allParents', 'directParent', 'allChildren', 'directChildren', 'predecessors', 'successors', 'preandsuccessors');
    if (!isset($params['target']) || empty($params['target']) || !in_array($params['target'], $allowedTargets)) {
        $view->trigger_error(__f('Error! in %1$s: the %2$s parameter must be specified.', array('simplemediaTreeSelection', 'target')));

        return false;
    }

    $skipRootNode = (isset($params['skipRootNode']) ? (bool) $params['skipRootNode'] : true);

    if (!isset($params['assign']) || empty($params['assign'])) {
        $view->trigger_error(__f('Error! in %1$s: the %2$s parameter must be specified.', array('simplemediaTreeSelection', 'assign')));

        return false;
    }

    $entityClass = 'SimpleMedia_Entity_' . ucwords($params['objectType']);
    $serviceManager = ServiceUtil::getManager();
    $entityManager = $serviceManager->getService('doctrine.entitymanager');
    $repository = $entityManager->getRepository($entityClass);
    $titleFieldName = $repository->getTitleFieldName();

    $node = $params['node'];
    $result = null;

    switch ($params['target']) {
        case 'allParents':
        case 'directParent':
            $path = $repository->getPath($node);
            if (count($path) > 0) {
                // remove $node
                unset($path[count($path)-1]);
            }
            if ($skipRootNode && count($path) > 0) {
                // remove root level
                array_shift($path);
            }
            if ($params['target'] == 'allParents') {
                $result = $path;
            } elseif ($params['target'] == 'directParent' && count($path) > 0) {
                $result = $path[count($path)-1];
            }
            break;
        case 'allChildren':
        case 'directChildren':
            $direct = ($params['target'] == 'directChildren');
            $sortByField = ($titleFieldName != '') ? $titleFieldName : null;
            $sortDirection = 'ASC';
            $result = $repository->children($node, $direct, $sortByField, $sortDirection);
            break;
        case 'predecessors':
            $includeSelf = false;
            $result = $repository->getPrevSiblings($node, $includeSelf);
            break;
        case 'successors':
            $includeSelf = false;
            $result = $repository->getNextSiblings($node, $includeSelf);
            break;
        case 'preandsuccessors':
            $includeSelf = false;
            $result = array_merge($repository->getPrevSiblings($node, $includeSelf), $repository->getNextSiblings($node, $includeSelf));
            break;
    }

    $view->assign($params['assign'], $result);
}
