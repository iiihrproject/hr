package com.hr.bulletin.repository.Impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.print.attribute.standard.Media;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.hr.bulletin.model.BulEnroll;
import com.hr.bulletin.model.BulLike;
import com.hr.bulletin.model.BulMessage;
import com.hr.bulletin.model.BulName;
import com.hr.bulletin.model.Bulletin;
import com.hr.bulletin.repository.BulletinRepo;

@Repository
public class BulletinRepoImpl implements BulletinRepo {

	@Autowired
	EntityManager entityManager;

	// 執行新增
	@Override
	public void insert(Bulletin bulletin) {
		if (bulletin != null)
			entityManager.persist(bulletin);
	}

	// 執行新增
	@Override
	public void insertMsg(BulMessage bulMassage) {
		if (bulMassage != null)
			entityManager.persist(bulMassage);
	}

//	執行查詢單筆
	@Override
	public Bulletin findById(int postno) {
		return entityManager.find(Bulletin.class, postno);
	}

//	查詢多筆(管理)
	@Override
	public List<BulName> findAll() {

		String hql = "SELECT b.postno, b.type, b.title, b.desText, b.postDate, b.exp, b.quotatype, b.quota, b.postStatus, b.endDate, "
				+ "(SELECT count(e.enrollStatus) FROM BulEnroll e  WHERE e.enrollStatus = \'參加\' AND e.postno= b.postno GROUP BY e.postno),"
				+ "(SELECT count(l.likeStatus) FROM BulLike l  WHERE l.likeStatus = \'喜歡\' AND l.postno= b.postno GROUP BY l.postno) "
				+ "FROM Bulletin b "
//				+ "LEFT OUTER JOIN BulEnroll e "
//				+ "with b.postno = e.postno "
//				+ "LEFT OUTER JOIN BulLike l "
//				+ "with b.postno = l.postno "
				+ "ORDER BY b.postno desc";

//		String hql = "SELECT b.postno, b.type, b.title, b.desText, b.postDate, b.exp, b.quotatype, b.quota, b.postStatus, b.endDate, "
//				+ "(SELECT count(e.enrollStatus) FROM BulEnroll e  WHERE e.enrollStatus = \'參加\' AND e.postno= b.postno GROUP BY e.postno)"
//				+ "FROM Bulletin b left outer join BulEnroll e "
//				+ "with b.postno = e.postno "
//				+ "ORDER BY b.postno desc";	

//		String hql = "SELECT b.postno, b.type, b.title, b.desText, b.postDate, b.exp, b.quotatype, b.quota, b.postStatus, count(e.enrollStatus )"
//				+ "FROM Bulletin b left outer join BulEnroll e "
//				+ "with b.postno = e.postno "
//				+ "GROUP BY b.postno, b.type, b.title, b.desText, b.postDate, b.exp, b.quotatype, b.quota, b.postStatus "
//				+ "ORDER BY b.postno desc";	

		List<Object[]> objects = entityManager.createQuery(hql).getResultList();
		System.out.println("query.list().size()=" + entityManager.createQuery(hql).getResultList().size());
		List<BulName> mylist = new LinkedList<BulName>();

		BulName ab;
		for (Object[] object : objects) {
			ab = new BulName();

			ab.setPostno((int) object[0]);
			ab.setType((String) object[1]);
			ab.setTitle((String) object[2]);
			ab.setDesText((String) object[3]);
			ab.setPostDate((Date) object[4]);
			ab.setExp((Date) object[5]);
			ab.setQuotatype((String) object[6]);
			if (object[7] == null) {
			} else {
				ab.setQuota((int) object[7]);
			}
			ab.setPostStatus((String) object[8]);
			ab.setEndDate((Date) object[9]);
			if (object[10] == null) {
			} else {
				try {
					ab.setEnCount((long) object[10]);
				} catch (Exception e) {

				}
			}
			if (object[11] == null) {
			} else {
				try {
					ab.setLikeCount((long) object[11]);
				} catch (Exception e) {

				}
			}

			mylist.add(ab);

		}
//		return entityManager.createQuery(hql).getResultList();
		return mylist;

//		String hql = "SELECT count(e.enrollStatus)"
//				+ "FROM Bulletin b join BulEnroll e  "
//				+ "WITH b.postno = e.postno "
//				+ "GROUP BY b "
//				+ "ORDER BY b.postno desc";
//		
//		String hql = "SELECT count(e.enrollStatus) FROM BulEnroll e";

//		String sql = "select * from bulletin b join (select postno, count(enrollstatus) as enrollcount \n"
//				+ "from bulenroll \n"
//				+ "where enrollstatus='參加' \n"
//				+ "group by postno )e \n"
//				+ "on b.postno = e.postno";

//		return entityManager.createQuery(hql).getResultList();
	}

//	查詢多筆(管理)
//	@Override
//	public List<Bulletin> findAll() {
//		String hql = "FROM Bulletin b order by postno desc";
//		return entityManager.createQuery(hql, Bulletin.class).getResultList();
//	}

//	查詢多筆(管理)
//	@Override
//	public List<List> findAll() {
////		String hql = "From Bulletin b JOIN (SELECT postno, count(enrollStatus) as eCount from Bulenroll where enrollStatus='參加' group by postno )e on b.postno = e.postno order by postno desc";
////		String hql = "SELECT b.postno, type, title, desText, postDate, exp, quotatype, quota, count(enrollStatus), postStatus"
//		
////		TypedQuery<Media> query = entityManager.createQuery( "SELECT b, count(e.enrollStatus)"
////				+ "FROM Bulletin b ,BulEnroll e  "
////				+ "where b.postno = e.postno "
////				+ "group by b.postno, type, title, desText, postDate, exp, quotatype, quota, postStatus "
////				+ "order by postno desc", Media.class);
////		return entityManager.createQuery(hql, Bulletin.class).getResultList();
//	}

//	查詢多筆(使用者)
	@Override
	public List<BulName> userFindAll() {
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		Date d = new Date();

		String hql = "SELECT b.postno, b.type, b.title, b.desText, b.postDate, b.exp, b.quotatype, b.quota, b.postStatus, b.endDate, "
				+ "(SELECT count(e.enrollStatus) FROM BulEnroll e  WHERE e.enrollStatus = \'參加\' AND e.postno= b.postno GROUP BY e.postno),"
				+ "(SELECT count(l.likeStatus) FROM BulLike l  WHERE l.likeStatus = \'喜歡\' AND l.postno= b.postno GROUP BY l.postno) "
				+ "FROM Bulletin b "
				+ "WHERE b.exp>=:ts AND b.postDate<=:ts "
				+ "ORDER BY b.postno desc";

		List<Object[]> objects = entityManager.createQuery(hql).setParameter("ts", ts).getResultList();
		List<BulName> mylist = new LinkedList<BulName>();

		BulName ab;
		for (Object[] object : objects) {
			ab = new BulName();

			ab.setPostno((int) object[0]);
			ab.setType((String) object[1]);
			ab.setTitle((String) object[2]);
			ab.setDesText((String) object[3]);
			ab.setPostDate((Date) object[4]);
			ab.setExp((Date) object[5]);
			ab.setQuotatype((String) object[6]);
			if (object[7] == null) {
			} else {
				ab.setQuota((int) object[7]);
			}
			ab.setPostStatus((String) object[8]);
			ab.setEndDate((Date) object[9]);
			if (object[10] == null) {
			} else {
				try {
					ab.setEnCount((long) object[10]);
				} catch (Exception e) {

				}
			}

			mylist.add(ab);

		}
		System.out.println("表：" + new Gson().toJson(mylist));
		return mylist;

	}

//	查詢多筆(使用者)
//	@Override
//	public List<BulName> userFindAll() {
//
//		Date d = new Date();
//
//		String hql = "SELECT b.postno, b.type, b.title, b.desText, b.postDate, b.exp, b.quotatype, b.quota, b.postStatus, b.endDate, "
//				+ "(SELECT count(e.enrollStatus) FROM BulEnroll e  WHERE e.enrollStatus = \'參加\' AND e.postno= b.postno GROUP BY e.postno)"
//				+ "FROM Bulletin b left outer join BulEnroll e " + "with b.postno = e.postno "
//				+ "ORDER BY b.postno desc";
//
//		List<Object[]> objects = entityManager.createQuery(hql).getResultList();
////		System.out.println("query.list().size()=" + entityManager.createQuery(hql).setParameter("ts", ts).getResultList().size());
//		List<BulName> userlist = new LinkedList<BulName>();
//
//		BulName ab;
//		for (Object[] object : objects) {
//			if (d.before((Date) object[4]) || d.after((Date) object[5])) {
//				System.out.println("true:"+(Date) object[4]+"主旨:"+(String) object[2]+"exp:"+(Date) object[5]);
//			} else {
//			ab = new BulName();
//
//			ab.setPostno((int) object[0]);
//			ab.setType((String) object[1]);
//			ab.setTitle((String) object[2]);
//			ab.setDesText((String) object[3]);
//			ab.setPostDate((Date) object[4]);
//			ab.setExp((Date) object[5]);
//			ab.setQuotatype((String) object[6]);
//			if (object[7] == null) {
//			} else {
//				ab.setQuota((int) object[7]);
//			}
//			ab.setPostStatus((String) object[8]);
//			ab.setEndDate((Date) object[9]);
//			if (object[10] == null) {
//			} else {
//				try {
//					ab.setEnCount((long) object[10]);
//				} catch (Exception e) {
//
//				}
//			}
//				System.out.println("false:"+(Date) object[4]+"主旨"+(String) object[2]+"exp:"+(Date) object[5]);
//				userlist.add(ab);
//				System.out.println("mylist:"+userlist);
//			}
//		}
//		System.out.println("表：" + new Gson().toJson(userlist));
//		return userlist;
//
//	}

	// 查詢未過期多筆
	@Override
	public List<Bulletin> findAllPosting() {
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		String hql = "FROM Bulletin b WHERE b.exp>=:ts AND b.postDate<=:ts order by postDate desc ";
		return entityManager.createQuery(hql, Bulletin.class).setParameter("ts", ts).getResultList();
	}

//	留言查詢多筆
	@Override
	public List<BulMessage> findAllMsg(int postno) {
		String hql = "FROM BulMessage m WHERE m.postno=:no order by createTime";
		return entityManager.createQuery(hql, BulMessage.class).setParameter("no", postno).getResultList();
	}

	// 執行修改(原圖)
	@Override
	public void updateop(Bulletin bulletin) {
		Bulletin bul = findById(bulletin.getPostno());

		System.out.println("1updateFile1:" + bulletin.getFile1());
		System.out.println("2updateFile1:" + bul);

		bulletin.setType(bul.getType());
		bulletin.setPostStatus(bul.getPostStatus());
		bulletin.setFile1(bul.getFile1());
		bulletin.setPicture(bul.getPicture());
		bulletin.setCreateTime(bul.getCreateTime());

		entityManager.detach(bul);
		entityManager.merge(bulletin);
	}

//執行修改(改圖)
	@Override
	public void update(Bulletin bulletin) {
		Bulletin bul = findById(bulletin.getPostno());

		System.out.println("1updateFile1:" + bulletin.getFile1());
		System.out.println("2updateFile1:" + bul);

		bulletin.setType(bul.getType());
		bulletin.setPostStatus(bul.getPostStatus());
		bulletin.setCreateTime(bul.getCreateTime());

		if (bulletin.getFile1()=="undefined"||bulletin.getFile1()=="null") {
			System.out.println("----filename:" + bulletin.getFile1());
			bul.setFile1(null);
		}

		entityManager.detach(bul);
		entityManager.merge(bulletin);

	}

//	執行刪除
	@Override
	public void delete(int postno) {
		Bulletin bul = entityManager.find(Bulletin.class, postno);
		entityManager.remove(bul);
	}

// 留言修改
	@Override
	public void delMsg(int id) {
		BulMessage bulM = entityManager.find(BulMessage.class, id);
		BulMessage bulMessage = new BulMessage();

		bulMessage.setId(bulM.getId());
		bulMessage.setCreateTime(bulM.getCreateTime());
		bulMessage.setEmpName(bulM.getEmpName());
		bulMessage.setEmpNo(bulM.getEmpNo());
		bulMessage.setMessage(bulM.getMessage());
		bulMessage.setMessageDate(bulM.getMessageDate());
		bulMessage.setPostno(bulM.getPostno());
		bulMessage.setMsgStatus("已刪除");

		entityManager.detach(bulM);
		entityManager.merge(bulMessage);

	}

	// Like
	@Override
	public BulLike findLikeByno(String empNo, int postno) {
		String hql = "FROM BulLike l WHERE l.empNo=:en AND l.postno=:pn";
		return entityManager.createQuery(hql, BulLike.class).setParameter("en", empNo).setParameter("pn", postno)
				.getSingleResult();
	}

	// Like
	@Override
	public void changeLike(BulLike bulLike) {

		System.out.println(bulLike);
		entityManager.merge(bulLike);

		System.out.println("--id:" + bulLike.getId());
		System.out.println("--no:" + bulLike.getEmpNo());
		System.out.println("--status:" + bulLike.getLikeStatus());
		System.out.println("--postno:" + bulLike.getPostno());

	}

	// enroll
	@Override
	public BulEnroll findEnrollByno(String empNo, int postno) {
		String hql = "FROM BulEnroll l WHERE l.empNo=:en AND l.postno=:pn";
		return entityManager.createQuery(hql, BulEnroll.class).setParameter("en", empNo).setParameter("pn", postno)
				.getSingleResult();
	}

	// enroll
	@Override
	public void insertEnroll(BulEnroll bulEnroll) {
		entityManager.merge(bulEnroll);
	}

//	查詢多筆報名名單
	@Override
	public List<BulEnroll> findEnrollListByNo(int postno) {
		String hql = "FROM BulEnroll e WHERE e.postno=:pn ORDER BY updateTime";
		return entityManager.createQuery(hql, BulEnroll.class).setParameter("pn", postno).getResultList();
	}

	@Override
	public List<BulName> findMyEnrollByEmpNo(String empNo) {
		
//		String hql = "SELECT e.postno, e.enrollStatus,  "
//				+ "(SELECT b.title, b.postDate FROM Bulletin b  WHERE e.postno= b.postno ), "
//				+ "FROM BulEnroll e "
//				+ "WHERE e.empNo=:en AND e.enrollStatus=\'參加\' ORDER BY updateTime";
		
		String hql = "SELECT e.postno, e.enrollStatus, b.title, b.postDate  "
				+ "FROM BulEnroll e LEFT OUTER JOIN Bulletin b on e.postno= b.postno "
				+ "WHERE e.empNo=:en AND e.enrollStatus=\'參加\' ORDER BY updateTime";

		List<Object[]> objects = entityManager.createQuery(hql).setParameter("en", empNo).getResultList();
		List<BulName> mylist = new LinkedList<BulName>();

		BulName ab;
		for (Object[] object : objects) {
			ab = new BulName();

			ab.setPostno((int) object[0]);
			ab.setEnrollStatus((String) object[1]);
			ab.setTitle((String) object[2]);
			ab.setPostDate((Date) object[3]);		

			mylist.add(ab);

		}
		return mylist;

	}
	
//	查詢多筆報名名單
	@Override
	public List<BulEnroll> findEnrollNumByNo(int postno) {
		String hql = "FROM BulEnroll e WHERE e.postno=:pn AND e.enrollStatus=\'參加\' ORDER BY updateTime";
		return entityManager.createQuery(hql, BulEnroll.class).setParameter("pn", postno).getResultList();
	}
	

}
