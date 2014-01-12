{* purpose of this template: media display kml view in admin area *}
{simplemediaTemplateHeaders contentType='application/vnd.google-earth.kml+xml'}
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
<Document>
    <Placemark>
        <name>{$medium->getTitle()}</name>
        <Point>
            <coordinates>{$medium->getLongitude()}, {$medium->getLatitude()}, 0</coordinates>
        </Point>
    </Placemark>
</Document>
</kml>
