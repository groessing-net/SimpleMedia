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
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Mon Nov 28 12:34:51 CET 2011.
 */

/**
 * Utility base class for controller helper methods.
 */
class SimpleMedia_Util_Base_Controller extends Zikula_AbstractBase
{
    /**
     * Returns an array of all allowed object types in SimpleMedia.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, actionHandler, block, contentType).
     * @param array  $args    Additional arguments.
     *
     * @return array List of allowed object types.
     */
    public static function getObjectTypes($context = '', $args = array())
    {
        if (!in_array($context, array('controllerAction', 'api', 'actionHandler', 'block', 'contentType'))) {
            $context = 'controllerAction';
        }

        $allowedObjectTypes = array();
        $allowedObjectTypes[] = 'medium';
        return $allowedObjectTypes;
    }

    /**
     * Returns the default object type in SimpleMedia.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, actionHandler, block, contentType).
     * @param array  $args    Additional arguments.
     *
     * @return string The name of the default object type.
     */
    public static function getDefaultObjectType($context = '', $args = array())
    {
        if (!in_array($context, array('controllerAction', 'api', 'actionHandler', 'block', 'contentType'))) {
            $context = 'controllerAction';
        }

        $defaultObjectType = 'medium';
        return $defaultObjectType;
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
    public static function retrieveIdentifier(Zikula_Request_Http $request, array $args, $objectType = '', array $idFields)
    {
        foreach ($idFields as $idField) {
            $defaultValue = isset($args[$idField]) && is_numeric($args[$idField]) ? $args[$idField] : 0;
            $id = $request->getGet()->filter($idField, $defaultValue);
            if (!$id && $idField != 'id' && count($idFields) == 1) {
                $defaultValue = isset($args['id']) && is_numeric($args['id']) ? $args['id'] : 0;
                $id = (int) $request->getGet()->filter('id', $defaultValue, FILTER_VALIDATE_INT);
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
    public static function isValidIdentifier(array $idValues)
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
     */
    public static function formatPermalink($name)
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
     * @param string $objectType Name of treated entity type.
     * @param string $fieldName  Name of upload field.
     * @param array  $args       Additional arguments.
     *
     * @return mixed Output.
     */
    public static function getFileBaseFolder($objectType, $fieldName)
    {
        if (!in_array($objectType, self::getObjectTypes())) {
            $objectType = self::getDefaultObjectType();
        }

        $basePath = FileUtil::getDataDirectory() . '/SimpleMedia/';

        switch ($objectType) {
            case 'medium':
                            $basePath .= 'media/thefile/';
                            break;
        }

        return $basePath;
    }
}
