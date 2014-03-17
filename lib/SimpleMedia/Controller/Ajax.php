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
 * This is the Ajax controller class providing navigation and interaction functionality.
 */
class SimpleMedia_Controller_Ajax extends SimpleMedia_Controller_Base_Ajax
{
    // feel free to add your own controller methods here
	
	/**
	 * Performs different operations on tree hierarchies.
	 * OVERRIDE: updated descriptionFieldName to description
	 *
	 * @param string $ot        Treated object type.
	 * @param string $op        The operation which should be performed (addRootNode, addChildNode, deleteNode, moveNode, moveNodeTo).
	 * @param int    $id        Identifier of treated node (not for addRootNode and addChildNode).
	 * @param int    $pid       Identifier of parent node (only for addChildNode).
	 * @param string $direction The target direction for a move action (only for moveNode [up, down] and moveNodeTo [after, before, bottom]).
	 * @param int    $destid    Identifier of destination node for (only for moveNodeTo).
	 *
	 * @return Zikula_Response_Ajax
	 *
	 * @throws Zikula_Exception_Ajax_Fatal
	 */
	public function handleTreeOperation()
	{
		$this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . '::Ajax', '::', ACCESS_EDIT));
	
		$postData = $this->request->request;
	
		// parameter specifying which type of objects we are treating
		$objectType = DataUtil::convertFromUTF8($postData->filter('ot', 'collection', FILTER_SANITIZE_STRING));
		// ensure that we use only object types with tree extension enabled
		if (!in_array($objectType, array('collection'))) {
			$objectType = 'collection';
		}
	
		$op = DataUtil::convertFromUTF8($postData->filter('op', '', FILTER_SANITIZE_STRING));
		if (!in_array($op, array('addRootNode', 'addChildNode', 'deleteNode', 'moveNode', 'moveNodeTo'))) {
			throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid operation.'));
		}
		
		// Get id of treated node
		$id = 0;
		if (!in_array($op, array('addRootNode', 'addChildNode'))) {
			$id = (int) $postData->filter('id', 0, FILTER_VALIDATE_INT);
			if (!$id) {
				throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid node.'));
			}
		}
	
		$returnValue = array(
			'data'    => array(),
			'message' => ''
		);
	
		$entityClass = 'SimpleMedia_Entity_' . ucfirst($objectType);
		$repository = $this->entityManager->getRepository($entityClass);
	
		$rootId = 1;
		if (!in_array($op, array('addRootNode'))) {
			$rootId = (int) $postData->filter('root', 0, FILTER_VALIDATE_INT);
			if (!$rootId) {
				throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid root node.'));
			}
		}
	
		// Select tree
		$tree = null;
		if (!in_array($op, array('addRootNode'))) {
			$tree = ModUtil::apiFunc($this->name, 'selection', 'getTree', array('ot' => $objectType, 'rootId' => $rootId));
		}
	
		// verification and recovery of tree
		$verificationResult = $repository->verify();
		if (is_array($verificationResult)) {
			foreach ($verificationResult as $errorMsg) {
				LogUtil::registerError($errorMsg);
			}
		}
		$repository->recover();
		$this->entityManager->clear(); // clear cached nodes
	
		$titleFieldName = $descriptionFieldName = '';
		
		switch ($objectType) {
			case 'collection':
					$titleFieldName = 'title';
					$descriptionFieldName = 'description';
					break;
		}
	
		switch ($op) {
			case 'addRootNode':
							//$this->entityManager->transactional(function($entityManager) {
								$entity = new $entityClass();
								$entityData = array();
								if (!empty($titleFieldName)) {
									$entityData[$titleFieldName] = $this->__('New root node');
								}
								if (!empty($descriptionFieldName)) {
									$entityData[$descriptionFieldName] = $this->__('This is a new root node');
								}
								$entity->merge($entityData);
								
							
								// save new object to set the root id
								$action = 'submit';
								try {
									// execute the workflow action
									$workflowHelper = new SimpleMedia_Util_Workflow($this->serviceManager);
									$success = $workflowHelper->executeAction($entity, $action);
								} catch(\Exception $e) {
									LogUtil::registerError($this->__f('Sorry, but an unknown error occured during the %s action. Please apply the changes again!', array($action)));
								}
							//});
		
							break;
			case 'addChildNode':
							$parentId = (int) $postData->filter('pid', 0, FILTER_VALIDATE_INT);
							if (!$parentId) {
								throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid parent node.'));
							}
							
							//$this->entityManager->transactional(function($entityManager) {
								$childEntity = new $entityClass();
								$entityData = array();
								$entityData[$titleFieldName] = $this->__('New child node');
								if (!empty($descriptionFieldName)) {
									$entityData[$descriptionFieldName] = $this->__('This is a new child node');
								}
								$childEntity->merge($entityData);
							
								// save new object
								$action = 'submit';
								try {
									// execute the workflow action
									$workflowHelper = new SimpleMedia_Util_Workflow($this->serviceManager);
									$success = $workflowHelper->executeAction($childEntity, $action);
								} catch(\Exception $e) {
									LogUtil::registerError($this->__f('Sorry, but an unknown error occured during the %s action. Please apply the changes again!', array($action)));
								}
							
								//$childEntity->setParent($parentEntity);
								$parentEntity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $parentId, 'useJoins' => false));
								if ($parentEntity == null) {
									return new Zikula_Response_Ajax_NotFound($this->__('No such item.'));
								}
								$repository->persistAsLastChildOf($childEntity, $parentEntity);
							//});
							$this->entityManager->flush();
							break;
			case 'deleteNode':
							// remove node from tree and reparent all children
							$entity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $id, 'useJoins' => false));
							if ($entity == null) {
								return new Zikula_Response_Ajax_NotFound($this->__('No such item.'));
							}
							
							$entity->initWorkflow();
							
							// delete the object
							$action = 'delete';
							try {
								// execute the workflow action
								$workflowHelper = new SimpleMedia_Util_Workflow($this->serviceManager);
								$success = $workflowHelper->executeAction($entity, $action);
							} catch(\Exception $e) {
								LogUtil::registerError($this->__f('Sorry, but an unknown error occured during the %s action. Please apply the changes again!', array($action)));
							}
							
							$repository->removeFromTree($entity);
							$this->entityManager->clear(); // clear cached nodes
		
							break;
			case 'moveNode':
							$moveDirection = $postData->filter('direction', '', FILTER_SANITIZE_STRING);
							if (!in_array($moveDirection, array('up', 'down'))) {
								throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid direction.'));
							}
							
							$entity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $id, 'useJoins' => false));
							if ($entity == null) {
								return new Zikula_Response_Ajax_NotFound($this->__('No such item.'));
							}
							
							if ($moveDirection == 'up') {
								$repository->moveUp($entity, 1);
							} else if ($moveDirection == 'down') {
								$repository->moveDown($entity, 1);
							}
							$this->entityManager->flush();
		
							break;
			case 'moveNodeTo':
							$moveDirection = $postData->filter('direction', '', FILTER_SANITIZE_STRING);
							if (!in_array($moveDirection, array('after', 'before', 'bottom'))) {
								throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid direction.'));
							}
							
							$destId = (int) $postData->filter('destid', 0, FILTER_VALIDATE_INT);
							if (!$destId) {
								throw new Zikula_Exception_Ajax_Fatal($this->__('Error: invalid destination node.'));
							}
							
							//$this->entityManager->transactional(function($entityManager) {
								$entity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $id, 'useJoins' => false));
								$destEntity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $destId, 'useJoins' => false));
								if ($entity == null || $destEntity == null) {
									return new Zikula_Response_Ajax_NotFound($this->__('No such item.'));
								}
							
								if ($moveDirection == 'after') {
									$repository->persistAsNextSiblingOf($entity, $destEntity);
								} elseif ($moveDirection == 'before') {
									$repository->persistAsPrevSiblingOf($entity, $destEntity);
								} elseif ($moveDirection == 'bottom') {
									$repository->persistAsLastChildOf($entity, $destEntity);
								}
								$this->entityManager->flush();
							//});
		
							break;
		}
	
		$returnValue['message'] = $this->__('The operation was successful.');
	
		// Renew tree
		/** postponed, for now we do a page reload
		$returnValue['data'] = ModUtil::apiFunc($this->name, 'selection', 'getTree', array('ot' => $objectType, 'rootId' => $rootId));
		*/
	
		return new Zikula_Response_Ajax($returnValue);
	}
}
