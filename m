Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA284FE2CE;
	Mon, 28 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624004; cv=pass; b=BNzpiSDZAL3VlE3ENcELOoprmgP1AzHyUZbItVJad0B5BBlsZgS7dozRYii1LeDOel4KN+4UxR/Ag5UJLzDCyyUb3g3Auwy1a8CobqGn2YlTPqoyPyIvP2rd7m9M4VKgTdigO+kviHVnUjBLX4v0cH99c5HMvdtFh8N2LB0I1U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624004; c=relaxed/simple;
	bh=hIrSrfsaxTtlqaNUhqCMl7SV+G9kcfp5MRSU94Q+MJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZaE9C2fikEGxRpB6a2B8H6nDWBOiZI5JkMcjEIE/8UccrSoys/oLvxkK/zwSQkA/riNePyUrYGeyhqHeI2jh15EZYRgT6Gu5XcHzGErH2QCrKKJD0QsDZv2U56rRNSh5c1Pr/eExYza6TlFelGm7iF0GBLJe3Je48SPdutc5KvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Vs0rZffd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Vs0rZffd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3FF9C2004BB;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CqnGz/+EPVkF8ulugjTGKJflKkfq8fTuuWwljxkj7Hc=;
	b=Vs0rZffdUJfr0mQn0BdgK/zyRjrwNc+p/iq4wOCyX5P51h86hzbtaXJ3RJNrY2KrZKMBgU
	X9ZEboGqMxadrL9+EkZp88/kbnNnqE1a5vx9iHTcQANmycaY6u9o2bINxzJM0FWqboRYqA
	x7jC3BLIbbGd34jcRrBwebsyTf74owrG04GVhQWCBxFSbCN8Dfl1vUDClKA93XvNVseHA4
	XCAh2Q/OOep+I4xwdbUeOTxuB9mRenLlWCT7uTVuvLNonCHZt13tgUotj4l84yiUUj8rm/
	gr8lsr3VcB1WHiSzt+yxrUlCnk6SZ8ovmBtg3kWcaeBSZbSnjwkYyobSr0D9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CqnGz/+EPVkF8ulugjTGKJflKkfq8fTuuWwljxkj7Hc=;
	b=ACjrn4t8dcAUu/dDlDqRh49PhGQuSyaQ0EsVIxMff5HUwzQYy3BX2sMM+2VTHTBfXUuOSI
	si+SK9KIJx9FszVAm8lsSx4iTBULCnd78We8KYJj8aY4gTddG7u676oH61hXHj11xxn03f
	tATp1bddeYE+yUz+QSXIYOXUk/UPN+CMxWlNa+mbrTypi2JlF5ymEp94L+xW62hr5NeBTN
	Sc/9BVCBrukz5z8fp1T7rA/BGOmS92CKrDQrA8V3YVE6BVOlfUbXbSjgTq9OgC+XW+qhq9
	LqI/Me8zgsD5Wxfkc+81N7LD9ehwf7Hbg/WVvtZLFl5P4H9hlfjucTJ2wsDo0Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=bRMci+F80NGBH21jYynI09UM7ZtOaIxH3CjTwF1gHD7uu+aTsWbhjlVCfClcxaMhugW81I
	DyVzFyF7XgiM6L9kAwk851yL9kysboSaq5ltsPoBkVj9DomI+WUpgENaGmIl+/twTp2L9X
	DyydbUy/y3wh18L9wWrGcSUXuMSUCdUcXTyVpt1MRBej65a9oNlwuYF24P1ScR3w2SiiWM
	wxZLPbmGPuX1Wdk1oNZTdU4ADg8zs5vtQsrxKtA+A6lJh9TXFci6EXIjJf7Wc+Qc4eqj33
	3j+5LD86JpjYSrsi9ePd5gS7Hu35iRbSrnTBQtVPZsBt92WLk6WlYzRLu8PyOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H5p-0V;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA1FB5B1547;
	Mon, 28 Sep 2026 19:33:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/22] pull-request: can 2026-09-28
Date: Mon, 28 Sep 2026 20:45:07 +0200
Message-ID: <20260928193312.553632-1-mkl@pengutronix.de>
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

this is a pull request of 22 patches for net/main.

The first patch is by Vincent Mailhol and drops CAN-XL frames on non
CAN-XL devices.

The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
any context in several CAN helper functions.

A patch by zjamg restores the skb header initialization lost during
the v7.0 release cycle.

Tetsuo Handa's patch fixes a j1939_ecu leak in the CAN J1939 protocol
when re-bind fails.

A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
for the correct CAN CC/FD frames.

Quchaosheng contributes 2 patches for the cc770 driver, to properly
propagate error values in the cc770_platform_probe() function and to
fix the clock divider check on the platform bus in the
cc770_get_platform_data() function.

Fan Wu's patch for the kvaser_pciefd driver fixes a potential
use-after-free.

A patch by Joshua Crofts adds a missing
pm_runtime_dont_use_autosuspend() to the m_can_pci driver.

Markus Schneider-Pargmann's patch for the m_can driver fixes the
deinit() error path in the m_can_class_suspend() function.

The next patch by Wentao Liang fixes a clk leak in the error path of
the sun4ican_probe()'s function.

Maximilian Zimmermann's patch for the xilinx CAN driver adds the
setting the ESI and BSR flags in the receive path if they are active.

Jiale Yao's patch for the mcp251xfd driver rejects devices without
match data.

A patch by Runyu Xiao fixes a potential deadlock in the error path of
the hi311x CAN driver.

Fan Wu's patch for the ems_usb driver properly stops the interrupt
URB when shutting down the device.

Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.

The next 2 patches are for the gs_usb driver. Fan Wu's patch properly
kills the RX URBs before destroying the netdevs. The other patch is by
me and adds workarounds for the HScanT USB to CAN adapter.

Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
driver.

The last patch is by Stefan Günther, target the peak_usb driver and
fixes the CAN-ID when reporting CAN errors.

regards,
Marc

---

The following changes since commit a7bfaba4823e3c165bb2004c74eff7c096672bc7:

  ipv6: fix prefix route expiry in modify_prefix_route() (2026-09-25 17:34:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.3-20260928

for you to fetch changes up to 3a8690cbd943aef99252073d560366f25d1b6b9a:

  can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters (2026-09-28 20:38:34 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.3-20260928

----------------------------------------------------------------
Cen Zhang (Microsoft Security FORGE Labs) (1):
      can: kvaser_usb: validate command format before parsing in hydra receive path

Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Fan Wu (3):
      can: kvaser_pciefd: fix use-after-free in bec poll timer
      can: ems_usb: use usb_kill_urb() to stop the intr URB
      can: gs_usb: kill RX URBs before destroying the netdevs

Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Jiale Yao (1):
      can: mcp251xfd: mcp251xfd_probe(): reject devices without match data

Joshua Crofts (1):
      can: m_can: pci: add missing pm_runtime_dont_use_autosuspend() call

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Marc Kleine-Budde (2):
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"
      can: gs_usb: add workarounds for HScanT USB to CAN adapter

Markus Schneider-Pargmann (TI) (1):
      can: m_can: m_can_class_suspend(): fix suspend deinit() error path

Maximilian Zimmermann (1):
      can: xilinx_can: set CAN FD flags on received frames

Quchaosheng (2):
      can: cc770: platform_get_irq(): propagate the error
      can: cc770: fix the clock divider check on the platform bus

Runyu Xiao (1):
      can: hi311x: drop hi3110_lock before free_irq() on open failure

Stefan Günther (1):
      can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters

Tetsuo Handa (1):
      can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Wentao Liang (1):
      can: sun4i_can: sun4ican_probe(): fix clk leak

zjamg (1):
      can: dev: init_can_skb(): restore skb header initialization

 drivers/net/can/cc770/cc770_platform.c             |   9 +-
 drivers/net/can/dev/skb.c                          |  20 +--
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |   3 +-
 drivers/net/can/m_can/m_can.c                      |  23 +++-
 drivers/net/can/m_can/m_can_pci.c                  |   1 +
 drivers/net/can/spi/hi311x.c                       |   3 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   7 +-
 drivers/net/can/sun4i_can.c                        |   8 +-
 drivers/net/can/usb/ems_usb.c                      |   2 +-
 drivers/net/can/usb/f81604.c                       |   2 +-
 drivers/net/can/usb/gs_usb.c                       | 129 +++++++++++++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  | 135 +++++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb.c            |   2 +-
 drivers/net/can/xilinx_can.c                       |   6 +
 include/linux/can/dev.h                            |   2 +-
 include/linux/can/skb.h                            |   4 +-
 net/can/isotp.c                                    |   8 ++
 net/can/j1939/socket.c                             |  37 +++---
 18 files changed, 353 insertions(+), 48 deletions(-)
