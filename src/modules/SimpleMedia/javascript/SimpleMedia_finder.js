'use strict';

var currentSimpleMediaEditor = null;
var currentSimpleMediaInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes() {
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function SimpleMediaFinderXinha(editor, simmedURL) {
	var popupAttributes;

    // Save editor for access in selector window
    currentSimpleMediaEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(simmedURL, '', popupAttributes);
}



var simplemedia = {};

simplemedia.finder = {};

simplemedia.finder.onLoad = function (baseId, selectedId) {
    $('SimpleMedia_sort').observe('change', simplemedia.finder.onParamChanged);
    $('SimpleMedia_sortdir').observe('change', simplemedia.finder.onParamChanged);
    $('SimpleMedia_pagesize').observe('change', simplemedia.finder.onParamChanged);
    $('SimpleMedia_gosearch').observe('click', simplemedia.finder.onParamChanged)
                           .observe('keypress', simplemedia.finder.onParamChanged);
    $('SimpleMedia_submit').addClassName('z-hide');
    $('SimpleMedia_cancel').observe('click', simplemedia.finder.handleCancel);
};

simplemedia.finder.onParamChanged = function () {
    $('selectorForm').submit();
};

simplemedia.finder.handleCancel = function () {
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        tinyMCEPopup.close();
        //simmedClosePopup();
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId) {
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);

    pasteMode = $F('SimpleMedia_pasteas');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
simplemedia.finder.selectItem = function (itemId) {
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentSimpleMediaEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentSimpleMediaEditor.focusEditor();
            window.opener.currentSimpleMediaEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentSimpleMediaInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
        tinyMCEPopup.close();
        return;
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    simmedClosePopup();
};


function simmedClosePopup() {
    window.opener.focus();
    window.close();
}




//=============================================================================
// SimpleMedia item selector for Forms
//=============================================================================

simplemedia.itemSelector = {};
simplemedia.itemSelector.items = {};
simplemedia.itemSelector.baseId = 0;
simplemedia.itemSelector.selectedId = 0;

simplemedia.itemSelector.onLoad = function (baseId, selectedId) {
    simplemedia.itemSelector.baseId = baseId;
    simplemedia.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $(baseId + '_objecttype').observe('change', simplemedia.itemSelector.onParamChanged);

    if ($(baseId + '_catid') !== undefined) {
        $(baseId + '_catid').observe('change', simplemedia.itemSelector.onParamChanged);
    }
    $(baseId + '_id').observe('change', simplemedia.itemSelector.onItemChanged);
    $(baseId + '_sort').observe('change', simplemedia.itemSelector.onParamChanged);
    $(baseId + '_sortdir').observe('change', simplemedia.itemSelector.onParamChanged);
    $('SimpleMedia_gosearch').observe('click', simplemedia.itemSelector.onParamChanged)
                           .observe('keypress', simplemedia.itemSelector.onParamChanged);

    simplemedia.itemSelector.getItemList();
};

simplemedia.itemSelector.onParamChanged = function () {
    $('ajax_indicator').removeClassName('z-hide');

    simplemedia.itemSelector.getItemList();
};

simplemedia.itemSelector.getItemList = function () {
    var baseId, pars, request;

    baseId = simplemedia.itemSelector.baseId;
    pars = 'objectType=' + baseId + '&';
    if ($(baseId + '_catid') !== undefined) {
        pars += 'catid=' + $F(baseId + '_catid') + '&';
    }
    pars += 'sort=' + $F(baseId + '_sort') + '&' +
            'sortdir=' + $F(baseId + '_sortdir') + '&' +
            'searchterm=' + $F(baseId + '_searchterm');

    request = new Zikula.Ajax.Request('ajax.php?module=SimpleMedia&func=getItemListFinder', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
        },
        onSuccess: function(req) {
            var baseId;
            baseId = simplemedia.itemSelector.baseId;
            simplemedia.itemSelector.items[baseId] = req.getData();
            $('ajax_indicator').addClassName('z-hide');
            simplemedia.itemSelector.updateItemDropdownEntries();
            simplemedia.itemSelector.updatePreview();
        }
    });
};

simplemedia.itemSelector.updateItemDropdownEntries = function () {
    var baseId, itemSelector, items, i, item;

    baseId = simplemedia.itemSelector.baseId;
    itemSelector = $(baseId + '_id');
    itemSelector.length = 0;

    items = simplemedia.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (simplemedia.itemSelector.selectedId > 0) {
        $(baseId + '_id').value = simplemedia.itemSelector.selectedId;
    }
};

simplemedia.itemSelector.updatePreview = function () {
    var baseId, items, selectedElement, i;

    baseId = simplemedia.itemSelector.baseId;
    items = simplemedia.itemSelector.items[baseId];

    $(baseId + '_previewcontainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (simplemedia.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === simplemedia.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + '_previewcontainer').update(window.atob(selectedElement.previewInfo))
                                       .removeClassName('z-hide');
    }
};

simplemedia.itemSelector.onItemChanged = function () {
    var baseId, itemSelector, preview;

    baseId = simplemedia.itemSelector.baseId;
    itemSelector = $(baseId + '_id');
    preview = window.atob(simplemedia.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + '_previewcontainer').update(preview);
    simplemedia.itemSelector.selectedId = $F(baseId + '_id');
};
