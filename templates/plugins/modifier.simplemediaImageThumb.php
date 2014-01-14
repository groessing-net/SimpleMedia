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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Mon Nov 05 23:27:06 CET 2012.
 */

/**
 * The simplemediaImageThumb modifier displays a thumbnail image.
 *
 * @param string $filePath   The input file path (including the file name).
 * @param string $objectType Currently treated entity type.
 * @param string $fieldName  Name of upload field.
 * @param int    $width      Desired width.
 * @param int    $height     Desired height.
 * @param array  $thumbArgs  Additional arguments.
 *
 * @return string The thumbnail file path.
 */
function smarty_modifier_simplemediaImageThumb($filePath = '', $objectType = '', $fieldName = '', $width = 100, $height = 80, $thumbArgs = array())
{
    $serviceManager = ServiceUtil::getManager();
    $imageHelper = new SimpleMedia_Util_Image($serviceManager);

    /**
     * By overriding this plugin or the util method called below you may add further thumbnail arguments
     * based on custom conditions.
     */
    return $imageHelper->getThumb($filePath, $objectType, $fieldName, $width, $height, $thumbArgs);
}