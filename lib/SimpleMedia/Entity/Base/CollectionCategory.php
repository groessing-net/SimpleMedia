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

use Doctrine\ORM\Mapping as ORM;

/**
 * Entity extension domain class storing collection categories.
 *
 * This is the base category class for collection entities.
 */
class SimpleMedia_Entity_Base_CollectionCategory extends Zikula_Doctrine2_Entity_EntityCategory
{
    /**
     * @ORM\ManyToOne(targetEntity="SimpleMedia_Entity_Collection", inversedBy="categories")
     * @ORM\JoinColumn(name="entityId", referencedColumnName="id")
     * @var SimpleMedia_Entity_Collection
     */
    protected $entity;

    /**
     * Get reference to owning entity.
     *
     * @return SimpleMedia_Entity_Collection
     */
    public function getEntity()
    {
        return $this->entity;
    }
    
    /**
     * Set reference to owning entity.
     *
     * @param SimpleMedia_Entity_Collection $entity
     */
    public function setEntity(/*SimpleMedia_Entity_Collection */$entity)
    {
        $this->entity = $entity;
    }
}
