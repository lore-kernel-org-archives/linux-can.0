Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72B3F2100;
	Wed, 26 Aug 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746245; cv=none; b=C6RGZRzM9OBfnwNw2YYRenTv3XI1AT1QJibmpFCB5CAtGts+IoMkLnjRy5Ixe2ci4iOdu3J9Qmua115MXrQgxUV2KJkkj/HK0pNzHjvXZLq7sWRnzF9TL8JdtFvGRI7K6pGg3pSL1AITe7w0VoRmH5sECk+d+Y2qvSenXocN4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746245; c=relaxed/simple;
	bh=41kHWhR7Y+N9wyXKz4aMIQwVF7zvLiNemANakb2cYUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1ogMuY1jKMVS4l0Ox32C6mrG3Iyca+CRVpoFMOlE4DwtBC5HHI8xlw259wsKhM2eGEU8rOP325f2IfYGPwFXjJkpzEMGrLuXHRONpDTvKeyjdqfAxCcMeuyXAOWYwYgD+52l3W85mv5qkQkE+Q6yHnnzWQraD9cDsTh86EjDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3498C201BCA;
	Wed, 26 Aug 2026 14:10:38 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSk-003R8o-0M;
	Wed, 26 Aug 2026 14:10:38 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D021358CCF7;
	Wed, 26 Aug 2026 12:10:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/14] pull-request: can 2026-08-26
Date: Wed, 26 Aug 2026 14:02:10 +0200
Message-ID: <20260826121036.2706424-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 14 patches for net-next/main.

The first patch is by Vincent Mailhol to drop CAN-XL frames on non
CAN-XL devices.

Oliver Hartkopp's patch updates the CAN networking core to use a more
robust check to ensure working in CAN devices.

Sureshkumar S cotributes 2 patches to fix corner cases of the the CAN
bittiming calculation.

The next 3 patches are by Cunhao Lu and fix the TX path of the
rockchip_canfd driver.

Another 3 patches by Cunhao Lu make echo skb freeing safe in any IRQ
context in several CAN helper functions.

Fan Wu's for the kvaser_pciefd driver fixes a potential
use-after-free.

Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
driver.

Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.

The last patch is by Runyu Xiao and fixes a potential deadlock in the
error of the hi311x CAN driver.

regards,
Marc

---

The following changes since commit dc4b95b8fee95113587e93ca116356032d271371:

  net/sched: sch_teql: restore skb->dev on the slave failure path (2026-08-25 15:24:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.3-20260826

for you to fetch changes up to 475cb4ea138f4b0e7f43ff79220f4013a6a840b8:

  can: hi311x: drop hi3110_lock before free_irq() on open failure (2026-08-26 13:40:17 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.3-20260826

----------------------------------------------------------------
Cen Zhang (Microsoft) (1):
      can: kvaser_usb: validate command format before parsing in hydra receive path

Cunhao Lu (6):
      can: rockchip_canfd: prevent TX stall on echo skb failure
      can: rockchip_canfd: retry the outstanding TX buffer
      can: rockchip_canfd: serialize TX state and command writes
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Fan Wu (1):
      can: kvaser_pciefd: fix use-after-free in bec poll timer

Ji-Ze Hong (Peter Hong) (1):
      can: usb: f81604: fix struct f81604_int_data size mismatch

Marc Kleine-Budde (3):
      Merge patch series "can: bittiming: fix two defects in the userspace bitrate conversion"
      Merge patch series "can: rockchip_canfd: prevent TX stall on echo skb failure"
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"

Oliver Hartkopp (1):
      can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

Runyu Xiao (1):
      can: hi311x: drop hi3110_lock before free_irq() on open failure

Sureshkumar S (2):
      can: bittiming: fix divide-by-zero in can_calc_bittiming()
      can: bittiming: fix bitrate error calculation on unsigned operands

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

 drivers/net/can/dev/calc_bittiming.c               | 10 ++--
 drivers/net/can/dev/skb.c                          | 14 ++---
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |  3 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |  1 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 31 ++++++++---
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 47 ++++++++++++----
 drivers/net/can/rockchip/rockchip_canfd.h          |  4 +-
 drivers/net/can/spi/hi311x.c                       |  3 ++
 drivers/net/can/usb/f81604.c                       |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  | 62 +++++++++++++++++++---
 include/linux/can/skb.h                            |  4 +-
 net/can/af_can.c                                   | 12 ++---
 net/can/bcm.c                                      |  7 +--
 net/can/gw.c                                       |  7 +--
 net/can/isotp.c                                    |  5 +-
 net/can/raw.c                                      |  4 +-
 16 files changed, 160 insertions(+), 56 deletions(-)
