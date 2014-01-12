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
 * The simplemediaObjectState modifier displays the name of a given object's workflow state.
 * Examples:
 *    {$item.workflowState|simplemediaObjectState}       {* with visual feedback *}
 *    {$item.workflowState|simplemediaObjectState:false} {* no ui feedback *}
 *
 * @param string  $state      Name of given workflow state.
 * @param boolean $uiFeedback Whether the output should include some visual feedback about the state.
 *
 * @return string Enriched and translated workflow state ready for display.
 */
function smarty_modifier_simplemediaObjectState($state = 'initial', $uiFeedback = true)
{
    $serviceManager = ServiceUtil::getManager();
    $workflowHelper = new SimpleMedia_Util_Workflow($serviceManager);
    $stateInfo = $workflowHelper->getStateInfo($state);

    $result = $stateInfo['text'];
    if ($uiFeedback === true) {
        $result = '<img src="' . System::getBaseUrl() . 'images/icons/extrasmall/' . $stateInfo['ui'] . 'led.png" width="16" height="16" alt="' . $result . '" />&nbsp;&nbsp;' . $result;
    }

    return $result;
}
