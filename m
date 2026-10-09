Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DA4E5346;
	Fri,  9 Oct 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553430; cv=pass; b=A1upQ+5MBgeOHIT9bPfKhBoLH86onirsmXz1cxKZeuSruzbl9GIBsns2PvL8HlJLsDnLNGygDegMelPWcceyc/nHRsn0pssl3zbMklXIMVbhaqRu0QwaCQs20GGtu+f1V8g8fPnt47fI0HkmgS/XZ/YtwID7ERJf+vvED4v1Haw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553430; c=relaxed/simple;
	bh=g8+WDc1j3VKc4pDoCI3Pqboo/nhAaEk3+5NfE0HS/sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQMeh8Wtb5VAGHg3AnQXNpTAGuezR6dqFo5/mLoB/3LGUeG+sDovetF3I1Z4+w06p3Mlwl8jhBqrkKls7gS7VPkBoz/sdOUOA0E5qNHZGww9AFDCecx4tA7MtaC9bnHdJD95/OcPavS6YxiNPtcmxcH/CbJ/f2m6WwArQYRIP3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=TqYoyFfB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="TqYoyFfB"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2E351202608;
	Fri, 09 Oct 2026 15:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwvRK61mF5DUwcVL8ArP+tIdn1DI+dPmobo+ldK9ti0=;
	b=TqYoyFfBlkrgdK2+vUm79m/PJZ2EIMlIGVVmfjB89eCzu0FP+X/Qt7v1aQr/wo0qzqFPO3
	btO19jq+N7GMKxXkvqIIf7Ud41Ix4Ii32CUjhCd63uaq8T+dRe6OTK2aoCUFkwUjBv16Ib
	cni1BRrzZ4WGKesm1NC15FhszhxWvqwCRtd9D0YOSmsggWa9/m+wvfVjrp6cUYcF9M8sds
	1mndZ8Yz0TWn+xAsseSmnH2iCsAZ3Rb0NrGie7DGyEmunosq7H7ZHACuObtIKq3FuHQZph
	Jloo+L0qRCYCcqvLx9LBiEGdAGlkRMiPIW7kUM0K7gafFF1cWsCD5BQiv+LQ7w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553422; a=rsa-sha256;
	cv=none;
	b=GM7ZWDTukgMOeMtZuX5mhWCAShZ7QSUryVNIJleHwsRzeKsYwb33Gbed8/4tY9ZhLvEc5O
	KFCkqzVtcvy5S3Wly9/lSbaZgks6KGBRz0BUeyOrus5JwCkIRAXugrwI2U92zt9R3BZAaj
	smv6z3o/SiYHLkBoWM0KJN43+jDffmLeueDlCWBTmeqMKKddGjgBEh95EYe0WIiR4k7sZz
	iYPJ4kr6YdvAyk6qDRpU5mj8uUeEEuSGZMehAwmcKsD/wPImM7iFBIUQWr8CxfYazodrMO
	AyrVH6Yjah31D5ceYX7f/sY3dHw31TNOCpvmKkcoSTowADXtTbpFMI/d+E+4kg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwvRK61mF5DUwcVL8ArP+tIdn1DI+dPmobo+ldK9ti0=;
	b=W3R3x1mDTtl9wEJpJ3Emy+ghReFpRJpM9cZQ5k4ATufG6Q7ccRbfrE1BUW+pc7CgPrO1io
	Gmzh1jv8x9vdB3ITtuWFaMKNv0QB0ITiru+Csv4g4cb6L1AQTFM65reDWGsJ0HEmlZtv+Y
	7UgMhgprMIt5gQPXvgtzX5/acJTz7lF1T+redEf7Qyl6xbNoTu3O4lUi9G1Jke3m18ZcTX
	WJ9PwhE801TCjLvsxQPQXc8hJ4uQVRvpv/F0+tIwT+9OuzqvnHUoUwl7Mtwae1iWsY1ccn
	E+i0jK/JPHJasXs/BU/H74KtlkPiRKPz1DwAkrcB4dqcg1HRQhKeuqKCmKmYsw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsw-0053To-0H;
	Fri, 09 Oct 2026 15:43:42 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B040B5BD8FB;
	Fri, 09 Oct 2026 13:43:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 36/37] can: ucan: fix repeated word 'is' in comment
Date: Fri,  9 Oct 2026 15:28:08 +0200
Message-ID: <20261009134323.64064-37-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hemanth Selam <hemanth.selam@gmail.com>

Drop the second 'is', reported by checkpatch.pl as a possible repeated
word. Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Link: https://patch.msgid.link/20260904125018.10923-1-hemanth.selam@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index f72e0644c5fd..6b088a05a901 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -61,7 +61,7 @@
  *    the following way:
  *
  *	m[n].len <=> the length if message n(including the header in bytes)
- *	m[n] is is aligned to a 4 byte boundary, hence
+ *	m[n] is aligned to a 4 byte boundary, hence
  *	  offset(m[0])	 := 0;
  *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
  *
-- 
2.53.0

