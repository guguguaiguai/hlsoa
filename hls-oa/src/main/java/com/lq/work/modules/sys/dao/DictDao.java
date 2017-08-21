/**
 * 
 */
package com.lq.work.modules.sys.dao;

import java.util.List;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.lq.work.modules.sys.entity.Dict;

/**
 * 字典DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
}
