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

/**
 * Entity extension domain class storing medium attributes.
 *
 * This is the base attribute class for medium entities.
 */
class SimpleMedia_Entity_Base_MediumAttribute extends Zikula_Doctrine2_Entity_EntityAttribute
{
    /**
     * @ORM\ManyToOne(targetEntity="SimpleMedia_Entity_Medium", inversedBy="attributes")
     * @ORM\JoinColumn(name="entityId", referencedColumnName="id")
     * @var SimpleMedia_Entity_Medium
     */
    protected $entity;

    /**
     * Get reference to owning entity.
     *
     * @return SimpleMedia_Entity_Medium
     */
    public function getEntity()
    {
        return $this->entity;
    }

    /**
     * Set reference to owning entity.
     *
     * @param SimpleMedia_Entity_Medium $entity
     */
    public function setEntity(/*SimpleMedia_Entity_Medium */$entity)
    {
        $this->entity = $entity;
    }
}
