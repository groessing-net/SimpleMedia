'use strict';

var currentNodeId = 0;

/**
 * Helper function to start several different ajax actions
 * performing tree related amendments and operations.
 */
function simmedPerformTreeOperation(objectType, rootId, op)
{
    var opParam, pars, request;

    opParam = ((op === 'moveNodeUp' || op === 'moveNodeDown') ? 'moveNode' : op);
    pars = 'ot=' + objectType + '&op=' + opParam;

    if (op !== 'addRootNode') {
        pars += '&root=' + rootId;

        if (!currentNodeId) {
            Zikula.UI.Alert('Invalid node id', Zikula.__('Error', 'module_simplemedia_js'));
        }
        pars += '&' + ((op === 'addChildNode') ? 'pid' : 'id') + '=' + currentNodeId;

        if (op === 'moveNodeUp') {
            pars += '&direction=up';
        } else if (op === 'moveNodeDown') {
            pars += '&direction=down';
        }
    }

    request = new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=SimpleMedia&func=handleTreeOperation',
        {
            method: 'post',
            parameters: pars,
            onComplete: function (req) {
                if (!req.isSuccess()) {
                    Zikula.UI.Alert(req.getMessage(), Zikula.__('Error', 'module_simplemedia_js'));
                    return;
                }
                var data = req.getData();
                /*if (data.message) {
                    Zikula.UI.Alert(data.message, Zikula.__('Success', 'module_simplemedia_js'));
                }*/
                window.location.reload();
            }
        }
    );
}

var simmedTreeContextMenu;

simmedTreeContextMenu = Class.create(Zikula.UI.ContextMenu, {
    selectMenuItem: function ($super, event, item, item_container) {
        // open in new tab / window when right-clicked
        if (event.isRightClick()) {
            item.callback(this.clicked, true);
            event.stop(); // close the menu
            return;
        }
        // open in current window when left-clicked
        return $super(event, item, item_container);
    }
});

/**
 * Initialise event handlers for all nodes of a given tree root.
 */
function simmedInitTreeNodes(objectType, controller, rootId, hasDisplay, hasEdit)
{
    $$('#itemTree' + rootId + ' a').each(function (elem) {
        var liRef, isRoot, contextMenu;

        // get reference to list item
        liRef = elem.up();
        isRoot = (liRef.id === 'tree' + rootId + 'node_' + rootId);

        // define a link id
        elem.id = liRef.id + 'link';

        // and use it to attach a context menu
        contextMenu = new simmedTreeContextMenu(elem.id, { leftClick: true, animation: false });
        if (hasDisplay === true) {
            contextMenu.addItem({
                label: '<img src="' + Zikula.Config.baseURL + 'images/icons/extrasmall/kview.png" width="16" height="16" alt="' + Zikula.__('Display', 'module_simplemedia_js') + '" /> '
                     + Zikula.__('Display', 'module_simplemedia_js'),
                callback: function (selectedMenuItem, isRightClick) {
                    var url;

                    currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                    url = Zikula.Config.baseURL + 'index.php?module=SimpleMedia&type=' + controller + '&func=display&ot=' + objectType + '&id=' + currentNodeId;

                    if (isRightClick) {
                        window.open(url);
                    } else {
                        window.location = url;
                    }
                }
            });
        }
        if (hasEdit === true) {
            contextMenu.addItem({
                label: '<img src="' + Zikula.Config.baseURL + 'images/icons/extrasmall/edit.png" width="16" height="16" alt="' + Zikula.__('Edit', 'module_simplemedia_js') + '" /> '
                     + Zikula.__('Edit', 'module_simplemedia_js'),
                callback: function (selectedMenuItem, isRightClick) {
                    var url;

                    currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                    url = Zikula.Config.baseURL + 'index.php?module=SimpleMedia&type=' + controller + '&func=edit&ot=' + objectType + '&id=' + currentNodeId;

                    if (isRightClick) {
                        window.open(url);
                    } else {
                        window.location = url;
                    }
                }
            });
            contextMenu.addItem({
                label: '<img src="' + Zikula.Config.baseURL + images/icons/extrasmall/edit_add.png" width="16" height="16" alt="' + Zikula.__('Create media', 'module_simplemedia_js') + '" /> '
                     + Zikula.__('Create media', 'module_simplemedia_js'),
                callback: function () {
                    currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                    window.location = Zikula.Config.baseURL + 'index.php?module=SimpleMedia&type=' + controller + '&func=edit&ot=medium&collection=' + currentNodeId + '&returnTo=adminDisplayCollection';
                }
            });
        }
        contextMenu.addItem({
            label: '<img src="' + Zikula.Config.baseURL + 'images/icons/extrasmall/insert_table_row.png" width="16" height="16" alt="' + Zikula.__('Add child node', 'module_simplemedia_js') + '" /> '
                 + Zikula.__('Add child node', 'module_simplemedia_js'),
            callback: function () {
                currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                simmedPerformTreeOperation(objectType, rootId, 'addChildNode');
            }
        });
        contextMenu.addItem({
            label: '<img src="' + Zikula.Config.baseURL + 'images/icons/extrasmall/14_layer_deletelayer.png" width="16" height="16" alt="' + Zikula.__('Delete node', 'module_simplemedia_js') + '" /> '
                 + Zikula.__('Delete node', 'module_simplemedia_js'),
            callback: function () {
                var confirmQuestion;

                confirmQuestion = Zikula.__('Do you really want to remove this node?', 'module_simplemedia_js');
                if (!liRef.hasClassName('z-tree-leaf')) {
                    confirmQuestion = Zikula.__('Do you really want to remove this node including all child nodes?', 'module_simplemedia_js');
                }
                if (window.confirm(confirmQuestion) !== false) {
                    currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                    simmedPerformTreeOperation(objectType, rootId, 'deleteNode');
                }
            }
        });
        contextMenu.addItem({
            label: '<img src="' + Zikula.Config.baseURL + 'images/icons/extrasmall/14_layer_raiselayer.png" width="16" height="16" alt="' + Zikula.__('Move up', 'module_simplemedia_js') + '" /> '
                 + Zikula.__('Move up', 'module_simplemedia_js'),
            condition: function () {
                return !isRoot && !liRef.hasClassName('z-tree-first'); // has previous sibling
            },
            callback: function () {
                currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                simmedPerformTreeOperation(objectType, rootId, 'moveNodeUp');
            }
        });
        contextMenu.addItem({
            label: '<img src="' + Zikula.Config.baseURL + 'images/icons/extrasmall/14_layer_lowerlayer.png" width="16" height="16" alt="' + Zikula.__('Move down', 'module_simplemedia_js') + '" /> '
                 + Zikula.__('Move down', 'module_simplemedia_js'),
            condition: function () {
                return !isRoot && !liRef.hasClassName('z-tree-last'); // has next sibling
            },
            callback: function () {
                currentNodeId = liRef.id.replace('tree' + rootId + 'node_', '');
                simmedPerformTreeOperation(objectType, rootId, 'moveNodeDown');
            }
        });
    });
}

/**
 * Callback function for config.onSave. This function is called after each tree change.
 *
 * @param node - the node which is currently being moved
 * @param params - array with insertion params, which are [relativenode, dir];
 *     - "dir" is a string with value "after', "before" or "bottom" and defines
 *       whether the affected node is inserted after, before or as last child of "relativenode"
 * @param tree data - serialized to JSON tree data
 *
 * @return true on success, otherwise the change will be reverted
 */
function simmedTreeSave(node, params, data)
{
    var nodeParts, rootId, nodeId, destId, pars, request;

    // do not allow inserts on root level
    if (node.up('li') === undefined) {
        return false;
    }

    nodeParts = node.id.split('node_');
    rootId = nodeParts[0].replace('tree', '');
    nodeId = nodeParts[1];
    destId = params[1].id.replace('tree' + rootId + 'node_', '');

    pars = {
        'op': 'moveNodeTo',
        'direction': params[0],
        'root': rootId,
        'id': nodeId,
        'destid': destId
    };

    request = new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=SimpleMedia&func=handleTreeOperation',
        {
            method: 'post',
            parameters: pars,
            onComplete: function (req) {
                if (!req.isSuccess()) {
                    Zikula.UI.Alert(req.getMessage(), Zikula.__('Error', 'module_simplemedia_js'));
                    return Zikula.TreeSortable.categoriesTree.revertInsertion();
                }
                return true;
            }
        }
    );
    return request.success();
}
