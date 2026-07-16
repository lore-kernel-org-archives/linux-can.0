Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19E3C0A05;
	Thu, 16 Jul 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217399; cv=none; b=ij8vVKJDxERVug31QaDJCK+COTfRKvDDe0X4LbrEmi8IYg7AHmsLUzHmErrF3rWjxjIUnMNjXiKztDBXQXwBEDdkuPk9MKOpxhlQhsxly1FWA492UauZ+CiTFtVmrjN+IsZrMaFNNi1uPhJYhi4LRJmEIBWr5hJYySp5uQ9RLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217399; c=relaxed/simple;
	bh=jiS+23Y4f/meUKG9zk19V1MjnwZJvvOKu3/wb9oulRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWyzXJgvbM2TeHQ2jESfnhKP888+OsO9X0wHtIXJZgsMuww9h5zzoac2qiEhufLVr5vDrje/rr4ZZGBddP/E7ZVzjlx/Nq8REIlN1vsFRz6oQtUJ04o94Kjh5snrxfy2Tuv53cjsv/6RLey44k/m8FtTCX4YctmABC06Kg5iHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0A33E20227D;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORj-0027oX-2S;
	Thu, 16 Jul 2026 17:56:23 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 31A7056C3D0;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/19] pull-request: can 2026-07-16
Date: Thu, 16 Jul 2026 17:47:25 +0200
Message-ID: <20260716155528.809908-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 19 patches for net/main.

The first patch is by Alexander Hölzl and fixes the Kconfig
description of the vxcan driver.

Next patch by Fan Wu fixes the tear down order in the esd_usb driver.

Followed by a patch by Oliver Hartkopp that adds missing locking for
the raw flags in the CAN_RAW protocol.

Shuhao Fu's patch for the j1939 protocol fix lockless
local-destination check.

Stéphane Grosjean updates their email address.

The next 11 patches all target the CAM Broadcast Manager protocol. One
contributed by Lee Jones the remaining ones by Oliver Hartkopp. They
fix several concurrency and locking issues found by various bots.

The last 3 patches are also by Oliver Hartkopp fixing concurrency and
locking issues found by various bots in the CAN ISO Transport
Protocol.

regards,
Marc

---

The following changes since commit 3f1f755366687d051174739fb99f7d560202f60b:

  net: openvswitch: reject oversized nested action attrs (2026-07-11 13:09:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.2-20260716

for you to fetch changes up to 6fd9e37916b9537143a295f854fdf5e52c4c5bc1:

  Merge patch series "net: can: isotp-fixes" (2026-07-16 10:12:22 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.2-20260716

----------------------------------------------------------------
Alexander Hölzl (1):
      can: vxcan: Kconfig: fix description stating no local echo provided

Fan Wu (1):
      can: esd_usb: kill anchored URBs before freeing netdevs

Lee Jones (1):
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Marc Kleine-Budde (2):
      Merge patch series "can: bcm: collected fixes"
      Merge patch series "net: can: isotp-fixes"

Oliver Hartkopp (14):
      can: raw: add locking for raw flags bitfield
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      can: bcm: track a single source interface for ANYDEV timeout/throttle ops
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: serialize TX state transitions under so->rx_lock

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Stéphane Grosjean (1):
      can: peak: Modification of references to email accounts being deleted

 .mailmap                                      |   4 +-
 drivers/net/can/Kconfig                       |   7 +-
 drivers/net/can/peak_canfd/peak_canfd.c       |   2 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h  |   2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |   4 +-
 drivers/net/can/sja1000/peak_pci.c            |   4 +-
 drivers/net/can/sja1000/peak_pcmcia.c         |   4 +-
 drivers/net/can/usb/esd_usb.c                 |   5 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c       |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |   4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   |   2 +-
 include/linux/can/dev/peak_canfd.h            |   2 +-
 net/can/bcm.c                                 | 654 +++++++++++++++++++-------
 net/can/isotp.c                               | 298 +++++++++---
 net/can/j1939/transport.c                     |  18 +-
 net/can/raw.c                                 |  66 ++-
 19 files changed, 792 insertions(+), 292 deletions(-)
