{* Purpose of this template: Display one certain collection within an external context *}
<div id="collection{$collection.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@66869470 (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}" class="simmedexternalcollection">
{if $displayMode eq 'link'}
    <p class="simmedexternallink">
    <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$collection.id}" title="{$collection.title|replace:"\"":""}">
    {$collection.title|notifyfilters:'simplemedia.filter_hooks.collections.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="simmedexternaltitle">
            <strong>{$collection.title|notifyfilters:'simplemedia.filter_hooks.collections.filter'}</strong>
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
            {if $collection.description ne ''}{$collection.description}<br />{/if}
            {assignedcategorieslist categories=$collection.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
