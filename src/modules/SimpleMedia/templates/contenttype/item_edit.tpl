{* Purpose of this template: edit view of specific item detail view content type *}

<div class="z-formrow">
    {formlabel for='SimpleMedia_objecttype' __text='Object type'}
    {simplemediaSelectorObjectTypes assign='allObjectTypes'}
    {formdropdownlist id='SimpleMedia_objecttype' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
</div>

<div style="margin-left: 80px">
    <div{* class="z-formrow"*}>
        {simplemediaSelectorItems id='id' group='data' objectType=$objectType}
        
    </div>

    <div{* class="z-formrow"*}>
        {formradiobutton id='linkButton' value='link' dataField='displayMode' group='data' mandatory=1}
        {formlabel for='linkButton' __text='Link to object'}
        {formradiobutton id='embedButton' value='embed' dataField='displayMode' group='data' mandatory=1}
        {formlabel for='embedButton' __text='Embed object display'}
    </div>
</div>
