{* purpose of this template: media view filter form in user area *}
{checkpermissionblock component='SimpleMedia:Medium:' instance='.*' level='ACCESS_EDIT'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="simmedMediumQuickNavForm" class="simmedQuickNavForm">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='SimpleMedia' info='displayname'}" />
        <input type="hidden" name="type" value="user" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="medium" />
        {gt text='All' assign='lblDefault'}
        {if !isset($categoryFilter) || $categoryFilter eq true}
            <label for="categoryid">{gt text='Category'}</label>
            &nbsp;
            {modapifunc modname='SimpleMedia' type='category' func='getMainCat' assign='mainCategory'}
            {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDefault editLink=false selectedValue=$catId}
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
            <label for="searchterm">{gt text='Search'}:</label>
            <input type="text" id="searchterm" name="searchterm" value="{$searchterm}" />
        {/if}
        {if !isset($sorting) || $sorting eq true}
            <label for="sortby">{gt text='Sort by'}</label>
            &nbsp;
            <select id="sortby" name="sort">
            <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
            <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
            <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
            <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
            <option value="additionalData"{if $sort eq 'additionalData'} selected="selected"{/if}>{gt text='Additional data'}</option>
            <option value="mediaType"{if $sort eq 'mediaType'} selected="selected"{/if}>{gt text='Media type'}</option>
            <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
            <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
            <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
            </select>
            <select id="sortdir" name="sortdir">
                <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
            </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if}
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
            {assign var='pageSize' value=$pager.itemsperpage}
            <label for="num">{gt text='Page size'}</label>
            &nbsp;
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
        <input type="submit" name="updateview" id="quicknav_submit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simmedInitQuickNavigation('medium', 'user');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknav_submit').addClassName('z-hide');
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
