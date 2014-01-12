{* purpose of this template: collections view kml view in admin area *}
{simplemediaTemplateHeaders contentType='application/vnd.google-earth.kml+xml'}
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
<Document>
{foreach item='item' from=$items}
    <Placemark>
        <name>{$item->getTitle()}</name>
        <Point>
            <coordinates>{$item->getLongitude()}, {$item->getLatitude()}, 0</coordinates>
        </Point>
    </Placemark>
{/foreach}
</Document>
</kml>
