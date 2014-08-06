{* Purpose of this template: Display one certain collection within an external context *}
<div id="collection{$collection.id}" class="simplemedia-external-collection">
{if $displayMode eq 'link'}
    <p class="simplemedia-external-link">
    <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection'  id=$collection.id}" title="{$collection->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$collection->getTitleFromDisplayPattern()|notifyfilters:'simplemedia.filter_hooks.collections.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SimpleMedia::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="simplemedia-external-title">
            <strong>{$collection->getTitleFromDisplayPattern()|notifyfilters:'simplemedia.filter_hooks.collections.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="simplemedia-external-snippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="simplemedia-external-description">
            {if $collection.description ne ''}{$collection.description}<br />{/if}
            {assignedcategorieslist categories=$collection.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
