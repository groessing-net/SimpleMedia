{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="collection{$collection.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@66869470 (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}">
<dt>{$collection.title|notifyfilters:'simplemedia.filter_hooks.collections.filter'|htmlentities}</dt>
{if $collection.description ne ''}<dd>{$collection.description}</dd>{/if}
<dd>{assignedcategorieslist categories=$collection.categories doctrine2=true}</dd>
</dl>
