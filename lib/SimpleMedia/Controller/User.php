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
 * This is the User controller class providing navigation and interaction functionality.
 */
class SimpleMedia_Controller_User extends SimpleMedia_Controller_Base_User
{
    // feel free to add your own controller methods here

    /**
     * This method is the default function handling the user area called without defining arguments.
	 * OVERRIDE: collection is now default ot
     *
     *
     * @return mixed Output.
     */
    public function main()
    {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_OVERVIEW), LogUtil::getErrorMsgPermission());
        return $this->redirect(ModUtil::url($this->name, 'user', 'view', array('ot' => 'collection', 'tpl' => 'grid')));
    }

    /**
     * This method provides a generic item list overview.
     * OVERRIDE, added where for collections to only list level 0 collections in
     * regular view .
     *
     * @param string  $ot           Treated object type.
     * @param string  $sort         Sorting field.
     * @param string  $sortdir      Sorting direction.
     * @param int     $pos          Current pager position.
     * @param int     $num          Amount of entries to display.
     * @param string  $tpl          Name of alternative template (for alternative display options, feeds and xml output)
     * @param boolean $raw          Optional way to display a template instead of fetching it (needed for standalone output)
     *
     * @return mixed Output.
     */
    public function view()
    {
        $controllerHelper = new SimpleMedia_Util_Controller($this->serviceManager);

        // parameter specifying which type of objects we are treating
        $objectType = $this->request->query->filter('ot', 'medium', FILTER_SANITIZE_STRING);
        $utilArgs = array('controller' => 'user', 'action' => 'view');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $utilArgs);
        }
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', '::', ACCESS_READ), LogUtil::getErrorMsgPermission());
        $entityClass = $this->name . '_Entity_' . ucwords($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
        $repository->setControllerArguments(array());
        $viewHelper = new SimpleMedia_Util_View($this->serviceManager);

        $tpl = $this->request->query->filter('tpl', '', FILTER_SANITIZE_STRING);
        if ($tpl == 'tree') {
            $trees = ModUtil::apiFunc($this->name, 'selection', 'getAllTrees', array('ot' => $objectType));
            $this->view->assign('trees', $trees)
                ->assign($repository->getAdditionalTemplateParameters('controllerAction', $utilArgs));
            // fetch and return the appropriate template
            return $viewHelper->processTemplate($this->view, 'user', $objectType, 'view', array());
        }

        // parameter for used sorting field
        $sort = $this->request->query->filter('sort', '', FILTER_SANITIZE_STRING);
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }

        // parameter for used sort order
        $sdir = $this->request->query->filter('sortdir', '', FILTER_SANITIZE_STRING);
        $sdir = strtolower($sdir);
        if ($sdir != 'asc' && $sdir != 'desc') {
            $sdir = 'asc';
        }

        // convenience vars to make code clearer
        $currentUrlArgs = array('ot' => $objectType);

        $where = '';

        // OVERRIDE: only show level=0 collections in view template, espaan
        if ($objectType = 'collection') {
            $where .= 'tbl.lvl=0';
        }

        $selectionArgs = array(
            'ot' => $objectType,
            'where' => $where,
            'orderBy' => $sort . ' ' . $sdir
        );

        $showOwnEntries = (int) $this->request->query->filter('own', $this->getVar('showOnlyOwnEntries', 0), FILTER_VALIDATE_INT);
        $showAllEntries = (int) $this->request->query->filter('all', 0, FILTER_VALIDATE_INT);

        if (!$showAllEntries) {
            $csv = (int) $this->request->query->filter('usecsvext', 0, FILTER_VALIDATE_INT);
            if ($csv == 1) {
                $showAllEntries = 1;
            }
        }

        $this->view->assign('showOwnEntries', $showOwnEntries)
            ->assign('showAllEntries', $showAllEntries);
        if ($showOwnEntries == 1) {
            $currentUrlArgs['own'] = 1;
        }
        if ($showAllEntries == 1) {
            $currentUrlArgs['all'] = 1;
        }

        // prepare access level for cache id
        $accessLevel = ACCESS_READ;
        $component = 'SimpleMedia:' . ucwords($objectType) . ':';
        $instance = '::';
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_COMMENT)) {
            $accessLevel = ACCESS_COMMENT;
        }
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
            $accessLevel = ACCESS_EDIT;
        }

        $templateFile = $viewHelper->getViewTemplate($this->view, 'user', $objectType, 'view', array());
        $cacheId = 'view|ot_' . $objectType . '_sort_' . $sort . '_' . $sdir;
        $resultsPerPage = 0;
        if ($showAllEntries == 1) {
            // set cache id
            $this->view->setCacheId($cacheId . '_all_1_own_' . $showOwnEntries . '_' . $accessLevel);

            // if page is cached return cached content
            if ($this->view->is_cached($templateFile)) {
                return $viewHelper->processTemplate($this->view, 'user', $objectType, 'view', array(), $templateFile);
            }

            // retrieve item list without pagination
            $entities = ModUtil::apiFunc($this->name, 'selection', 'getEntities', $selectionArgs);
        } else {
            // the current offset which is used to calculate the pagination
            $currentPage = (int) $this->request->query->filter('pos', 1, FILTER_VALIDATE_INT);

            // the number of items displayed on a page for pagination
            $resultsPerPage = (int) $this->request->query->filter('num', 0, FILTER_VALIDATE_INT);
            if ($resultsPerPage == 0) {
                $resultsPerPage = $this->getVar('pageSize', 10);
            }

            // set cache id
            $this->view->setCacheId($cacheId . '_amount_' . $resultsPerPage . '_page_' . $currentPage . '_own_' . $showOwnEntries . '_' . $accessLevel);

            // if page is cached return cached content
            if ($this->view->is_cached($templateFile)) {
                return $viewHelper->processTemplate($this->view, 'user', $objectType, 'view', array(), $templateFile);
            }

            // retrieve item list with pagination
            $selectionArgs['currentPage'] = $currentPage;
            $selectionArgs['resultsPerPage'] = $resultsPerPage;
            list($entities, $objectCount) = ModUtil::apiFunc($this->name, 'selection', 'getEntitiesPaginated', $selectionArgs);

            $this->view->assign('currentPage', $currentPage)
                ->assign('pager', array('numitems'     => $objectCount,
                    'itemsperpage' => $resultsPerPage));
        }

        foreach ($entities as $k => $entity) {
            $entity->initWorkflow();
        }

        // build ModUrl instance for display hooks
        $currentUrlObject = new Zikula_ModUrl($this->name, 'user', 'view', ZLanguage::getLanguageCode(), $currentUrlArgs);

        // assign the object data, sorting information and details for creating the pager
        $this->view->assign('items', $entities)
            ->assign('sort', $sort)
            ->assign('sdir', $sdir)
            ->assign('pageSize', $resultsPerPage)
            ->assign('currentUrlObject', $currentUrlObject)
            ->assign($repository->getAdditionalTemplateParameters('controllerAction', $utilArgs));

        $modelHelper = new SimpleMedia_Util_Model($this->serviceManager);
        $this->view->assign('canBeCreated', $modelHelper->canBeCreated($objectType));

        // fetch and return the appropriate template
        return $viewHelper->processTemplate($this->view, 'user', $objectType, 'view', array(), $templateFile);
    }


    /**
     * This method provides a generic item detail view.
     * OVERRIDE: added counting views when entity is being displayed
     *
     * @param string  $ot           Treated object type.
     * @param string  $tpl          Name of alternative template (for alternative display options, feeds and xml output)
     * @param boolean $raw          Optional way to display a template instead of fetching it (needed for standalone output)
     *
     * @return mixed Output.
     */
    public function display()
    {
        $controllerHelper = new SimpleMedia_Util_Controller($this->serviceManager);

        // parameter specifying which type of objects we are treating
        $objectType = $this->request->query->filter('ot', 'medium', FILTER_SANITIZE_STRING);
        $utilArgs = array('controller' => 'user', 'action' => 'display');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $utilArgs);
        }
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', '::', ACCESS_READ), LogUtil::getErrorMsgPermission());
        $entityClass = $this->name . '_Entity_' . ucwords($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
        $repository->setControllerArguments(array());

        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));

        // retrieve identifier of the object we wish to view
        $idValues = $controllerHelper->retrieveIdentifier($this->request, array(), $objectType, $idFields);
        $hasIdentifier = $controllerHelper->isValidIdentifier($idValues);

        // check for unique permalinks (without id)
        $hasSlug = false;
        $slug = '';
        if ($hasIdentifier === false) {
            $entityClass = $this->name . '_Entity_' . ucwords($objectType);
            $meta = $this->entityManager->getClassMetadata($entityClass);
            $hasSlug = $meta->hasField('slug') && $meta->isUniqueField('slug');
            if ($hasSlug) {
                $slug = $this->request->query->filter('slug', '', FILTER_SANITIZE_STRING);
                $hasSlug = (!empty($slug));
            }
        }
        $hasIdentifier |= $hasSlug;
        $this->throwNotFoundUnless($hasIdentifier, $this->__('Error! Invalid identifier received.'));

        $entity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $idValues, 'slug' => $slug));
        $this->throwNotFoundUnless($entity != null, $this->__('No such item.'));
        unset($idValues);

        $entity->initWorkflow();

        // build ModUrl instance for display hooks; also create identifier for permission check
        $currentUrlArgs = array('ot' => $objectType);
        $instanceId = '';
        foreach ($idFields as $idField) {
            $currentUrlArgs[$idField] = $entity[$idField];
            if (!empty($instanceId)) {
                $instanceId .= '_';
            }
            $instanceId .= $entity[$idField];
        }
        $currentUrlArgs['id'] = $instanceId;
        if (isset($entity['slug'])) {
            $currentUrlArgs['slug'] = $entity['slug'];
        }
        $currentUrlObject = new Zikula_ModUrl($this->name, 'user', 'display', ZLanguage::getLanguageCode(), $currentUrlArgs);

        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', $instanceId . '::', ACCESS_READ), LogUtil::getErrorMsgPermission());

        $viewHelper = new SimpleMedia_Util_View($this->serviceManager);
        $templateFile = $viewHelper->getViewTemplate($this->view, 'user', $objectType, 'display', array());

        // set cache id
        $component = $this->name . ':' . ucwords($objectType) . ':';
        $instance = $instanceId . '::';
        $accessLevel = ACCESS_READ;
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_COMMENT)) {
            $accessLevel = ACCESS_COMMENT;
        }
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
            $accessLevel = ACCESS_EDIT;
        }
        $this->view->setCacheId($objectType . '|' . $instanceId . '|a' . $accessLevel);

        // ADDED Increase the viewscount of the displayed entity if configured and not being the creator
        if ((($objectType == 'medium' && $this->getVar('countMediumViews', true)) || ($objectType == 'collection' && $this->getVar('countCollectionViews', true))) && ($entity->getCreatedUserId() != UserUtil::getVar('uid') || UserUtil::isLoggedIn() == false)) {
            $entity->setViewsCount($entity->getViewsCount() + 1);
            // Doctrine flushing needed here
            $entityManager = ServiceUtil::getService('doctrine.entitymanager');
            $entityManager->persist($entity);
            $entityManager->flush();
        }

        // assign output data to view object.
        $this->view->assign($objectType, $entity)
            ->assign('currentUrlObject', $currentUrlObject)
            ->assign($repository->getAdditionalTemplateParameters('controllerAction', $utilArgs));

        // fetch and return the appropriate template
        return $viewHelper->processTemplate($this->view, 'user', $objectType, 'display', array(), $templateFile);
    }

}
