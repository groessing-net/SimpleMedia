{* purpose of this template: show different forms of relatives for a given tree node *}
<h3>{gt text='Related collections'}</h3>
{if $collection.lvl gt 0}
    {if !isset($allParents) || $allParents eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='allParents' assign='allParents'}
        {if $allParents ne null && count($allParents) gt 0}
            <h4>{gt text='All parents'}</h4>
            <ul>
            {foreach item='node' from=$allParents}
                <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a></li>
            {/foreach}
            </ul>
        {/if}
    {/if}
    {if !isset($directParent) || $directParent eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='directParent' assign='directParent'}
        {if $directParent ne null}
            <h4>{gt text='Direct parent'}</h4>
            <ul>
                <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$directParent.id}" title="{$directParent->getTitleFromDisplayPattern()|replace:'"':''}">{$directParent->getTitleFromDisplayPattern()}</a></li>
            </ul>
        {/if}
    {/if}
{/if}
{if !isset($allChildren) || $allChildren eq true}
    {simplemediaTreeSelection objectType='collection' node=$collection target='allChildren' assign='allChildren'}
    {if $allChildren ne null && count($allChildren) gt 0}
        <h4>{gt text='All children'}</h4>
        <ul>
        {foreach item='node' from=$allChildren}
            <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a></li>
        {/foreach}
        </ul>
    {/if}
{/if}
{if !isset($directChildren) || $directChildren eq true}
    {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
    {if $directChildren ne null && count($directChildren) gt 0}
        <h4>{gt text='Direct children'}</h4>
        <ul>
        {foreach item='node' from=$directChildren}
            <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a></li>
        {/foreach}
        </ul>
    {/if}
{/if}
{if $collection.lvl gt 0}
    {if !isset($predecessors) || $predecessors eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='predecessors' assign='predecessors'}
        {if $predecessors ne null && count($predecessors) gt 0}
            <h4>{gt text='Predecessors'}</h4>
            <ul>
            {foreach item='node' from=$predecessors}
                <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a></li>
            {/foreach}
            </ul>
        {/if}
    {/if}
    {if !isset($successors) || $successors eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='successors' assign='successors'}
        {if $successors ne null && count($successors) gt 0}
            <h4>{gt text='Successors'}</h4>
            <ul>
            {foreach item='node' from=$successors}
                <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a></li>
            {/foreach}
            </ul>
        {/if}
    {/if}
    {if !isset($preandsuccessors) || $preandsuccessors eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='preandsuccessors' assign='preandsuccessors'}
        {if $preandsuccessors ne null && count($preandsuccessors) gt 0}
            <h4>{gt text='Siblings'}</h4>
            <ul>
            {foreach item='node' from=$preandsuccessors}
                <li><a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a></li>
            {/foreach}
            </ul>
        {/if}
    {/if}
{/if}
