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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Mon Nov 05 23:27:05 CET 2012.
 */

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for collection entities.
 * @Gedmo\TranslationEntity(class="SimpleMedia_Entity_CollectionTranslation")
 * @Gedmo\Tree(type="nested")
 * @ORM\Entity(repositoryClass="SimpleMedia_Entity_Repository_Collection")
 * @ORM\Table(name="simmed_collection")
 * @ORM\HasLifecycleCallbacks
 */
class SimpleMedia_Entity_Collection extends SimpleMedia_Entity_Base_Collection
{
    // feel free to add your own methods here

    
    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     *
     * @ORM\PostLoad
     * @see SimpleMedia_Entity_Base_Collection::performPostLoadCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPrePersistCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPostPersistCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPreRemoveCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPostRemoveCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPreUpdateCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPostUpdateCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPreSaveCallback()
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
     * @see SimpleMedia_Entity_Base_Collection::performPostSaveCallback()
     * @return void.
     */
    public function postSaveCallback()
    {
        $this->performPostSaveCallback();
    }
    
}
