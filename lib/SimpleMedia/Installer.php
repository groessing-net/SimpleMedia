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

/**
 * Installer implementation class.
 */
class SimpleMedia_Installer extends SimpleMedia_Base_Installer
{
    // feel free to extend the installer here

    /**
     * Install the SimpleMedia application. 
	 * OVERRIDE:
     * CHECK
	 * - some modvars are set specifically here
	 * - more extensive category creation via separate method
	 * - createDefaultData also creates a default collection
     *
     * @return boolean True on success, or false.
     */
    public function install()
    {
        // Check if upload directories exist and if needed create them
        try {
            $controllerHelper = new SimpleMedia_Util_Controller($this->serviceManager);
            $result = $controllerHelper->checkAndCreateAllUploadFolders();
            if ($result) {
                LogUtil::registerStatus($this->__f('The file upload directory is created at [%s].', FileUtil::getDataDirectory() . '/SimpleMedia/'));
            }
        } catch (\Exception $e) {
            return LogUtil::registerError($e->getMessage());
        }
        // create all tables from according entity definitions
        try {
            DoctrineHelper::createSchema($this->entityManager, $this->listEntityClasses());
        } catch (\Exception $e) {
            if (System::isDevelopmentMode()) {
                LogUtil::registerError($this->__('Doctrine Exception: ') . $e->getMessage());
            }
            $returnMessage = $this->__f('An error was encountered while creating the tables for the %s extension.', array($this->name));
            if (!System::isDevelopmentMode()) {
                $returnMessage .= ' ' . $this->__('Please enable the development mode by editing the /config/config.php file in order to reveal the error details.');
            }
            return LogUtil::registerError($returnMessage);
        }

        // set up all our vars with initial values
        $this->setVar('pageSize', 20);
        $this->setVar('mediaPageSize', 15);
        $this->setVar('collectionsPageSize', 6);
        $thumbDimensions = array();
        $thumbDimensions[] = array('width' => 250, 'height' => 187);
        $thumbDimensions[] = array('width' => 100, 'height' => 75);
        $this->setVar('thumbDimensions', $thumbDimensions);
        $this->setVar('defaultThumbNumber', 1);
        $this->setVar('enableShrinking', false);
        $this->setVar('shrinkDimensions', array('width' => 1600, 'height' => 1200));
        $this->setVar('useThumbCropper', false);
        $this->setVar('cropSizeMode', 0);
        $this->setVar('allowedExtensions', 'gif, jpeg, jpg, png, pdf, txt, mp3, mp4, avi, mpg, mpeg, mov, zip');
        $this->setVar('maxUploadFileSize', 5000);
        $this->setVar('minWidthForUpload', 100);
        $this->setVar('defaultCollection', 1);
        $this->setVar('mediaDir', 'media/files');
        $this->setVar('mediaThumbDir', 'tmb');
        $this->setVar('mediaThumbExt', '_tmb_');
        $this->setVar('countMediumViews', true);
        $this->setVar('countCollectionViews', true);

        $categoryRegistryIdsPerEntity = array();

        // create the default categories
        if ($this->createDefaultCategories($categoryRegistryIdsPerEntity)) {
            LogUtil::registerStatus($this->__('A Category tree for SimpleMedia has been created at [Root/Modules/SimpleMedia].'));
        }

        // create the default data
        if ($this->createDefaultData($categoryRegistryIdsPerEntity)) {
            LogUtil::registerStatus($this->__('A default collection has been created.'));
        }

        // register persistent event handlers
        $this->registerPersistentEventHandlers();

        // register hook subscriber bundles
        HookUtil::registerSubscriberBundles($this->version->getHookSubscriberBundles());

        // initialisation successful
        return true;
    }

    /**
     * Create the default data for SimpleMedia. 
	 * OVERRIDE: added default collection creation
     *
     * @return void
     */
    protected function createDefaultData($categoryRegistryIdsPerEntity)
    {
        // call the parent class
        parent::createDefaultData($categoryRegistryIdsPerEntity);

        // add a default root collection
        try {
            $collection = new SimpleMedia_Entity_Collection();
            $collection->setTitle($this->__('Default collection'));
            $collection->setDescription($this->__('This is the default root collection for your media and collections'));
			// make collection approved from start
			$collection->setWorkflowState('approved');
			// categories not set (yet)

            $this->entityManager->persist($collection);
            $this->entityManager->flush();
			// set this as default collection id for new media
			$this->setVar('defaultCollection', $collection->getId());
        } catch (Exception $e) {
            return LogUtil::registerError($e->getMessage());
        }

    }
    
    /**
     * Create the default data for SimpleMedia. NEW
     *
     * @return void
     */
    protected function createDefaultCategories(&$categoryRegistryIdsPerEntity)
    {
        // add default entry for category registry (property named Main)
        include_once 'modules/SimpleMedia/lib/SimpleMedia/Api/Base/Category.php';
        include_once 'modules/SimpleMedia/lib/SimpleMedia/Api/Category.php';
        $categoryApi = new SimpleMedia_Api_Category($this->serviceManager);

        // create Collection category root
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules', 'SimpleMedia', null, $this->__('SimpleMedia'), $this->__('SimpleMedia collections and media categories'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Collection')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia', 'Collection', null, $this->__('Collection'), $this->__('SimpleMedia collections'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Collection'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Collection/Default')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia/Collection', 'Default', null, $this->__('Default'), $this->__('Default collection category'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Collection/Default'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia', 'Medium', null, $this->__('Medium'), $this->__('SimpleMedia media'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Medium'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium/Image')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia/Medium', 'Image', null, $this->__('Image'), $this->__('SimpleMedia media Image'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Medium/Image'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium/Movie')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia/Medium', 'Movie', null, $this->__('Movie'), $this->__('SimpleMedia media Movie'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Medium/Movie'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium/Audio')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia/Medium', 'Audio', null, $this->__('Audio'), $this->__('SimpleMedia media Audio'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Medium/Audio'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium/Documents')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia/Medium', 'Documents', null, $this->__('Documents'), $this->__('SimpleMedia media Documents'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Medium/Documents'));
            }
        }
        if (!CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium/Other')) {
            if (!CategoryUtil::createCategory('/__SYSTEM__/Modules/SimpleMedia/Medium', 'Other', null, $this->__('Other'), $this->__('SimpleMedia media Other'))) {
                throw new Zikula_Exception($this->__f('Cannot create %s Category.', 'Modules/SimpleMedia/Medium/Other'));
            }
        }
        $catCollection = CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Collection');
        $catMedium = CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/SimpleMedia/Medium');

        $registryData = array();
        $registryData['modname'] = $this->name;
        $registryData['table'] = 'Medium';
        $registryData['property'] = $categoryApi->getPrimaryProperty(array('ot' => 'Medium'));
        $registryData['category_id'] = $catMedium['id'];
        $registryData['id'] = false;
        if (!DBUtil::insertObject($registryData, 'categories_registry')) {
            LogUtil::registerError($this->__f('Error! Could not create a category registry for the %s entity.', array('medium')));
        }
        $categoryRegistryIdsPerEntity['medium'] = $registryData['id'];

        $registryData = array();
        $registryData['modname'] = $this->name;
        $registryData['table'] = 'Collection';
        $registryData['property'] = $categoryApi->getPrimaryProperty(array('ot' => 'Collection'));
        $registryData['category_id'] = $catCollection['id'];
        $registryData['id'] = false;
        if (!DBUtil::insertObject($registryData, 'categories_registry')) {
            LogUtil::registerError($this->__f('Error! Could not create a category registry for the %s entity.', array('collection')));
        }
        $categoryRegistryIdsPerEntity['collection'] = $registryData['id'];

        return true;
    }

    /**
     * register persistent module handlers 
	 * OVERRIDE: added scribite external plugins for tinymce, ckeditor
     * 
     * @return void
     */
    public function registerPersistentEventHandlers()
    {
        parent::registerPersistentEventHandlers();
        
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.scribite.editorhelpers', array('SimpleMedia_Listener_ThirdParty', 'getEditorHelpers'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'moduleplugin.tinymce.externalplugins', array('SimpleMedia_Listener_ThirdParty', 'getTinyMcePlugins'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'moduleplugin.ckeditor.externalplugins', array('SimpleMedia_Listener_ThirdParty', 'getCKEditorPlugins'));
    }
    
    /**
     * Uninstall SimpleMedia. 
	 * OVERRIDE: added extra message on category tree removal
     *
     * @return boolean True on success, false otherwise.
     */
    public function uninstall()
    {
        $result = parent::uninstall();
        
        LogUtil::registerStatus($this->__('The SimpleMedia category [Root/Modules/SimpleMedia] with subcategories can be removed manually'));
        
        return $result;
    }
}
