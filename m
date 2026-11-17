Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953325;
	b=eiMVVn4wC55edMtDhFpKugPar1BunAdW9SznSxrXPsfPEK7ijG0yKOtgd/41d0FIdvGk
	 rTMIMVRlbR2QsraB5lk4498J14ZuMKlczTsruey/mBtKWHQgLNInohPRmTKlnU+486Zsk
	 6gfWNFgdkCQJziOf4dlD6xujnuzLRLf8BX27It2wN+DC5lBHiDQDHNGl2U3zPu0CH0toV
	 OSprP0NCl07/awYY2WC+HOdwuWBcFWxCISiiPBTlWUNIR7j+MUcVDWlIRkdiJc4A05YJP
	 YpsE3z4e0tNIIy9+qaOZ8QtfwjoihqPuIB2+WO7UiW410X+OXBuN1/S3XDrjGg388lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U9WrnK7iN8bTNr/VYkHMMZ4pgtp7xdDI3TtNZQIIT/g=;
	b=dakKhUHCMVA/VY2embvGpXYcjAKorNI8W7LJUkjE3BTrmZQWSvRyRL2a62JkWuDpD6fN
	 2quRvuclyD95l9salIXONkgAWnZBxq84IfWjUfir898EZtP+Q3X4B7c9KQNhvDJ27jHHz
	 KJLZQ0w2yldXdGX6Z5/ghsDe+xv+EVWLOLUd0HRuFkVMOLsqi/A7ajWp0ZNetX3MabtQN
	 sVgwLjP/lmDTyCFv6+5VibDHRDOMrv5B95HXeMMyfBUkyS+Wfs5yErt/e+wvUNDje/UjM
	 zn9k971PgQtkjNupAa5iJ2s28AWN+Gr0baBaSd1+vhtuY/cEtCIgQtc57aU2kUwPLlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Ix4/YIzG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC4606A330;
	Tue, 17 Nov 2026 22:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83CC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ix4/YIzG
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4906E205A36;
	Tue, 17 Nov 2026 23:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9WrnK7iN8bTNr/VYkHMMZ4pgtp7xdDI3TtNZQIIT/g=;
	b=Ix4/YIzGd17gR8iSgIrRVl//dhZ7BCBcDdpCmWGKaRIrTxujQrwKjlhvusKrysc7Zkl5Ap
	TJX3vCzkJprrZDyBm6pVLG26zx53RHlN1TCWhU8dEAjAH9d8OAQn6BqBSHIzlPhCF8ia3q
	QA4035QVWsvcV0BqovKwWkhfUzDt3GmWg96yrZlN1wVedfqlWQWMbaIunk0I7eKKxHZL/3
	z8oHiOZ6KxRMDrHfAlFTwzLmCUrpYgDlgcy2aCE4mu/3EE5aay+Da9oC/3wT+g0Go3USEs
	8Wg/3M35Xwo14uVSxK0m32ccxjPSr0Vzh0YnXtc14c7z74JTMD/OgKbt2KsrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9WrnK7iN8bTNr/VYkHMMZ4pgtp7xdDI3TtNZQIIT/g=;
	b=DQPoAl5CdUTE4COzolobVbVRzJEQQvSylZNXf+ezWnxxUGaV0fDgQXJkmxLyhA7rdaBM0C
	WL5ZbmUxNZ8Aaf1w3NK+Hq/zurp85MJ25nHTIAQjYjCehro3JqEUNBN3xF9sNtRgNsEaN3
	wveNDdwZEuoeQ4GHuEMvf+csNV5v1E7w8F5VwLdSm0MBzpTJur21vVXrQdSlbo6UVtTEEI
	GVUNJk3CCIm4smCGqG43MqGJWyIKNfffCKh4OcwgfVNVqX9++IJl3PZIjnfFElLnWmjz9M
	3R2gYZ2IvG2HOZaHqVQ3nd4XvaIiya3DiLex5bTeHyZ+MQXqFqKkA96V2p9Cfg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953317; a=rsa-sha256;
	cv=none;
	b=dk0+WcZ+YvhZBtvsl//jGk+EoZ0s0hdeDoRJhx9szb49w6R14VqmDuqUg/tUqO7LuFdLL9
	UHOsl2aYJ1wg2pwBXraNksMZvsqCkCwYsllLiP23/VCsXkqDCT00dqXnrwRUJ92nKvo0rE
	hE3kCFsU6XNNJDOAwKMod7bMwb9Y9AdEpJQQ+wUePqSQnKb7bppnx6CVKFxPJPJjLpnZMe
	knS5IHtlEBG+x4t7jfa8Ai5zoQAU4uKGc8fOwdiVbJ1rdj+S3gcVLalpJvWTsl9jMPM6/y
	LabpB3FKqarO24EZrbhyLy1aPPwFUeRnA7Wn1Oi/SWeqk9r87JJFWq8IZkQWGQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRLw-000FmJ-28;
	Tue, 17 Nov 2026 23:08:37 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EAD6B5EDA23;
	Tue, 17 Nov 2026 22:08:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/11] pull-request: can 2026-11-17
Date: Tue, 17 Nov 2026 23:03:05 +0100
Message-ID: <20261117220818.1142581-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 11 patches for net/main.

The first 7 patches are by Oliver Hartkopp and avoid RTNL stalls in
CAN_RAW, CAN_ISOTP and CAN_BCM protocols and fix CAN_ISOTP issues.

Followed by 3 patches are by Zhu Ling that fix problems with the CAN
netlink handling.

A patch by my fixes a kernel memory information leak over USB in the
gs_usb driver.

regards,
Marc

---

The following changes since commit 5e9b2ad9b8384cd3c417cd5e2c3bc7eee4a72791:

  net/mlx5e: rep, Fix races between devcom PAIR event and uplink close (2026-11-17 16:12:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.4-20261117

for you to fetch changes up to b772103b7a4feeee02fa12a3223a7fb5a5a8a81c:

  can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB (2026-11-17 22:26:21 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.4-20261117

----------------------------------------------------------------
Marc Kleine-Budde (2):
      Merge patch series "can: avoid RTNL stalls and fix CAN_ISOTP and netlink issues"
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB

Oliver Hartkopp (7):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()
      can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
      can: isotp: reject socket options while a transfer is active

Zhu Ling (3):
      can: netlink: fix static FD-NON-ISO mode validation
      can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
      can: netlink: fix CAN XL PWM attribute sizing

 drivers/net/can/dev/netlink.c |  22 +++++---
 drivers/net/can/usb/gs_usb.c  |   2 +-
 net/can/bcm.c                 | 114 ++++++++++++++++++++++++++++++------------
 net/can/isotp.c               |  50 +++++++++++-------
 net/can/raw.c                 |  41 ++++++++-------
 5 files changed, 153 insertions(+), 76 deletions(-)

