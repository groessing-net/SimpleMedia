<?php
/**
 * SimpleMedia.
 *
 * @copyright Axel Guckelsberger
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Gabriel Freinbichler <info@guite.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 */

define("SIMPLEMEDIA_CROPPINGMODE_ENFORCED_SIZE_ENFORCED_PROPORTIONS", "1");
define("SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_ENFORCED_PROPORTIONS", "2");
define("SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_VARIABLE_PROPORTIONS", "3");

/**
 * Utility implementation class for view helper methods.
 */
class SimpleMedia_Util_Manual 
{
    /**
     * Get list of crop size modes.
     */
    public function getCropSizeModes()
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');

        $modes = array();
        $modes[] = array('value' => SIMPLEMEDIA_CROPPINGMODE_ENFORCED_SIZE_ENFORCED_PROPORTIONS,     'text' => __('Enforced thumbnail size', $dom));
        $modes[] = array('value' => SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_ENFORCED_PROPORTIONS,     'text' => __('Variable size, but enforced image proportions', $dom));
        $modes[] = array('value' => SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_VARIABLE_PROPORTIONS,     'text' => __('Variable size and image proportions', $dom));

        return $modes;
    }
}