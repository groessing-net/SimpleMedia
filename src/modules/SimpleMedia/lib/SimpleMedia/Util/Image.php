<?php
/**
 * SimpleMedia.
 *
 * @copyright Erik Spaan & Axel Guckelsberger (ZKM)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Erik Spaan & Axel Guckelsberger <erik@zikula.nl>.
 * @link https://github.com/zikula-ev/SimpleMedia
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

use Imagine\Image\Box;
use Imagine\Image\Color;
use Imagine\Image\Point;

/**
 * Utility implementation class for image helper methods.
 */
class SimpleMedia_Util_Image extends SimpleMedia_Util_Base_Image
{
    // feel free to add your own convenience methods here
    
    const OBJECT_NAME                     = '005';
    const EDIT_STATUS                     = '007';
    const PRIORITY                        = '010';
    const CATEGORY                        = '015';
    const SUPPLEMENTAL_CATEGORY           = '020';
    const FIXTURE_IDENTIFIER              = '022';
    const KEYWORDS                        = '025';
    const RELEASE_DATE                    = '030';
    const RELEASE_TIME                    = '035';
    const SPECIAL_INSTRUCTIONS            = '040';
    const REFERENCE_SERVICE               = '045';
    const REFERENCE_DATE                  = '047';
    const REFERENCE_NUMBER                = '050';
    const CREATED_DATE                    = '055';
    const CREATED_TIME                    = '060';
    const ORIGINATING_PROGRAM             = '065';
    const PROGRAM_VERSION                 = '070';
    const OBJECT_CYCLE                    = '075';
    const CITY                            = '090';
    const PROVINCE_STATE                  = '095';
    const COUNTRY_CODE                    = '100';
    const COUNTRY                         = '101';
    const ORIGINAL_TRANSMISSION_REFERENCE = '103';
    const HEADLINE                        = '105';
    const CREDIT                          = '110';
    const SOURCE                          = '115';
    const COPYRIGHT_STRING                = '116';
    const CAPTION                         = '120';
    const LOCAL_CAPTION                   = '121';
    const CAPTION_WRITER                  = '122';

    const IMAGETYPE_GIF                   = '1';
    const IMAGETYPE_JPEG                  = '2';
    const IMAGETYPE_PNG                   = '3';
    const IMAGETYPE_SWF                   = '4';
    const IMAGETYPE_PSD                   = '5';
    const IMAGETYPE_BMP                   = '6';
    const IMAGETYPE_TIFF_II               = '7'; //(intel byte order)
    const IMAGETYPE_TIFF_MM               = '8'; // (motorola byte order)
    const IMAGETYPE_JPC                   = '9';
    const IMAGETYPE_JP2                   = '10';
    const IMAGETYPE_JPX                   = '11';
    const IMAGETYPE_JB2                   = '12';
    const IMAGETYPE_SWC                   = '13';
    const IMAGETYPE_IFF                   = '14';
    const IMAGETYPE_WBMP                  = '15';
    const IMAGETYPE_XBM                   = '16';
    const IMAGETYPE_ICO                   = '17';


    // Integrate IPTC and EXIF methods here. See iptc.php
    
    // Add watermarking of images here. Override getThumb possibly.

    /**
     * This method is used by the simplemediaImageThumb modifier
     * as well as the Ajax controller of this application.
     *
     * MOTHOD FROM 055 IMPLEMENTATION, NOT SURE IF NEEDED
     *
     * It serves for creating and displaying a thumbnail image.
     *
     * @param string $filePath   The input file path (including file name).
     * @param string $objectType Currently treated entity type.
     * @param string $fieldName  Name of upload field.
     * @param int    $width      Desired width.
     * @param int    $height     Desired height.
     * @param array  $thumbArgs  Additional arguments.
     *
     * @return string The thumbnail file path.
     */
    public function getThumb($filePath = '', $objectType = '', $fieldName = '', $width = 100, $height = 80, $thumbArgs = array())
    {
        if (empty($filePath) || !file_exists($filePath)) {
            return '';
        }
        if (!is_array($thumbArgs)) {
            $thumbArgs = array();
        }

        // compute thumbnail file path using a sub folder
        $pathInfo = pathinfo($filePath);
        $uploadHandler = new SimpleMedia_UploadHandler();
        $thumbFolder = $uploadHandler->getThumbnailFolderName($objectType, $fieldName);
        $thumbFilePath = $pathInfo['dirname'] . '/' . $thumbFolder . '/' . $pathInfo['filename'] . '_' . $width . 'x' . $height . '.' . $pathInfo['extension'];

        // return thumbnail file path if it is already existing
        if (file_exists($thumbFilePath)) {
            return $thumbFilePath;
        }

        // use Imagine library for creating the thumbnail image
        // documentation can be found at https://github.com/avalanche123/Imagine/tree/master/docs/en
        try {
            // create instance of Imagine
            $imagine = new Imagine\Gd\Imagine();
            // alternative
            // $imagine = new Imagine\Imagick\Imagine();

            // open image to be processed
            $image = $imagine->open($filePath);
            // remember the image size
            $originalSize = $image->getSize();

            if (isset($thumbArgs['crop']) && $thumbArgs['crop'] == true && isset($thumbArgs['x']) && isset($thumbArgs['y'])) {
                // crop the image
                $thumb = $image->crop(new Point($thumbArgs['x'], $thumbArgs['y']), new Box($width, $height));
            } else {
                // scale down thumbnails per default
                $thumbMode = Imagine\Image\ImageInterface::THUMBNAIL_INSET;
                if (isset($thumbArgs['thumbMode']) && $thumbArgs['thumbMode'] == Imagine\Image\ImageInterface::THUMBNAIL_OUTBOUND) {
                    // cut out thumbnail
                    $thumbMode = Imagine\Image\ImageInterface::THUMBNAIL_OUTBOUND;
                }

                // define target dimension
                $thumbSize = new Box($width, $height);
                // $thumbSize->increase(25); // add 25 pixels to x and y values
                // $thumbSize->scale(2); // double x and y values

                $thumb = $image->thumbnail($thumbSize, $thumbMode);
            }

            /**
             * You can do many other image manipulations here as well:
             *    resize, rotate, crop, save, copy, paste, apply mask and many more
             * It would even be possible to visualise the image histogram.
             * See https://github.com/avalanche123/Imagine/blob/master/docs/en/image.rst
             *
             * Small example from manual:
             *
             *     $bgColour = new Color('fff', 30).darken(40);
             *     $thumb = $image->resize(new Box(15, 25))
             *         ->rotate(45, $bgColour)
             *         ->crop(new Point(0, 0), new Box(45, 45));
             */

            /**
             * Create a new image with fully-transparent black background:
             *     $bgColour = new Color('000', 100);
             *     $thumb = $imagine->create($thumbSize, $bgColour);
             * Create a new image with a vertical gradient background:
             *     $thumb = $imagine->create($thumbSize)
             *         ->fill(
             *             new Imagine\Fill\Gradient\Vertical(
             *                 $size->getHeight(),
             *                 new Color(array(127, 127, 127)),
             *                 new Color('fff')
             *             )
             *         );
             */

            /**
             * If you want to do drawings with elements like ellipse, chord or polygon
             * see https://github.com/avalanche123/Imagine/blob/master/docs/en/drawing.rst
             *
             *     $centerPoint = new Point($thumbSize->getWidth()/2, $thumbSize->getHeight()/2);
             */

            /**
             * For font usage use
             * $font = $imagine->font($file, $size, $colour);
             */

            // save thumb file
            $saveOptions = array();
            if (in_array($pathInfo['extension'], array('jpg', 'jpeg', 'png'))) {
                $saveOptions['quality'] = $this->getDefaultQuality($pathInfo['extension']);
            }
            $thumb->save($thumbFilePath);

            // return path to created thumbnail image
            return $thumbFilePath;

        } catch (Imagine\Exception\Exception $e) {
            $dom = ZLanguage::getModuleDomain('SimpleMedia');
            // log this exception
            LogUtil::registerError(__f('An error occured during thumbnail creation: %s', array($e->getMessage()), $dom));
            // return the original image as fallback
            return $filePath;
        }
    }

    /**
     * Returns the quality to be used for a given file extension.
     *
     * @param string $extension The file extension
     *
     * @return integer the desired quality
     */
    protected function getDefaultQuality($extension)
    {
        return 85;
    }
    
}
