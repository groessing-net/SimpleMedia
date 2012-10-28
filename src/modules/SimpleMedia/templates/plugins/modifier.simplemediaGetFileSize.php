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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Sat Oct 27 20:20:23 CEST 2012.
 */

/**
 * The simplemediaGetFileSize modifier displays the size of a given file in a readable way.
 *
 * @param integer $size     File size in bytes.
 * @param string  $filepath The input file path including file name (if file size is not known).
 * @param boolean $nodesc   If set to true the description will not be appended.
 * @param boolean $onlydesc If set to true only the description will be returned.
 *
 * @return string File size in a readable form.
 */
function smarty_modifier_simplemediaGetFileSize($size = 0, $filepath = '', $nodesc = false, $onlydesc = false)
{
    if (!is_numeric($size)) {
        $size = (int) $size;
    }
    if (!$size) {
        if (empty($filepath) || !file_exists($filepath)) {
            return '';
        }
        $size = filesize($filepath);
    }
    if (!$size) {
        return '';
    }

    $serviceManager = ServiceUtil::getManager();
    $viewHelper = new SimpleMedia_Util_View($serviceManager);
    $result = $viewHelper->getReadableFileSize($size, $nodesc, $onlydesc);

    return $result;
}
