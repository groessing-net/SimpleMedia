{* Purpose of this template: Display one certain medium within an external context *}
<div id="medium{$medium.id}" class="simplemedia-external-medium">
{if $displayMode eq 'link'}
    <p class="simplemedia-external-link">
    <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id slug=$medium.slug}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$medium->getTitleFromDisplayPattern()|notifyfilters:'simplemedia.filter_hooks.media.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SimpleMedia::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="simplemedia-external-title">
            <strong>{$medium->getTitleFromDisplayPattern()|notifyfilters:'simplemedia.filter_hooks.media.filter'}</strong>
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
            {if $medium.description ne ''}{$medium.description}<br />{/if}
            {assignedcategorieslist categories=$medium.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
