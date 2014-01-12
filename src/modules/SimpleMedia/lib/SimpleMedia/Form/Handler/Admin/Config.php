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
 * Configuration handler implementation class.
 */
class SimpleMedia_Form_Handler_Admin_Config extends SimpleMedia_Form_Handler_Admin_Base_Config
{
    // feel free to extend the base handler class here

    /**
     * Method stub for own additions in subclasses. OVERRIDE
     */
    protected function initializeAdditions()
    {
		// get the configured default collection for new media
		$collections = ModUtil::apiFunc('SimpleMedia', 'selection', 'getEntities', array('ot' => 'collection', 'orderBy' => 'lvl', 'useJoins' => false, 'slimMode' => false));
		$defaultCollectionItems = array();
		foreach ($collections as $collection) {
			// prefix the title with level
			$prefix = '';
			for ($i=0; $i<$collection['lvl']; $i++) {
				$prefix .= '- - ';
			}
			$defaultCollectionItems[] = array(
				'value' => $collection['id'],
				'text' => $prefix . $collection['title']
			);
		}
		$this->view->assign('defaultCollections', array(
			'defaultCollection' => ModUtil::getVar('SimpleMedia', 'defaultCollection', 1),
			'defaultCollectionItems' => $defaultCollectionItems));
		
		// assign cropSizeModes
		$utilManual = new SimpleMedia_Util_Manual();
		$cropSize = array(
			'cropSizeMode' => ModUtil::getVar('SimpleMedia', 'cropSizeMode'), 
			'cropSizeModeItems' => $utilManual->getCropSizeModes()
		);
		$this->view->assign('cropSize', $cropSize);
    }
	
     /**
     * Command event handler OVERRIDE
     *
     */
    public function handleCommand(Zikula_Form_View $view, &$args)
    {
        if ($args['commandName'] == 'save') {
            // check if all fields are valid
            if (!$this->view->isValid()) {
                return false;
            }

            // retrieve form data
            $data = $this->view->getValues();

            // update all standard module vars
            if (!$this->setVars($data['config'])) {
                return LogUtil::registerError($this->__('Error! Failed to set configuration variables.'));
            }

            // handle shrinkdimensions array
            if ($data['config']['enableShrinking']) {
                $this->setVar('shrinkDimensions', array('width' => $data['maxSize']['shrinkWidth'], 'height' => $data['maxSize']['shrinkHeight']));
            }
            
            // handle thumbnail dimensions array
            $thumbDimensions = array();
            for ($i = 1; $i <= count($data['thumbSizes'])/2; $i++) {
                if (!empty($data['thumbSizes']['thumb'.$i.'width']) && !empty($data['thumbSizes']['thumb'.$i.'height'])) {
                    $thumbDimensions[] = array(
						'width' => $data['thumbSizes']['thumb'.$i.'width'],
						'height' => $data['thumbSizes']['thumb'.$i.'height']
					);
                }
            }
            $this->setVar('thumbDimensions', $thumbDimensions);

			// handle cropSizeMode
            $this->setVar('cropSizeMode', $data['cropSize']['cropSizeMode']);
			
			// handle defaultCollection Id
            $this->setVar('defaultCollection', $data['defaultCollections']['defaultCollection']);

            LogUtil::registerStatus($this->__('Done! Module configuration updated.'));
        } else if ($args['commandName'] == 'cancel') {
            // nothing to do there
        }

        // redirect back to the config page
        $url = ModUtil::url($this->name, 'admin', 'config');
        return $this->view->redirect($url);
    }
    
}
