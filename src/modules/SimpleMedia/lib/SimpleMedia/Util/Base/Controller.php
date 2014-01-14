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
 * Utility base class for controller helper methods.
 */
class SimpleMedia_Util_Base_Controller extends Zikula_AbstractBase
{
    /**
     * Returns an array of all allowed object types in SimpleMedia.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, actionHandler, block, contentType, util).
     * @param array  $args    Additional arguments.
     *
     * @return array List of allowed object types.
     */
    public function getObjectTypes($context = '', $args = array())
    {
        if (!in_array($context, array('controllerAction', 'api', 'actionHandler', 'block', 'contentType', 'util'))) {
            $context = 'controllerAction';
        }
    
        $allowedObjectTypes = array();
        $allowedObjectTypes[] = 'medium';
        $allowedObjectTypes[] = 'collection';
    
        return $allowedObjectTypes;
    }

    /**
     * Returns the default object type in SimpleMedia.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, actionHandler, block, contentType, util).
     * @param array  $args    Additional arguments.
     *
     * @return string The name of the default object type.
     */
    public function getDefaultObjectType($context = '', $args = array())
    {
        if (!in_array($context, array('controllerAction', 'api', 'actionHandler', 'block', 'contentType', 'util'))) {
            $context = 'controllerAction';
        }
    
        $defaultObjectType = 'medium';
    
        return $defaultObjectType;
    }

    /**
     * Checks whether a certain entity type uses composite keys or not.
     *
     * @param string $objectType The object type to retrieve.
     *
     * @boolean Whether composite keys are used or not.
     */
    public function hasCompositeKeys($objectType)
    {
        switch ($objectType) {
            case 'medium':
                return false;
            case 'collection':
                return false;
                default:
                    return false;
        }
    }

    /**
     * Retrieve identifier parameters for a given object type.
     *
     * @param Zikula_Request_Http $request    Instance of Zikula_Request_Http.
     * @param array               $args       List of arguments used as fallback if request does not contain a field.
     * @param string              $objectType Name of treated entity type.
     * @param array               $idFields   List of identifier field names.
     *
     * @return array List of fetched identifiers.
     */
    public function retrieveIdentifier(Zikula_Request_Http $request, array $args, $objectType = '', array $idFields)
    {
        $idValues = array();
        foreach ($idFields as $idField) {
            $defaultValue = isset($args[$idField]) && is_numeric($args[$idField]) ? $args[$idField] : 0;
            if ($this->hasCompositeKeys($objectType)) {
                // composite key may be alphanumeric
                $id = $request->query->filter($idField, $defaultValue);
            } else {
                // single identifier
                $id = (int) $request->query->filter($idField, $defaultValue, FILTER_VALIDATE_INT);
            }
            // fallback if id has not been found yet
            if (!$id && $idField != 'id' && count($idFields) == 1) {
                $defaultValue = isset($args['id']) && is_numeric($args['id']) ? $args['id'] : 0;
                $id = (int) $request->query->filter('id', $defaultValue, FILTER_VALIDATE_INT);
            }
            $idValues[$idField] = $id;
        }
    
        return $idValues;
    }

    /**
     * Checks if all identifiers are set properly.
     *
     * @param array  $idValues List of identifier field values.
     *
     * @return boolean Whether all identifiers are set or not.
     */
    public function isValidIdentifier(array $idValues)
    {
        if (!count($idValues)) {
            return false;
        }
    
        foreach ($idValues as $idField => $idValue) {
            if (!$idValue) {
                return false;
            }
        }
    
        return true;
    }

    /**
     * Create nice permalinks.
     *
     * @param string $name The given object title.
     *
     * @return string processed permalink.
     * @deprecated made obsolete by Doctrine extensions.
     */
    public function formatPermalink($name)
    {
        $name = str_replace(array('ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß', '.', '?', '"', '/', ':', 'é', 'è', 'â'),
                            array('ae', 'oe', 'ue', 'Ae', 'Oe', 'Ue', 'ss', '', '', '', '-', '-', 'e', 'e', 'a'),
                            $name);
        $name = DataUtil::formatPermalink($name);
    
        return strtolower($name);
    }

    /**
     * Retrieve the base path for given object type and upload field combination.
     *
     * @param string  $objectType   Name of treated entity type.
     * @param string  $fieldName    Name of upload field.
     * @param boolean $ignoreCreate Whether to ignore the creation of upload folders on demand or not.
     *
     * @return mixed Output.
     * @throws Exception if invalid object type is given.
     */
    public function getFileBaseFolder($objectType, $fieldName, $ignoreCreate = false)
    {
        if (!in_array($objectType, $this->getObjectTypes())) {
            throw new Exception('Error! Invalid object type received.');
        }
    
        $basePath = FileUtil::getDataDirectory() . '/SimpleMedia/';
    
        switch ($objectType) {
            case 'medium':
                $basePath .= 'media/thefile/';
            break;
        }
    
        $result = DataUtil::formatForOS($basePath);
        if (substr($result, -1, 1) != '/') {
            // reappend the removed slash
            $result .= '/';
        }
    
        if (!is_dir($result) && !$ignoreCreate) {
            $this->checkAndCreateAllUploadFolders();
        }
    
        return $result;
    }

    /**
     * Creates all required upload folders for this application.
     *
     * @return Boolean whether everything went okay or not.
     */
    public function checkAndCreateAllUploadFolders()
    {
        $result = true;
    
        $result &= $this->checkAndCreateUploadFolder('medium', 'theFile', 'gif, jpeg, jpg, png, pdf, doc, xls, ppt, docx, xlsx, pptx, odt, ods, odp, arj, zip, rar, tar, tgz, gz, bz2, txt, rtf, swf, flv, mp3, mp4, avi, mpg, mpeg, mov');
    
        return $result;
    }

    /**
     * Creates upload folder including a subfolder for thumbnail and an .htaccess file within it.
     *
     * @param string $objectType        Name of treated entity type.
     * @param string $fieldName         Name of upload field.
     * @param string $allowedExtensions String with list of allowed file extensions (separated by ", ").
     *
     * @return Boolean whether everything went okay or not.
     */
    protected function checkAndCreateUploadFolder($objectType, $fieldName, $allowedExtensions = '')
    {
        $uploadPath = $this->getFileBaseFolder($objectType, $fieldName, true);
    
        // Check if directory exist and try to create it if needed
        if (!is_dir($uploadPath) && !FileUtil::mkdirs($uploadPath, 0777)) {
            LogUtil::registerStatus($this->__f('The upload directory "%s" does not exist and could not be created. Try to create it yourself and make sure that this folder is accessible via the web and writable by the webserver.', array($uploadPath)));
            return false;
        }
    
        // Check if directory is writable and change permissions if needed
        if (!is_writable($uploadPath) && !chmod($uploadPath, 0777)) {
            LogUtil::registerStatus($this->__f('Warning! The upload directory at "%s" exists but is not writable by the webserver.', array($uploadPath)));
            return false;
        }
    
        // Write a htaccess file into the upload directory
        $htaccessFilePath = $uploadPath . '/.htaccess';
        $htaccessFileTemplate = 'modules/SimpleMedia/docs/htaccessTemplate';
        if (!file_exists($htaccessFilePath) && file_exists($htaccessFileTemplate)) {
            $extensions = str_replace(',', '|', str_replace(' ', '', $allowedExtensions));
            $htaccessContent = str_replace('__EXTENSIONS__', $extensions, FileUtil::readFile($htaccessFileTemplate));
            if (!FileUtil::writeFile($htaccessFilePath, $htaccessContent)) {
                LogUtil::registerStatus($this->__f('Warning! Could not write the .htaccess file at "%s".', array($htaccessFilePath)));
                return false;
            }
        }
    
        return true;
    }

    /**
     * Example method for performing geo coding in PHP.
     * To use this please customise it to your needs in the concrete subclass.
     * Also you have to call this method in a PrePersist-Handler of the
     * corresponding entity class.
     * There is also a method on JS level available in src/modules/SimpleMedia/javascript/SimpleMedia_editFunctions.js.
     *
     * @param string $address The address input string.
     *
     * @return Array The determined coordinates.
     */
    public function performGeoCoding($address)
    {
        $lang = ZLanguage::getLanguageCode();
        $url = 'http://maps.google.com/maps/api/geocode/xml?address=' . urlencode($address);
        $url .= '&region=' . $lang . '&language=' . $lang . '&sensor=false';
    
        // we can either use Snoopy if available
        //require_once('modules/SimpleMedia/lib/vendor/Snoopy/Snoopy.class.php');
        //$snoopy = new Snoopy();
        //$snoopy->fetch($url);
        //$xmlContent = $snoopy->results;
    
        // we can also use curl
        /** TODO example to be done */
    
        // or we can use the plain file_get_contents method
        // requires allow_url_fopen = true in php.ini which is NOT good for security
        $xmlContent = file_get_contents($url);
    
        // parse the markup
        $xml = new SimpleXMLElement($xmlContent);
        //$xml = simplexml_load_string($xmlContent, 'SimpleXMLElement', LIBXML_NOCDATA);
    
        // create the result array
        $result = array('latitude' => 0, 'longitude' => 0);
    
        $lat = $xml->xpath('result/geometry/location/lat');
        $result['latitude'] = (float)$lat[0];
    
        $lng = $xml->xpath('result/geometry/location/lng');
        $result['longitude'] = (float)$lng[0];
    
        return $result;
    }
}
