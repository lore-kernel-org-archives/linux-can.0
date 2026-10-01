Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0B526AB9;
	Thu,  1 Oct 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867957; cv=pass; b=YOsU8b468jOe+WaqlWfF3Mz+84zamrHfTpB5osMS6SnINwDh28qweON5wrGmiQZSPnwT9k4xotREXh8C08j08gwedKQQ7Ps/q801b3d2qnZgMGqlHzMQh25skEP9qYdTcLvsLtmwXD6m+KzO57Qhb8tJNazxucmygglU4s/6DsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867957; c=relaxed/simple;
	bh=gs7MkB6xzO4HqTZdlby0bA7nSCXljWicwHy41m8dwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJuracbJIiUdVbew67Wir4wjNxAb7jLVdudTbQyPxJvPJrQjOZci24qrX4kC6gAbGgQSs+58tOE21C7Jjvdt8x8xkgUhSQDuGjkzb5/hVxHxDYdV33kMak2C+k5XqpcSilDv4dgR24bEocAW3wWwhIpqyh/FE5OWnbeKL4oGeA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Gck8rLNr; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Gck8rLNr"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8937020233D;
	Thu, 01 Oct 2026 17:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790867947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Pbql3jM2h+XQKKDD3YOErfFls3O9mp2dTU2TmksF8M=;
	b=Gck8rLNrJ2o5mzdEY8uV6lN29Sz4FRJzNVYId3x3vVsSlnAdzRigtreb/8KGP1U7Yh60Ab
	uIceXWNa3IHThYXr5u5gVZOZZhRUcyUPBTDlMCfJH0pj5/tHipDTZmKK3JR5f3U2CnK3JI
	d94mTD42kUdRwIuFH3K9CDt18IQ7v2O9pjl9NA9KNeUR0q4342dDaPDrYRFgdvzJ4ZH8FJ
	NkA2YoOpj6igD3/H9IS3rHgTcVV/rbNCU1cQzNK52tbnaYo2oWIxbGEq5gT+SU/msQd8jS
	bSPiU6GwXeKs/WFm97N4OXOFJAtJiVkg/XebSrFKlJ+J+/Z5Hc6iGSIuWkldXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790867947; a=rsa-sha256;
	cv=none;
	b=XTKG3gSQDdVET0dc6GUrEWU1hc9aiHaeAHx591idbIxTSepzQfwZjXyNRBfqYjoCmuh3zj
	VCwC7qontVAKLmWJbo0IWzaletsq2YjHLpvXOGI5ESemHvz/ss6HzvNWxYEem9ypoYAADI
	SsKtr43cuTx8MSXb75TPtwmnPzM4Jf+6uZvWq4WrMVBf6axMCyUpjLIeiw1M2u561ON1Qh
	kC9rzxu/GvgThanMJuenHB/0dRzSTuIrupkOY41dKka1H2SUcXOiLjaZeYzxuxePjNd49Z
	dnoYaY/1jlBnSNmspmXBPrH2qvGm2PPjUhq88eg/DtXigm/5KBORW3+oz4Q5lg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790867947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Pbql3jM2h+XQKKDD3YOErfFls3O9mp2dTU2TmksF8M=;
	b=ITl9MJ9JUHbcDfHVhancgVACnAzRNXVnhTWn8X26sOMSbGONRzp1gdSWgl/fGICHqJ0Tm5
	7pL9dXQfMS6UPO9p7Zj4coxMhEhh5YL5V3xUB5V6MLQNH8RhQft8ivxuJ+KloDFnyBj7ho
	RZ2C0zgRK27yhTrN9QtHocKHnYFke8cpJLbzIW2RSTde0o0ArgkIOMqu7aa2+SvNHGg6gQ
	CvfRHWm1w/qDdPNF4F2448P/E1bIsDH+xfHRM5v1CXIu+WfwcRbAed6APkUTxsVOmJ9gMR
	WsMGTgiTbq2hkQSBgH7RN2ViMOQSqieVrm2MqAVWn408F6XacmbcFkztuh1yKw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCIYt-003kSc-1R;
	Thu, 01 Oct 2026 17:19:07 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20F3C5B7980;
	Thu, 01 Oct 2026 15:19:07 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/3] pull-request: can 2026-10-01
Date: Thu,  1 Oct 2026 17:14:22 +0200
Message-ID: <20261001151905.1556270-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 3 patches for net/main.

The first patch is by zjamg and restores the skb header initialization
lost during the v7.0 release cycle.

Oliver Hartkopp contributes a patch for the CAN net layer to fix the
unique skb identifier regression under RPS, introduced in the v7.0
release cycle, which causes lost packets.

The last patch is by Ji-Ze Hong and fixes a struct size mismatch in
the f81604 CAN driver, which results in a TX starvation.

regards,
Marc

---

The following changes since commit e23a64eb244356ee47c0620f0722d51bd88db522:

  Merge tag 'nf-26-09-30' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2026-10-01 12:00:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.3-20261001

for you to fetch changes up to 7f85d1170575645f9f327062d78017a23b2714eb:

  usb: f81604: fix struct f81604_int_data size mismatch (2026-10-01 17:13:12 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.3-20261001

----------------------------------------------------------------
Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

zjamg (1):
      can: dev: init_can_skb(): restore skb header initialization

 drivers/net/can/dev/skb.c    |  4 ++++
 drivers/net/can/usb/f81604.c |  2 +-
 drivers/net/can/vxcan.c      |  3 +++
 include/linux/can/core.h     |  3 ++-
 include/linux/can/skb.h      |  4 +++-
 include/net/can.h            |  2 ++
 net/can/af_can.c             | 47 +++++++++++++++++++++++++++++++++-----------
 net/can/gw.c                 |  3 +++
 net/can/isotp.c              | 16 +++++++++------
 net/can/raw.c                | 10 +++++++---
 10 files changed, 71 insertions(+), 23 deletions(-)
