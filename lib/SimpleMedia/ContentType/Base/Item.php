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
 * Generic single item display content plugin base class.
 */
class SimpleMedia_ContentType_Base_Item extends Content_AbstractContentType
{
    protected $objectType;
    protected $id;
    protected $displayMode;
    
    /**
     * Returns the module providing this content type.
     *
     * @return string The module name.
     */
    public function getModule()
    {
        return 'SimpleMedia';
    }
    
    /**
     * Returns the name of this content type.
     *
     * @return string The content type name.
     */
    public function getName()
    {
        return 'Item';
    }
    
    /**
     * Returns the title of this content type.
     *
     * @return string The content type title.
     */
    public function getTitle()
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
    
        return __('SimpleMedia detail view', $dom);
    }
    
    /**
     * Returns the description of this content type.
     *
     * @return string The content type description.
     */
    public function getDescription()
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
    
        return __('Display or link a single SimpleMedia object.', $dom);
    }
    
    /**
     * Loads the data.
     *
     * @param array $data Data array with parameters.
     */
    public function loadData(&$data)
    {
        $serviceManager = ServiceUtil::getManager();
        $controllerHelper = new SimpleMedia_Util_Controller($serviceManager);
    
        $utilArgs = array('name' => 'detail');
        if (!isset($data['objectType']) || !in_array($data['objectType'], $controllerHelper->getObjectTypes('contentType', $utilArgs))) {
            $data['objectType'] = $controllerHelper->getDefaultObjectType('contentType', $utilArgs);
        }
    
        $this->objectType = $data['objectType'];
    
        if (!isset($data['id'])) {
            $data['id'] = null;
        }
        if (!isset($data['displayMode'])) {
            $data['displayMode'] = 'embed';
        }
    
        $this->id = $data['id'];
        $this->displayMode = $data['displayMode'];
    }
    
    /**
     * Displays the data.
     *
     * @return string The returned output.
     */
    public function display()
    {
        if ($this->id != null && !empty($this->displayMode)) {
            return ModUtil::func('SimpleMedia', 'external', 'display', $this->getDisplayArguments());
        }
    
        return '';
    }
    
    /**
     * Displays the data for editing.
     */
    public function displayEditing()
    {
        if ($this->id != null && !empty($this->displayMode)) {
            return ModUtil::func('SimpleMedia', 'external', 'display', $this->getDisplayArguments());
        }
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
    
        return __('No item selected.', $dom);
    }
    
    /**
     * Returns common arguments for display data selection with the external api.
     *
     * @return array Display arguments.
     */
    protected function getDisplayArguments()
    {
        return array('objectType' => $this->objectType,
                     'source' => 'contentType',
                     'displayMode' => $this->displayMode,
                     'id' => $this->id
        );
    }
    
    /**
     * Returns the default data.
     *
     * @return array Default data and parameters.
     */
    public function getDefaultData()
    {
        return array('objectType' => 'medium',
                     'id' => null,
                     'displayMode' => 'embed');
    }
    
    /**
     * Executes additional actions for the editing mode.
     */
    public function startEditing()
    {
        // ensure our custom plugins are loaded
        array_push($this->view->plugins_dir, 'modules/SimpleMedia/templates/plugins');
    
        // required as parameter for the item selector plugin
        $this->view->assign('objectType', $this->objectType);
    }
}