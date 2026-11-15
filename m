Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736674;
	b=2t6zQQQB+k7SNqtEYRAYWxMFxevkeWN0+Ctb9t3zZIl/vORveXDbbILoQevgekUu+BxB
	 8vC5uMaF7P488XaWGU2pTLY3412MWJ8kx619Y8rEeBnfzrpJpuslR9SMrNjK+nkJ7M2I8
	 3Wmn9f8MmPkhaAHdUx8pjEHrJ+nZ77wROxvF17vwElgDjiT1evp7hkh0CzuT3+FxYUpFF
	 HVT4TVwScYqIX+j9d1akjdmF34mHmv/nMEJD8rjQFlpLcP4EVetcsnORrQP8BP//CvGQw
	 cyfbX4X8vktZy/QXUXFHBAsycNFFXA+SDY1wYoe0yNeAbB/GlRxrZt4k1jJFwBgKA7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b0f7y6aJ4qU3mQm4d7rAxcNcJOa4auBZkUYDTEPNs2w=;
	b=UakFtxki5u8tXjW0DXrBbNYCkADeIBcDOry0rZxUwlCnJf3lCAZUGBUBhFW0uGXI7W8q
	 dOlEdQrGQ4wvy1nOgt0H8ySPPAH5NW46DLNWsPnmEAaIfqDeRou/bOOMwKA1ecoWgs9rf
	 z0FelY0K+qZ/ljr2TSNqsPoEeELdMF+L0yzYlao2uR1yuIrJbHojgq6QYUyhIrDVZihlw
	 z9o9tDx6wDwuZpk6615JPHj7IBECUK+p59DOI5kzDWEyG2IJilbKavB4ujc7bWfI6Am01
	 Dk+hAdrxn1tgSPcSr6V8PToEUpMbZc3VAfbT49jeS+w7G83kV1LpHMfF0P5PkmbSVKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XR6WzWRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD2606A327;
	Sun, 15 Nov 2026 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FD2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XR6WzWRi
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 46035201CE0;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0f7y6aJ4qU3mQm4d7rAxcNcJOa4auBZkUYDTEPNs2w=;
	b=XR6WzWRi1Uf0Sl6YALGL7apiKIFvEeZM2vSlCtw/8SMPvpmY6F9klzUYWf46+JxBO39Vrl
	m0or1v78MaB5nSkHhs3AClNMOKgsdjT+cbAug4rKZFrKYKn80+tXnoKsIFLi+V2exN6UCr
	LcmkW6kTHejebflZmHg7vMVsMJqP8EJp/4bWl1bYLeVYCcoN+YSZXDL6pZ/vDHSdZqpEbw
	pL2XAtBp4FktaxLnvdIMmXyNfTwiUEokor5TgHBML9+B6vPaYEvl3yxGRM1GqNTq/SCor/
	qQmZwrXx36pAXdffL5A+nhJ/hdbXfW3WkqOr2oXzhKSe/zJjumFc7g4nSiGQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0f7y6aJ4qU3mQm4d7rAxcNcJOa4auBZkUYDTEPNs2w=;
	b=HxFk6+DOxXOkmW3cM7a+BoMyDLyTLcBbOkXujOmJoGa6IalbPosphVH/WRexeFfIHF/QNe
	CpE/3bNESBrUTCMGroiUq62PRyVQX8bzKTrshnnyXBFkKbrpj99+99ro+oBIyrLXSoWG+Q
	leJ2LrKi4VXC3wSbE3fmWkx3Hl5l6bELMn4+jrIXl9BFrdnJUZJ3qHJ10QbQHtACINH3/c
	HRC982wuTG6qrhUIdExOnuswGCSFFBoaDm4V6wk+7eFFqsbK6Ns1BVZiR0mZqPTrCYNV28
	TjVP/ejgtx7zzpzc8hGCdlrtxsyFKHzrIX7WqzQxG4N4Y6OvsRqgQegwSHH/Qg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=fUk1kc/tSPSYVjueSIDMAcfsegLABVN7VRrtxRSrmckuOz9e38DB23IWU/x+CovIT711dA
	SLDj+5m57EScxoeu9TFI03ssxGU0gLFVNlShBOUVMc9mt5Ol/QWN+t35DJ6yy+s0fbU5qY
	mIgkvfojjJGDRyhCAG8poq4nVu90nq2JC2q0wCP8G+/QNDGtgt1W0Z+lMOQAQdArbrM/h8
	qEZ/FE8f3y7ZGVUsCD65LxJSj3qbsgueJ1cQ0u7diEqKxfN8xUyF64IKVIkGtErIXh1qh2
	uMwIN6H3CA/47O+wN7qHwU3YNOIku8Jr2QuH3qmhcuKji/YEOxXiDDMBU15xRQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWF-0Y;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E68545EC24C;
	Sun, 15 Nov 2026 09:57:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/9] pull-request: can 2026-11-15
Date: Sun, 15 Nov 2026 10:54:51 +0100
Message-ID: <20261115095746.709371-1-mkl@pengutronix.de>
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

this is a pull request of 9 patches for net/main.

this first 3 patches are by Zhu Ling and fix problems with the CAN
netlink handling.

A patch by my fixes a kernel memory information leak over USB in the
gs_usb driver.

The last 5 patches are by Oliver Hartkopp and avoid RTNL stalls in
CAN_RAW, CAN_ISOTP and CAN_BCM protocols.

regards,
Marc

---

  tcp: fix NULL pointer dereference when restarting a Fast Open listener (2026-11-13 16:46:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.4-20261115

for you to fetch changes up to 48bcad36a131fa67a29a5ac430aceedf2d6f3d0f:

  Merge patch series "can: avoid RTNL stalls in CAN_RAW, CAN_ISOTP and CAN_BCM" (2026-11-15 10:46:59 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.4-20261115

----------------------------------------------------------------
Marc Kleine-Budde (2):
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
      Merge patch series "can: avoid RTNL stalls in CAN_RAW, CAN_ISOTP and CAN_BCM"

Oliver Hartkopp (5):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()

Zhu Ling (3):
      can: netlink: fix static FD-NON-ISO mode validation
      can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
      can: netlink: fix CAN XL PWM attribute sizing

 drivers/net/can/dev/netlink.c |  18 ++++---
 drivers/net/can/usb/gs_usb.c  |   2 +-
 net/can/bcm.c                 | 114 ++++++++++++++++++++++++++++++------------
 net/can/isotp.c               |  28 ++++++-----
 net/can/raw.c                 |  41 ++++++++-------
 5 files changed, 130 insertions(+), 73 deletions(-)
