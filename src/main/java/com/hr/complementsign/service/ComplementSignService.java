package com.hr.complementsign.service;

import java.util.List;

import com.hr.complementsign.model.PendingComplementSign;

public interface ComplementSignService {

	List<PendingComplementSign> findPartComplementSign(String empNo);

	void saveComplementSign(PendingComplementSign pendingComplementSign);

	List<PendingComplementSign> findAllComplementSign(Integer mangaerNo);

	void saveAudittedComplementSign(PendingComplementSign pendingComplementSign, String type);

	void deletePendingComplementSign(PendingComplementSign pendingComplementSign);

	PendingComplementSign findById(int id);

}