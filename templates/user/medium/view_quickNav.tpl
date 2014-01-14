{* purpose of this template: media view filter form in user area *}
{checkpermissionblock component='SimpleMedia:Medium:' instance='::' level='ACCESS_EDIT'}
{assign var='objectType' value='medium'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="simpleMediaMediumQuickNavForm" class="simplemedia-quicknav">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='SimpleMedia' info='url'}" />
        <input type="hidden" name="type" value="user" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="medium" />
        <input type="hidden" name="all" value="{$all|default:0}" />
        <input type="hidden" name="own" value="{$own|default:0}" />
        {gt text='All' assign='lblDefault'}
        {if !isset($categoryFilter) || $categoryFilter eq true}
            {modapifunc modname='SimpleMedia' type='category' func='getAllProperties' ot=$objectType assign='properties'}
            {if $properties ne null && is_array($properties)}
                {gt text='All' assign='lblDefault'}
                {nocache}
                {foreach key='propertyName' item='propertyId' from=$properties}
                    {modapifunc modname='SimpleMedia' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
                    {gt text='Category' assign='categoryLabel'}
                    {assign var='categorySelectorId' value='catid'}
                    {assign var='categorySelectorName' value='catid'}
                    {assign var='categorySelectorSize' value='1'}
                    {if $hasMultiSelection eq true}
                        {gt text='Categories' assign='categoryLabel'}
                        {assign var='categorySelectorName' value='catids'}
                        {assign var='categorySelectorId' value='catids__'}
                        {assign var='categorySelectorSize' value='5'}
                    {/if}
                        <label for="{$categorySelectorId}{$propertyName}">{$categoryLabel}</label>
                        &nbsp;
                        {selector_category name="`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIdList.$propertyName categoryRegistryModule='SimpleMedia' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize}
                {/foreach}
                {/nocache}
            {/if}
        {/if}
        {if !isset($collectionFilter) || $collectionFilter eq true}
                <label for="collection">{gt text='Collections'}</label>
                {modapifunc modname='SimpleMedia' type='selection' func='getEntities' ot='collection' useJoins=false assign='listEntries'}
                <select id="collection" name="collection">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$listEntries}
                    {assign var='entryId' value=$option.id}
                    <option value="{$entryId}"{if $entryId eq $collection} selected="selected"{/if}>{$option->getTitleFromDisplayPattern()}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($workflowStateFilter) || $workflowStateFilter eq true}
                <label for="workflowState">{gt text='Workflow state'}</label>
                <select id="workflowState" name="workflowState">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$workflowStateItems}
                <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $workflowState} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($mediaTypeFilter) || $mediaTypeFilter eq true}
                <label for="mediaType">{gt text='Media type'}</label>
                <select id="mediaType" name="mediaType">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$mediaTypeItems}
                <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $mediaType} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($searchFilter) || $searchFilter eq true}
                <label for="searchTerm">{gt text='Search'}</label>
                <input type="text" id="searchTerm" name="searchterm" value="{$searchterm}" />
        {/if}
        {if !isset($sorting) || $sorting eq true}
                <label for="sortBy">{gt text='Sort by'}</label>
                &nbsp;
                <select id="sortBy" name="sort">
                    <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
                    <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                    <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
                    <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                    <option value="zipcode"{if $sort eq 'zipcode'} selected="selected"{/if}>{gt text='Zipcode'}</option>
                    <option value="previewImage"{if $sort eq 'previewImage'} selected="selected"{/if}>{gt text='Preview image'}</option>
                    <option value="sortValue"{if $sort eq 'sortValue'} selected="selected"{/if}>{gt text='Sort value'}</option>
                    <option value="mediaType"{if $sort eq 'mediaType'} selected="selected"{/if}>{gt text='Media type'}</option>
                    <option value="viewsCount"{if $sort eq 'viewsCount'} selected="selected"{/if}>{gt text='Views count'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select>
                <select id="sortDir" name="sortdir">
                    <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if}
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
                <label for="num">{gt text='Page size'}</label>
                <select id="num" name="num">
                    <option value="5"{if $pageSize eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pageSize eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pageSize eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pageSize eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pageSize eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pageSize eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pageSize eq 100} selected="selected"{/if}>100</option>
                </select>
        {/if}
        <input type="submit" name="updateview" id="quicknavSubmit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simmedInitQuickNavigation('medium', 'user');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknavSubmit').addClassName('z-hide');
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
