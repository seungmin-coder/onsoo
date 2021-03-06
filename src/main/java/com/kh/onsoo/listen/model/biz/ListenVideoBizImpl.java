package com.kh.onsoo.listen.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.onsoo.listen.model.dao.ListenVideoDao;
import com.kh.onsoo.listen.model.dto.ListenVideoDto;

@Service
public class ListenVideoBizImpl implements ListenVideoBiz {
	
	@Autowired
	private ListenVideoDao listenDao;

	@Override
	public List<ListenVideoDto> selectList(String member_id) {
		return listenDao.selectList(member_id);
	}

	@Override
	public ListenVideoDto selectOne(int listen_vclassno) {
		return listenDao.selectOne(listen_vclassno);
	}

	@Override
	public int insert(ListenVideoDto dto) {
		return listenDao.insert(dto);
	}

	@Override
	public int update(ListenVideoDto dto) {
		return listenDao.update(dto);
	}

	@Override
	public int delete(int listen_vclassno) {
		return listenDao.delete(listen_vclassno);
	}

}
