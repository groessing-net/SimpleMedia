<?php
/**
 * SimpleMedia.
 *
 * @copyright Axel Guckelsberger
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Axel Guckelsberger <info@guite.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Mon Nov 28 12:34:51 CET 2011.
 */


/**
 * Repository class used to implement own convenience methods for performing certain DQL queries.
 *
 * This is the concrete repository class for medium entities.
 */
class SimpleMedia_Entity_Repository_Medium extends SimpleMedia_Entity_Repository_Base_Medium
{
    /**
     * Select with a given where clause.
     *
     * @param string  $where    The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $orderBy  The order-by clause to use when retrieving the collection (optional) (default='').
     * @param boolean $useJoins Whether to include joining related objects (optional) (default=true).
     *
     * @return ArrayCollection collection containing retrieved SimpleMedia_Entity_Medium instances
     */
    public function selectWhere($where = '', $orderBy = '', $useJoins = true)
    {
        $customWhere = $this->getCustomConditions();
        if (!empty($customWhere)) {
            if (!empty($where)) {
                $where .= ' AND ';
            }
            $where .= $customWhere;
        }

        return parent::selectWhere($where, $orderBy, $useJoins);
    }

    /**
     * Select with a given where clause and pagination parameters.
     *
     * @param string  $where          The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $orderBy        The order-by clause to use when retrieving the collection (optional) (default='').
     * @param integer $currentPage    Where to start selection
     * @param integer $resultsPerPage Amount of items to select
     * @param boolean $useJoins       Whether to include joining related objects (optional) (default=true).
     *
     * @return Array with retrieved collection and amount of total records affected by this query.
     */
    public function selectWherePaginated($where = '', $orderBy = '', $currentPage = 1, $resultsPerPage = 25, $useJoins = true)
    {
        $customWhere = $this->getCustomConditions();
        if (!empty($customWhere)) {
            if (!empty($where)) {
                $where .= ' AND ';
            }
            $where .= $customWhere;
        }

        return parent::selectWherePaginated($where, $orderBy, $currentPage, $resultsPerPage, $useJoins);
    }

    /**
     * Get additional where clauses.
     */
    private function getCustomConditions()
    {
        $func = FormUtil::getPassedValue('func', '', 'GET', FILTER_SANITIZE_STRING);
        if ($func == 'display') {
            return '';
        }

        $onlyImages = (int) FormUtil::getPassedValue('onlyimages', 0, 'GETPOST', FILTER_VALIDATE_INT);
        $catID = (int) FormUtil::getPassedValue('catid', 0, 'GETPOST', FILTER_VALIDATE_INT);
        $keyword = FormUtil::getPassedValue('keyword', '', 'GETPOST', FILTER_SANITIZE_STRING);
        $where = '';

        if ($catID > 0) {
            $where .= 'tblCategories.category = ' . DataUtil::formatForStore($catID);
        }

        if ($onlyImages == 1) {
            $where .= (!empty($where)) ? ' AND ' : '';
            $where .= '(LOWER(tbl.theFile) LIKE \'%.gif\' OR LOWER(tbl.theFile) LIKE \'%.jpg\' OR LOWER(tbl.theFile) LIKE \'%.jpeg\' OR LOWER(tbl.theFile) LIKE \'%.jpe\' OR LOWER(tbl.theFile) LIKE \'%.png\' OR LOWER(tbl.theFile) LIKE \'%.bmp\')';
        }

        if (!empty($keyword)) {
            $where .= (!empty($where)) ? ' AND ' : '';
            $where .= '(tbl.title LIKE \'%' . DataUtil::formatForStore($keyword) . '%\' OR tbl.description LIKE \'%' . DataUtil::formatForStore($keyword) . '%\')';
        }

        return $where;
    }

    /**
     * Helper method to add join selections.
     *
     * @return String Enhancement for select clause.
     */
    protected function addJoinsToSelection()
    {
        $selection = ', tblCategories';
        return $selection;
    }

    /**
     * Helper method to add joins to from clause.
     *
     * @param Doctrine\ORM\QueryBuilder $qb query builder instance used to create the query.
     *
     * @return String Enhancement for from clause.
     */
    protected function addJoinsToFrom(QueryBuilder $qb)
    {
        $qb->leftJoin('tbl.categories', 'tblCategories');
        return $qb;
    }
}