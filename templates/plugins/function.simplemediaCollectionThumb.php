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
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de).
 */

function smarty_function_simplemediaCollectionThumb($params, Zikula_View $view)
{
    /** @var SimpleMedia_Entity_Collection $collection */
    $collection = $params['collection'];
    $noPreview = false;

    if ($collection->getPreviewImage() != 0) {
        /** @var SimpleMedia_Entity_Medium $medium */
        $medium = ModUtil::apiFunc('SimpleMedia', 'selection', 'getEntity', array ('objectType' => 'medium', 'id' => $collection->getPreviewImage()));
        $meta = $medium->getTheFileMeta();
        if ($meta['isImage']) {
            $img = $medium->getTheFileFullPath();
        } else {
            goto no_preview;
        }
    } else {
        no_preview:
        $noPreview = true;
        $img = 'modules/SimpleMedia/images/sm2_collection_512x512.png';
    }

    require_once($view->_get_plugin_filepath('function', 'thumb'));

    $img = smarty_function_thumb(array(
        'image' => $img,
        'module' => 'SimpleMedia',
        'objectid' => "collection-{$collection->getId()}",
        'preset' => ModUtil::getVar('SimpleMedia', 'collectionImaginePreset'),
        'tag' => true
    ), $view);

    if (!$noPreview) {
        $img = "<a href=\"{$medium->getTheFileFullPath()}\" title=\"" .
            DataUtil::formatForDisplay($medium->getTitleFromDisplayPattern()) .  "\" rel=\"imageviewer[medium]\">$img</a>";
    }

    return $img;
}
