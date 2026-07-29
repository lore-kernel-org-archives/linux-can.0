Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D160446841;
	Wed, 29 Jul 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320975; cv=none; b=Wuwnsy73aeCikLIgvQln4SbcJqWAIfdxi7LklU+hczQhhG3Hs/ApUBR1UsN5TUyZeOwRtu2b00eYaDp6hRWHaM7Ie2q3d1bG0izUvx4p0Dy0eX5uMZbg74bqXP8oUvd/Vg5hnhlk5GId0qB6BKVu1jcP/EDeeP7gY3r8khm/vLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320975; c=relaxed/simple;
	bh=VkYGSiaWqRB3TTJSej6t3DSq5VYnEXiGa3RJH0Ez87M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYPdTvAuO7K29+pc/A/FnWNXUM12vszL9avVIdkHDpygUhdqutkJXilSgUip096s7aLmKaaWTsFAAyjrWq0BnIxyH0s+6XflNk9s4Sx26MN1l77jB5159s4gaftuNmxQlkl7xNW0GB9XrBebeaOQpBj0lYH79gq7xIEgXRpeZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3141B202B59;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XR-001rn9-39;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A1D1D575DBA;
	Wed, 29 Jul 2026 10:28:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/20] pull-request: can 2026-07-29
Date: Wed, 29 Jul 2026 12:12:40 +0200
Message-ID: <20260729102802.505168-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 20 patches for net/main.

The first 2 patches fix problems in the CAN J1939 protocol and are by
Tetsuo Handa and Oleksij Rempel.

The next 2 patches fix problems in the CAN ISOTP protocol and are by
Oliver Hartkopp and Minhong He.

Avi Weiss contributes contributed 4 fixes for the ctucanfd, Pengpeng
Hou's patch adds a missing MODULE_DEVICE_TABLE.

The patches for the peak_usb driver are contributed by James Gao,
Maoyi Xie, Maoyi Xie and add sanity checks for the USB bulk data
parsing and fix a double free.

2 fixes for the kvaser_usb driver are provided by Abdun Nihaal and
Pengpeng Hou, a mem leak is fixed and sanity checks for the USB bulk
data parsing.

Tu Nguyen's patch for the rcar_canfd driver fixes the initializing
flow.

Pengpeng Hou contributes a patch for the softing driver to validate
the firmware record spans.

Lucas Martins Alves's patch for the c_can driver keeps the controller
in init mode until configuration is complete.

A patch by my add missing URB resubmission on skb allocation failure
to the gs_usb driver.

Guangshuo Li's patch for the etas_es58x driver fixes a RX buffer leak.

The last patch is by Pengpeng Hou and adds sanity checks to the USB
bulk data parsing of the ems_usb driver.

regards,
Marc

---

The following changes since commit 3bd438a58e910db5dc369aa25dfed1fc95f1b596:

  octeontx2-af: Block VFs from clobbering special CGX PKIND state (2026-07-28 18:52:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.2-20260729

for you to fetch changes up to 02925f51377f2a42a6724f00549167499c9302e5:

  can: ems_usb: validate CPC message lengths (2026-07-29 12:00:18 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.2-20260729

----------------------------------------------------------------
Abdun Nihaal (1):
      can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()

Avi Weiss (4):
      can: ctucanfd: unmap BAR0 using base address
      can: ctucanfd: mark error-active controller status valid
      can: ctucanfd: handle bus error interrupts
      can: ctucanfd: use self-test mode for PRESUME_ACK

Guangshuo Li (1):
      can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure

James Gao (1):
      can: peak_usb: add bounds check for USB channel index

Lucas Martins Alves (1):
      can: c_can: c_can_chip_config(): keep controller in init mode until bittiming is configured

Maoyi Xie (1):
      can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error

Marc Kleine-Budde (2):
      Merge patch series "can: j1939: resend lost patches for buffer init and netdevice tracking"
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Minhong He (1):
      can: isotp: check register_netdevice_notifier() error in module init

Oleksij Rempel (1):
      can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer

Oliver Hartkopp (1):
      can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Pengpeng Hou (5):
      can: ctucanfd: add missing MODULE_DEVICE_TABLE()
      can: peak_usb: validate uCAN receive record lengths
      can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      can: softing: fw_parse(): validate firmware record spans
      can: ems_usb: validate CPC message lengths

Tetsuo Handa (1):
      can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

 drivers/net/can/c_can/c_can_main.c                |   8 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c          |  14 +-
 drivers/net/can/ctucanfd/ctucanfd_pci.c           |   3 +-
 drivers/net/can/rcar/rcar_canfd.c                 |  32 +--
 drivers/net/can/softing/softing_fw.c              |  46 ++-
 drivers/net/can/usb/ems_usb.c                     |  43 +++
 drivers/net/can/usb/etas_es58x/es58x_core.c       |   1 -
 drivers/net/can/usb/gs_usb.c                      |   4 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |   1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  13 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c      |   1 -
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c        |  40 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c       |  20 +-
 net/can/isotp.c                                   | 334 ++++++++++++++++------
 net/can/j1939/bus.c                               |   2 +
 net/can/j1939/j1939-priv.h                        |   3 +
 net/can/j1939/main.c                              |   8 +-
 net/can/j1939/transport.c                         |   4 +-
 18 files changed, 428 insertions(+), 149 deletions(-)
