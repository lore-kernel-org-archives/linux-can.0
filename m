Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94B37D13E
	for <linux-can@vger.kernel.org>; Thu,  7 May 2026 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153008; cv=none; b=oLeO+XGY8VrFECrbiFAPvoJel2DoP5QnV/fbmY2Pt3JNwc5kJ7ofaoox9tckakx+/L9nj+M9CmxJ27mQdLJKagb//B07Ed+3bQE9UTb10iaCuma9CPLeSFE5fkSXuXMecHISm91LhGiSIqaWX0eVcGfWIihiJme80SKWias7Rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153008; c=relaxed/simple;
	bh=mUOYDX69Yo2Cey6LzU6C+AKQLmkzTJl6hjB+pZR5lyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KtR0HEcKc5wSBwKuqZ0/sRHZVpAK6IIafelCmzrX+JZ3kIBUcZ6BcHiaX+fgWux6N63qfFFEdJsszqxURbxHheWTQ+ecLkyDdDlhWwzwg+ZAULOmHROq2DoS9Uvvsc9qH2sUbphGJ/5n/Fht809uFCsmyjIBhOrLHaUlLSz4bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp9-0002vi-Kp; Thu, 07 May 2026 13:23:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp8-000ufc-2Z;
	Thu, 07 May 2026 13:23:23 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3CCB530405;
	Thu, 07 May 2026 11:23:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/6] pull-request: can 2026-05-07
Date: Thu,  7 May 2026 10:22:22 +0200
Message-ID: <20260507112321.439968-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 6 patches for net/main.

The first patch is by Oliver Hartkopp and adds missing locking to the
raw_setsockopt() function in the CAN raw protocol.

A patch by Lee Jones fixes a hrtimer Use-After-Free in the CAN
broadcast manager protocol.

Alexander Hölzl's patch fixes the RX timeout for CTS holds messages in
the CAN J1939 protocol.

Shuhao Fu contributes a patch that adds missing locking to the
local-destination check in the CAN J1939 protocol.

Stéphane Grosjean's patch updates his email address.

The last patch is by Ciprian Marian Costea and consistently
disables/enables the all IRQ lines while writing the IRQ enable
registers.

regards,
Marc

---

The following changes since commit b266bacba796ff5c4dcd2ae2fc08aacf7ab39153:

  net: ethernet: cortina: Drop half-assembled SKB (2026-05-06 18:43:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.1-20260507

for you to fetch changes up to f22a636357d5ff4fd2bb10d8079d851ccb320438:

  can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable() (2026-05-07 10:05:55 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.1-20260507

----------------------------------------------------------------
Alexander Hölzl (1):
      can: j1939: fix wrong RX timeout for CTS hold messages

Ciprian Marian Costea (1):
      can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()

Lee Jones (1):
      can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER

Oliver Hartkopp (1):
      can: raw: add locking for raw flags bitfield

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Stéphane Grosjean (1):
      can: peak: Modification of references to email accounts being deleted

 .mailmap                                      |  4 +-
 drivers/net/can/flexcan/flexcan-core.c        | 14 ++++++
 drivers/net/can/peak_canfd/peak_canfd.c       |  2 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h  |  2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  4 +-
 drivers/net/can/sja1000/peak_pci.c            |  4 +-
 drivers/net/can/sja1000/peak_pcmcia.c         |  4 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   |  2 +-
 include/linux/can/dev/peak_canfd.h            |  2 +-
 net/can/bcm.c                                 |  6 +++
 net/can/j1939/transport.c                     | 20 ++++++--
 net/can/raw.c                                 | 66 ++++++++++++---------------
 17 files changed, 83 insertions(+), 59 deletions(-)
