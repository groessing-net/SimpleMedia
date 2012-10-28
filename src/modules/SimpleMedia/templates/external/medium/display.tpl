{* Purpose of this template: Display one certain medium within an external context *}
<div id="medium{$medium.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@4838462a (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}" class="simmedexternalmedium">
{if $displayMode eq 'link'}
    <p class="simmedexternallink">
    <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id slug=$medium.slug}" title="{$medium.title|replace:"\"":""}">
    {$medium.title|notifyfilters:'simplemedia.filter_hooks.media.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="simmedexternaltitle">
            <strong>{$medium.title|notifyfilters:'simplemedia.filter_hooks.media.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="simmedexternalsnippet">
        &nbsp;
    </div>

    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}
    {*
        <p class="simmedexternaldesc">
            {if $medium.description ne ''}{$medium.description}<br />{/if}
            {assignedcategorieslist categories=$medium.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
