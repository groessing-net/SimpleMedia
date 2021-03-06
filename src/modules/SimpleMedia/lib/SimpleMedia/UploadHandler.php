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
 * Upload handler implementation class.
 */
class SimpleMedia_UploadHandler extends SimpleMedia_Base_UploadHandler
{
    // feel free to add your upload handler enhancements here
    /**
     * Determines the allowed file extensions for a given object type.
     *
     * @param string $objectType Currently treated entity type.
     * @param string $fieldName  Name of upload field.
     * @param string $extension  Input file extension.
     *
     * @return array the list of allowed file extensions
     */
    protected function isAllowedFileExtension($objectType, $fieldName, $extension)
    {
        // determine the allowed extensions
        $allowedExtensions = array();
        switch ($objectType) {
            case 'medium':
                //$allowedExtensions = array('gif', 'jpeg', 'jpg', 'png', 'pdf', 'doc', 'xls', 'ppt', 'docx', 'xlsx', 'pptx', 'odt', 'ods', 'odp', 'arj', 'zip', 'rar', 'tar', 'tgz', 'gz', 'bz2', 'txt', 'rtf', 'swf', 'flv', 'mp3', 'mp4', 'avi', 'mpg', 'mpeg', 'mov');
                $allowedExtensions = explode(',', str_replace(' ', '', ModUtil::getVar('SimpleMedia', 'allowedExtensions')));
                    break;
        }
    
        if (count($allowedExtensions) > 0) {
            if (!in_array($extension, $allowedExtensions)) {
                return false;
            }
        }
    
        if (in_array($extension, $this->forbiddenFileTypes)) {
            return false;
        }
    
        return true;
    }
}
