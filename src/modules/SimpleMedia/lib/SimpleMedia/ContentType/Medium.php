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
 * @version Generated by ModuleStudio 0.5.3 (http://modulestudio.de) at Sun Oct 30 11:20:55 CET 2011.
 */

/**
 * Generic item list content plugin base class
 */
class SimpleMedia_ContentType_Medium extends Content_AbstractContentType
{
    private $id;
    private $displayMode;
    private $zoomMode;
    private $thumbnr;

    public function getModule()
    {
        return 'SimpleMedia';
    }

    public function getName()
    {
        return 'Medium';
    }

    public function getTitle()
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
        return __('Medium', $dom);
    }

    public function getDescription()
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
        return __('Display or link a file.', $dom);
    }

    public function loadData(&$data)
    {
        if (!isset($data['id']) || !is_numeric($data['id'])) {
            $data['id'] = null;
        }
        if (!isset($data['displayMode'])) {
            $data['displayMode'] = 'embed';
        }
        if (!isset($data['zoomMode'])) {
            $data['zoomMode'] = 'nozoom';
        }
        if (!isset($data['thumbnr'])) {
            $data['thumbnr'] = ModUtil::getVar('SimpleMedia', 'defaultThumbNumber', 1);
        }

        $this->id = $data['id'];
        $this->displayMode = $data['displayMode'];
        $this->zoomMode = $data['zoomMode'];
        $this->thumbnr = $data['thumbnr'];
    }

    public function display()
    {
        if ($this->id != null && !empty($this->displayMode) && !empty($this->zoomMode) && !empty($this->thumbnr)) {
            return ModUtil::func('SimpleMedia', 'external', 'display', $this->getDisplayArguments());
        }
        return '';
    }

    public function displayEditing()
    {
        if ($this->id != null && !empty($this->displayMode)) {
            return ModUtil::func('SimpleMedia', 'external', 'display', $this->getDisplayArguments());
        }
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
        return __('No medium selected.', $dom);
    }

    private function getDisplayArguments()
    {
        return array('source' => 'contentType',
                     'id' => $this->id,
                     'displayMode' => $this->displayMode,
                     'zoomMode' => $this->zoomMode,
                     'thumbnr' => $this->thumbnr
        );
    }

    public function getDefaultData()
    {
        return array('id' => null,
                     'displayMode' => 'embed',
                     'zoomMode' => 'nozoom',
                     'thumbnr' => ModUtil::getVar('SimpleMedia', 'defaultThumbNumber', 1));
    }

    public function startEditing()
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');
        array_push($this->view->plugins_dir, 'modules/SimpleMedia/templates/plugins');
    }
}
