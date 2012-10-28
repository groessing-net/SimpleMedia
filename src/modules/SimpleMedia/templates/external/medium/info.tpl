{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="medium{$medium.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@4838462a (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}">
<dt>{$medium.title|notifyfilters:'simplemedia.filter_hooks.media.filter'|htmlentities}</dt>
{if $medium.description ne ''}<dd>{$medium.description}</dd>{/if}
<dd>{assignedcategorieslist categories=$medium.categories doctrine2=true}</dd>
</dl>
