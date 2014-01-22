'use strict';

var currentSimpleMediaEditor = null;
var currentSimpleMediaInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function SimpleMediaFinderXinha(editor, simmedURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentSimpleMediaEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(simmedURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function SimpleMediaFinderCKEditor(editor, simmedURL)
{
    // Save editor for access in selector window
    currentSimpleMediaEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=SimpleMedia&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}


// The simplemedia variable
var simplemedia = {};

simplemedia.finder = {};

simplemedia.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', simplemedia.finder.onParamChanged);
    $('simpleMediaSort').observe('change', simplemedia.finder.onParamChanged);
    $('simpleMediaSortDir').observe('change', simplemedia.finder.onParamChanged);
    $('simpleMediaPageSize').observe('change', simplemedia.finder.onParamChanged);
    $('simpleMediaSearchGo').observe('click', simplemedia.finder.onParamChanged);
    $('simpleMediaSearchGo').observe('keypress', simplemedia.finder.onParamChanged);
    $('simpleMediaSubmit').addClassName('z-hide');
    $('simpleMediaCancel').observe('click', simplemedia.finder.handleCancel);
	
	// TODO add catching of list/thumbs and showmeta checks here
};

simplemedia.finder.onParamChanged = function ()
{
    $('simpleMediaSelectorForm').submit();
};

simplemedia.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        simmedClosePopup();
    } else if (editor === 'ckeditor') {
        simmedClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId)
{
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('simpleMediaPasteAs');

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
simplemedia.finder.selectItem = function (itemId)
{
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
        // get the html to insert and place it in the editor
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        // get the html to insert and place it in the editor
        html = getPasteSnippet('html', itemId);
        if (window.opener.currentSimpleMediaEditor !== null) {
            window.opener.currentSimpleMediaEditor.insertHtml(html);
        }
    } else {
        alert('Insert into Editor: ' + editor);
    }
    simmedClosePopup();
};


function simmedClosePopup()
{
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

simplemedia.itemSelector.onLoad = function (baseId, selectedId)
{
    simplemedia.itemSelector.baseId = baseId;
    simplemedia.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('simpleMediaObjectType').observe('change', simplemedia.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', simplemedia.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', simplemedia.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', simplemedia.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', simplemedia.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', simplemedia.itemSelector.onParamChanged);
    $('simpleMediaSearchGo').observe('click', simplemedia.itemSelector.onParamChanged);
    $('simpleMediaSearchGo').observe('keypress', simplemedia.itemSelector.onParamChanged);

    simplemedia.itemSelector.getItemList();
    
    // TODO
	// Add show images as thumbnails / list
    // Add show name/size/date
};

simplemedia.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    simplemedia.itemSelector.getItemList();
};

// The items in the item (media/collections) div
simplemedia.itemSelector.getItemList = function ()
{
    var baseId, pars, request;

    baseId = simplemedia.itemSelector.baseId;
    pars = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        pars += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        pars += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    pars += 'sort=' + $F(baseId + 'Sort') + '&' +
            'sortdir=' + $F(baseId + 'SortDir') + '&' +
            'searchterm=' + $F(baseId + 'SearchTerm');
			
	// TODO add show images as and showmeta data here

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

simplemedia.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = simplemedia.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = simplemedia.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (simplemedia.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = simplemedia.itemSelector.selectedId;
    }
};

simplemedia.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = simplemedia.itemSelector.baseId;
    items = simplemedia.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

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
        $(baseId + 'PreviewContainer').update(window.atob(selectedElement.previewInfo))
                                      .removeClassName('z-hide');
    }
};

simplemedia.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = simplemedia.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(simplemedia.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    simplemedia.itemSelector.selectedId = $F(baseId + 'Id');
};