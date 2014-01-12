{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="medium{$medium.id}">
<dt>{$medium->getTitleFromDisplayPattern()|notifyfilters:'simplemedia.filter_hooks.media.filter'|htmlentities}</dt>
{if $medium.description ne ''}<dd>{$medium.description}</dd>{/if}
<dd>{assignedcategorieslist categories=$medium.categories doctrine2=true}</dd>
</dl>
