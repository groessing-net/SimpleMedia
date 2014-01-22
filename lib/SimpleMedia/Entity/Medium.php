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

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for medium entities.
 * @ORM\Entity(repositoryClass="SimpleMedia_Entity_Repository_Medium")
  * @ORM\Table(name="simmed_medium",
  *     indexes={
 *         @ORM\Index(name="workflowstateindex", columns={"workflowState"})
  *     }
  * )
 * @ORM\HasLifecycleCallbacks
 */
class SimpleMedia_Entity_Medium extends SimpleMedia_Entity_Base_Medium
{
    // feel free to add your own methods here

    /**
     * Collect available actions for this entity.
     * OVERRIDE: added extra actions
     */
    protected function prepareItemActions()
    {
        if (!empty($this->_actions)) {
            return;
        }

        $currentType = FormUtil::getPassedValue('type', 'user', 'GETPOST', FILTER_SANITIZE_STRING);
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
        if ($currentType == 'admin') {
            if (in_array($currentFunc, array('main', 'view'))) {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'medium', 'id' => $this['id'], 'slug' => $this->slug)),
                    'icon' => 'preview',
                    'linkTitle' => __('Open preview page', $dom),
                    'linkText' => __('Preview', $dom)
                );
                $this->_actions[] = array(
                    'url' => array('type' => 'admin', 'func' => 'display', 'arguments' => array('ot' => 'medium', 'id' => $this['id'], 'slug' => $this->slug)),
                    'icon' => 'display',
                    'linkTitle' => str_replace('"', '', $this->getTitleFromDisplayPattern()),
                    'linkText' => __('Details', $dom)
                );
            }
            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                $component = 'SimpleMedia:Medium:';
                $instance = $this->id . '::';
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'medium', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'medium', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                $this->_actions[] = array(
                    'url' => array('type' => 'admin', 'func' => 'view', 'arguments' => array('ot' => 'medium')),
                    'icon' => 'back',
                    'linkTitle' => __('Back to overview', $dom),
                    'linkText' => __('Back to overview', $dom)
                );
            }
        }
        if ($currentType == 'user') {
            if (in_array($currentFunc, array('main', 'view'))) {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'medium', 'id' => $this['id'], 'slug' => $this->slug)),
                    'icon' => 'display',
                    'linkTitle' => str_replace('"', '', $this->getTitleFromDisplayPattern()),
                    'linkText' => __('Details', $dom)
                );
            }
            if (in_array($currentFunc, array('main', 'view', 'display'))) {
            }
            if ($currentFunc == 'display') {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'view', 'arguments' => array('ot' => 'medium')),
                    'icon' => 'back',
                    'linkTitle' => __('Back to overview', $dom),
                    'linkText' => __('Back to overview', $dom)
                );
            }
        }
    }

    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     *
     * @ORM\PostLoad
     * @see SimpleMedia_Entity_Medium::performPostLoadCallback()
     * @return void.
     */
    public function postLoadCallback()
    {
        $this->performPostLoadCallback();
    }
    
    /**
     * Pre-Process the data prior to an insert operation.
     *
     * @ORM\PrePersist
     * @see SimpleMedia_Entity_Medium::performPrePersistCallback()
     * @return void.
     */
    public function prePersistCallback()
    {
        $this->performPrePersistCallback();
    }
    
    /**
     * Post-Process the data after an insert operation.
     *
     * @ORM\PostPersist
     * @see SimpleMedia_Entity_Medium::performPostPersistCallback()
     * @return void.
     */
    public function postPersistCallback()
    {
        $this->performPostPersistCallback();
    }
    
    /**
     * Pre-Process the data prior a delete operation.
     *
     * @ORM\PreRemove
     * @see SimpleMedia_Entity_Medium::performPreRemoveCallback()
     * @return void.
     */
    public function preRemoveCallback()
    {
        $this->performPreRemoveCallback();
    }
    
    /**
     * Post-Process the data after a delete.
     *
     * @ORM\PostRemove
     * @see SimpleMedia_Entity_Medium::performPostRemoveCallback()
     * @return void
     */
    public function postRemoveCallback()
    {
        $this->performPostRemoveCallback();
    }
    
    /**
     * Pre-Process the data prior to an update operation.
     *
     * @ORM\PreUpdate
     * @see SimpleMedia_Entity_Medium::performPreUpdateCallback()
     * @return void.
     */
    public function preUpdateCallback()
    {
        $this->performPreUpdateCallback();
    }
    
    /**
     * Post-Process the data after an update operation.
     *
     * @ORM\PostUpdate
     * @see SimpleMedia_Entity_Medium::performPostUpdateCallback()
     * @return void.
     */
    public function postUpdateCallback()
    {
        $this->performPostUpdateCallback();
    }
    
    /**
     * Pre-Process the data prior to a save operation.
     *
     * @ORM\PrePersist
     * @ORM\PreUpdate
     * @see SimpleMedia_Entity_Medium::performPreSaveCallback()
     * @return void.
     */
    public function preSaveCallback()
    {
        $this->performPreSaveCallback();
    }
    
    /**
     * Post-Process the data after a save operation.
     *
     * @ORM\PostPersist
     * @ORM\PostUpdate
     * @see SimpleMedia_Entity_Medium::performPostSaveCallback()
     * @return void.
     */
    public function postSaveCallback()
    {
        $this->performPostSaveCallback();
    }
    
}
