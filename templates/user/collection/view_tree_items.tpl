{* purpose of this template: collections tree items in user area *}
{assign var='hasNodes' value=false}
{if isset($items) && (is_object($items) && $items->count() gt 0) || (is_array($items) && count($items) gt 0)}
    {assign var='hasNodes' value=true}
{/if}

{* initialise additional gettext domain for translations within javascript *}
{pageaddvar name='jsgettext' value='module_simplemedia_js:SimpleMedia'}

<div id="collectionTree{$rootId}" class="z-tree-container">
    <div id="collectionTreeItems{$rootId}" class="z-tree-items">
    {if $hasNodes}
        {simplemediaTreeJS objectType='collection' tree=$items controller='user' root=$rootId sortable=true}
    {/if}
    </div>
</div>

{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_tree.js'}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{if $hasNodes}}
        simmedInitTreeNodes('collection', 'user', '{{$rootId}}', true, false);
        Zikula.TreeSortable.trees.itemtree{{$rootId}}.config.onSave = simmedTreeSave;
    {{/if}}
    });
/* ]]> */
</script>
<noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
