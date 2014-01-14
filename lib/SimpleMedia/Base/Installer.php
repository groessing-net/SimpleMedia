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
 * Installer base class.
 */
class SimpleMedia_Base_Installer extends Zikula_AbstractInstaller
{
    /**
     * Install the SimpleMedia application.
     *
     * @return boolean True on success, or false.
     */
    public function install()
    {
        // Check if upload directories exist and if needed create them
        try {
            $controllerHelper = new SimpleMedia_Util_Controller($this->serviceManager);
            $controllerHelper->checkAndCreateAllUploadFolders();
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
        $this->setVar('thumbDimensions', '');
        $this->setVar('defaultThumbNumber', 1);
        $this->setVar('enableShrinking', false);
        $this->setVar('shrinkDimensions', '');
        $this->setVar('useThumbCropper', false);
        $this->setVar('cropSizeMode', 0);
        $this->setVar('allowedExtensions', 'gif, jpeg, jpg, png, pdf, txt, mp3, mp4, avi, mpg, mpeg, mov');
        $this->setVar('maxUploadFileSize', 5000);
        $this->setVar('minWidthForUpload', 100);
        $this->setVar('defaultCollection', 1);
        $this->setVar('mediaDir', 'media/thefile');
        $this->setVar('mediaThumbDir', 'tmb');
        $this->setVar('mediaThumbExt', '_tmb_');
        $this->setVar('countMediumViews', false);
        $this->setVar('countCollectionViews', false);
    
        $categoryRegistryIdsPerEntity = array();
    
        // add default entry for category registry (property named Main)
        include_once 'modules/SimpleMedia/lib/SimpleMedia/Api/Base/Category.php';
        include_once 'modules/SimpleMedia/lib/SimpleMedia/Api/Category.php';
        $categoryApi = new SimpleMedia_Api_Category($this->serviceManager);
    
        $registryData = array();
        $registryData['modname'] = $this->name;
        $registryData['table'] = 'Medium';
        $registryData['property'] = $categoryApi->getPrimaryProperty(array('ot' => 'Medium'));
        $categoryGlobal = CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/Global');
        $registryData['category_id'] = $categoryGlobal['id'];
        $registryData['id'] = false;
        if (!DBUtil::insertObject($registryData, 'categories_registry')) {
            LogUtil::registerError($this->__f('Error! Could not create a category registry for the %s entity.', array('medium')));
        }
        $categoryRegistryIdsPerEntity['medium'] = $registryData['id'];
    
        $registryData = array();
        $registryData['modname'] = $this->name;
        $registryData['table'] = 'Collection';
        $registryData['property'] = $categoryApi->getPrimaryProperty(array('ot' => 'Collection'));
        $categoryGlobal = CategoryUtil::getCategoryByPath('/__SYSTEM__/Modules/Global');
        $registryData['category_id'] = $categoryGlobal['id'];
        $registryData['id'] = false;
        if (!DBUtil::insertObject($registryData, 'categories_registry')) {
            LogUtil::registerError($this->__f('Error! Could not create a category registry for the %s entity.', array('collection')));
        }
        $categoryRegistryIdsPerEntity['collection'] = $registryData['id'];
    
        // create the default data
        $this->createDefaultData($categoryRegistryIdsPerEntity);
    
        // register persistent event handlers
        $this->registerPersistentEventHandlers();
    
        // register hook subscriber bundles
        HookUtil::registerSubscriberBundles($this->version->getHookSubscriberBundles());
        
    
        // initialisation successful
        return true;
    }
    
    /**
     * Upgrade the SimpleMedia application from an older version.
     *
     * If the upgrade fails at some point, it returns the last upgraded version.
     *
     * @param integer $oldVersion Version to upgrade from.
     *
     * @return boolean True on success, false otherwise.
     */
    public function upgrade($oldVersion)
    {
    /*
        // Upgrade dependent on old version number
        switch ($oldVersion) {
            case 1.0.0:
                // do something
                // ...
                // update the database schema
                try {
                    DoctrineHelper::updateSchema($this->entityManager, $this->listEntityClasses());
                } catch (\Exception $e) {
                    if (System::isDevelopmentMode()) {
                        LogUtil::registerError($this->__('Doctrine Exception: ') . $e->getMessage());
                    }
                    return LogUtil::registerError($this->__f('An error was encountered while updating tables for the %s extension.', array($this->getName())));
                }
        }
    */
    
        // update successful
        return true;
    }
    
    /**
     * Uninstall SimpleMedia.
     *
     * @return boolean True on success, false otherwise.
     */
    public function uninstall()
    {
        // delete stored object workflows
        $result = Zikula_Workflow_Util::deleteWorkflowsForModule($this->getName());
        if ($result === false) {
            return LogUtil::registerError($this->__f('An error was encountered while removing stored object workflows for the %s extension.', array($this->getName())));
        }
    
        try {
            DoctrineHelper::dropSchema($this->entityManager, $this->listEntityClasses());
        } catch (\Exception $e) {
            if (System::isDevelopmentMode()) {
                LogUtil::registerError($this->__('Doctrine Exception: ') . $e->getMessage());
            }
            return LogUtil::registerError($this->__f('An error was encountered while dropping tables for the %s extension.', array($this->name)));
        }
    
        // unregister persistent event handlers
        EventUtil::unregisterPersistentModuleHandlers($this->name);
    
        // unregister hook subscriber bundles
        HookUtil::unregisterSubscriberBundles($this->version->getHookSubscriberBundles());
        
    
        // remove all module vars
        $this->delVars();
    
        // remove category registry entries
        ModUtil::dbInfoLoad('Categories');
        DBUtil::deleteWhere('categories_registry', 'modname = \'' . $this->name . '\'');
    
        // remove all thumbnails
        $manager = $this->getServiceManager()->getService('systemplugin.imagine.manager');
        $manager->setModule($this->name);
        $manager->cleanupModuleThumbs();
    
        // remind user about upload folders not being deleted
        $uploadPath = FileUtil::getDataDirectory() . '/' . $this->name . '/';
        LogUtil::registerStatus($this->__f('The upload directories at [%s] can be removed manually.', $uploadPath));
    
        // uninstallation successful
        return true;
    }
    
    /**
     * Build array with all entity classes for SimpleMedia.
     *
     * @return array list of class names.
     */
    protected function listEntityClasses()
    {
        $classNames = array();
        $classNames[] = 'SimpleMedia_Entity_Medium';
        $classNames[] = 'SimpleMedia_Entity_MediumMetaData';
        $classNames[] = 'SimpleMedia_Entity_MediumAttribute';
        $classNames[] = 'SimpleMedia_Entity_MediumCategory';
        $classNames[] = 'SimpleMedia_Entity_Collection';
        $classNames[] = 'SimpleMedia_Entity_CollectionCategory';
    
        return $classNames;
    }
    
    /**
     * Create the default data for SimpleMedia.
     *
     * @param array $categoryRegistryIdsPerEntity List of category registry ids.
     *
     * @return void
     */
    protected function createDefaultData($categoryRegistryIdsPerEntity)
    {
        $entityClass = 'SimpleMedia_Entity_Medium';
        $this->entityManager->getRepository($entityClass)->truncateTable();
        $entityClass = 'SimpleMedia_Entity_Collection';
        $this->entityManager->getRepository($entityClass)->truncateTable();
    }
    
    /**
     * Register persistent event handlers.
     * These are listeners for external events of the core and other modules.
     */
    protected function registerPersistentEventHandlers()
    {
        // core -> 
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'api.method_not_found', array('SimpleMedia_Listener_Core', 'apiMethodNotFound'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'core.preinit', array('SimpleMedia_Listener_Core', 'preInit'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'core.init', array('SimpleMedia_Listener_Core', 'init'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'core.postinit', array('SimpleMedia_Listener_Core', 'postInit'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'controller.method_not_found', array('SimpleMedia_Listener_Core', 'controllerMethodNotFound'));
    
        // front controller -> SimpleMedia_Listener_FrontController
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'frontcontroller.predispatch', array('SimpleMedia_Listener_FrontController', 'preDispatch'));
    
        // installer -> SimpleMedia_Listener_Installer
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'installer.module.installed', array('SimpleMedia_Listener_Installer', 'moduleInstalled'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'installer.module.upgraded', array('SimpleMedia_Listener_Installer', 'moduleUpgraded'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'installer.module.uninstalled', array('SimpleMedia_Listener_Installer', 'moduleUninstalled'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'installer.subscriberarea.uninstalled', array('SimpleMedia_Listener_Installer', 'subscriberAreaUninstalled'));
    
        // modules -> SimpleMedia_Listener_ModuleDispatch
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module_dispatch.postloadgeneric', array('SimpleMedia_Listener_ModuleDispatch', 'postLoadGeneric'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module_dispatch.preexecute', array('SimpleMedia_Listener_ModuleDispatch', 'preExecute'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module_dispatch.postexecute', array('SimpleMedia_Listener_ModuleDispatch', 'postExecute'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module_dispatch.custom_classname', array('SimpleMedia_Listener_ModuleDispatch', 'customClassname'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module_dispatch.service_links', array('SimpleMedia_Listener_ModuleDispatch', 'serviceLinks'));
    
        // mailer -> SimpleMedia_Listener_Mailer
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.mailer.api.sendmessage', array('SimpleMedia_Listener_Mailer', 'sendMessage'));
    
        // page -> SimpleMedia_Listener_Page
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'pageutil.addvar_filter', array('SimpleMedia_Listener_Page', 'pageutilAddvarFilter'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'system.outputfilter', array('SimpleMedia_Listener_Page', 'systemOutputfilter'));
    
        // errors -> SimpleMedia_Listener_Errors
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'setup.errorreporting', array('SimpleMedia_Listener_Errors', 'setupErrorReporting'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'systemerror', array('SimpleMedia_Listener_Errors', 'systemError'));
    
        // theme -> SimpleMedia_Listener_Theme
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'theme.preinit', array('SimpleMedia_Listener_Theme', 'preInit'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'theme.init', array('SimpleMedia_Listener_Theme', 'init'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'theme.load_config', array('SimpleMedia_Listener_Theme', 'loadConfig'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'theme.prefetch', array('SimpleMedia_Listener_Theme', 'preFetch'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'theme.postfetch', array('SimpleMedia_Listener_Theme', 'postFetch'));
    
        // view -> SimpleMedia_Listener_View
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'view.init', array('SimpleMedia_Listener_View', 'init'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'view.postfetch', array('SimpleMedia_Listener_View', 'postFetch'));
    
        // user login -> SimpleMedia_Listener_UserLogin
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.login.started', array('SimpleMedia_Listener_UserLogin', 'started'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.login.veto', array('SimpleMedia_Listener_UserLogin', 'veto'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.login.succeeded', array('SimpleMedia_Listener_UserLogin', 'succeeded'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.login.failed', array('SimpleMedia_Listener_UserLogin', 'failed'));
    
        // user logout -> SimpleMedia_Listener_UserLogout
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.logout.succeeded', array('SimpleMedia_Listener_UserLogout', 'succeeded'));
    
        // user -> SimpleMedia_Listener_User
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.gettheme', array('SimpleMedia_Listener_User', 'getTheme'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.account.create', array('SimpleMedia_Listener_User', 'create'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.account.update', array('SimpleMedia_Listener_User', 'update'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.account.delete', array('SimpleMedia_Listener_User', 'delete'));
    
        // registration -> SimpleMedia_Listener_UserRegistration
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.registration.started', array('SimpleMedia_Listener_UserRegistration', 'started'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.registration.succeeded', array('SimpleMedia_Listener_UserRegistration', 'succeeded'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.ui.registration.failed', array('SimpleMedia_Listener_UserRegistration', 'failed'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.registration.create', array('SimpleMedia_Listener_UserRegistration', 'create'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.registration.update', array('SimpleMedia_Listener_UserRegistration', 'update'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'user.registration.delete', array('SimpleMedia_Listener_UserRegistration', 'delete'));
    
        // users module -> SimpleMedia_Listener_Users
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.users.config.updated', array('SimpleMedia_Listener_Users', 'configUpdated'));
    
        // group -> SimpleMedia_Listener_Group
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'group.create', array('SimpleMedia_Listener_Group', 'create'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'group.update', array('SimpleMedia_Listener_Group', 'update'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'group.delete', array('SimpleMedia_Listener_Group', 'delete'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'group.adduser', array('SimpleMedia_Listener_Group', 'addUser'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'group.removeuser', array('SimpleMedia_Listener_Group', 'removeUser'));
    
        // special purposes and 3rd party api support -> SimpleMedia_Listener_ThirdParty
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'get.pending_content', array('SimpleMedia_Listener_ThirdParty', 'pendingContentListener'));
        EventUtil::registerPersistentModuleHandler('SimpleMedia', 'module.content.gettypes', array('SimpleMedia_Listener_ThirdParty', 'contentGetTypes'));
    }
}