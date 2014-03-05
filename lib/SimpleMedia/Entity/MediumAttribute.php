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
 * Entity extension domain class storing medium attributes.
 *
 * This is the concrete attribute class for medium entities.
* @ORM\Entity(repositoryClass="SimpleMedia_Entity_Repository_MediumAttribute")
   * @ORM\Table(name="simmed_medium_attribute",
   *     uniqueConstraints={
   *         @ORM\UniqueConstraint(name="cat_unq", columns={"name", "entityId"})
   *     }
   * )
 */
class SimpleMedia_Entity_MediumAttribute extends SimpleMedia_Entity_Base_MediumAttribute
{
    // feel free to add your own methods here
}
