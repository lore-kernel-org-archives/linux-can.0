Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23B8003D;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029224; cv=pass; b=GL+vYnFlHk3uG4V3lJZWi0J1OPfdMEtkRmTlNCNTRqwCCYnxiEyMaiSpZIWoFgZNUjP4yxH5674SYyW+GINGOzt1NGPvlrWU8wZ9nZ3R+Eo9Q6eLJ4NZSoWY+cFCepJGdzj0WTNs+2dR1X12cmdppouXbrLC9eEq0wPhYGxYvUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029224; c=relaxed/simple;
	bh=eYbiKzii2UEmgoPK/snzth7gjYZ3NAHIzwWvgsq3NYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpIIqLLqXeEG3Sl83IkmGN2JsGkQlM/GJGeJqe23t/Kff44f9LC9+LclBO+nvq6B5kmLVGv1abwEU0cXUgiLzX4fSdXR9G1vG9+NqP31a27+I1MtTDQHQDSA/yedBUlWjK5rqjeA5EwFUTfmscjuLfObZ5nSVSpV3+sONMO8SD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=C3jfiLo1; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="C3jfiLo1"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 92805201547;
	Thu, 15 Oct 2026 03:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H9DKqZzwkzsNOMw6qSr8UuleP/flSdVUCZJ9ilDbUgk=;
	b=C3jfiLo1COutbPBS6p8QI0DL3PS8AzHxMgfUPQrRJozeRHdJvIKdNttsVde+gzo7DXdluO
	pyHvYRHOUR8NubvRXfRaO+MnJw2GVEp2n3x15UX97vXIfylArUXQUheELIwX9NvHI1tktK
	EtLWoBrmtVwFyOt88MFAJ8jb8XPonKCWtoD0ynEW8Ym0nGN39Ql9o03JQMvogmD/sJm3XG
	Gg+pX09Xk1eMGdf/YhAHud/J8kAkNeJZFjIBqOLa/80NUeOUQjkRoLepn9gNh50veHPWs4
	mq1tQSUpjfES/nanex47eVEd/6efXU4V1+LHC44ORKToRnHHijGZ6Ix4qJgJWw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029219; a=rsa-sha256;
	cv=none;
	b=gTg3qdnCy0R4J/NuffdPcqfjarV1ccg2gpaAxEsxY1OCWA9gw4AAimp/pZ03N5rJ7mZBRm
	oWZ7BneRg/Zt9ws9uTDUQUsxckGfw29oZU6OkLYf7Yy4igZ8VhBEeKGLO8KAYQL1feX35M
	7MAIvUgKHPBTxMilZYEcxtwWufbqfoOvhxHNh7k2AxSGUFtt5k7Nxnm4IGc04kiqmkkM2O
	66xqcIkkWf+qU3/r7HMRHVOHBh0rDQ6bGGan/cf6JulfvJ8oaxAX1/svW9N9Inws/aIXBn
	TXXUn0molEmE/yVUF8ACEMdOTuFxWcY9PLwr3BOeWG81upol3saTBm09LyKG2A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H9DKqZzwkzsNOMw6qSr8UuleP/flSdVUCZJ9ilDbUgk=;
	b=UyeF8IlXCs+gB8teT5yGEYLOP9tJb0k1sHpQS9o/DTnCWL0GrIwYrE7hon7VKpgpy4WsFa
	WKXUBJvfVIjt+lYm0bwkX6yeBPxUZUO2vd0o/AdMSm9h5gtLBtaTNwlqJPSLje1+r6IfEE
	0VNYg0uQOqWOiFrfAC/WYh5SEN5U0qtaltl31KX6hAmeFI3YYFoyirL/27TkDfq1FD6f3Y
	8BeuUwfkY+6Zywx8LzyUhWy0fLNtkkOCdoDKhxsJbiNEB9OY/xRfb1udcGFqZl9l5IYf/k
	pj+AxIeRtypZE8cnbj9SBCXmhxphJJFpHQ5UO20QLYACs6iaHa5csqj1hCY/Bg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf5-005wph-1b;
	Thu, 15 Oct 2026 03:53:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 392185C4773;
	Thu, 15 Oct 2026 01:53:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/37] pull-request: can-next 2026-10-15
Date: Thu, 15 Oct 2026 03:39:58 +0200
Message-ID: <20261015015336.816543-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 37 patches for net-next/main.

The first patch is by Vincent Mailhol and drops CAN-XL frames on non
CAN-XL devices.

A patch by Sang-Heon Jeon removes a redundant NULL check before
netdev_hold() in the CAN RAW protocol.

Oliver Hartkopp's patch converts the unreliable ARPHRD_CAN type check
to the robust can_get_ml_priv().

A patch by Runyu Xiao for CAN proc resets the pkg_stats using atomics
individually. Oliver Hartkopp also contributes a patch for the CAN
proc to remove kernel pointers from the output.

Tetsuo Handa's patch cancels pending address claim timers in
j1939_ecu_unmap_all().

A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
for the correct CAN CC/FD frames.

Oliver Hartkopp series targets the CAN isotp, bcm and raw protocols
and fixes a use-after-free in the in isotp and bcm and converts the
raw protocol to the same locking scheme.

The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
any context in several CAN helper functions.

Claudiu Beznea contributes 5 patches for the rcar_canfd driver to add
support for Renesas RZ/G3S.

Krzysztof Kozlowski's patch updates the renesas,rcar-canfd DT bindings
to restrict the resets in top-level.

Biju Das's series of 3 patches add support for Renesas RZ/G3L CANFD to
the rcar_canfd driver.

Quchaosheng contributes 2 patches to convert the gr_can DR bindings to
DT schema.

Oliver Hartkopp' patch removes the Softing CANcard driver.

Triet Hoang's patch converts several drivers to
DEFINE_SIMPLE_DEV_PM_OPS().

The next 2 patches target the cc770 driver and are by Chaosheng Qu.
They fix error propagation in cc770_platform_probe() and fix a clock
divider check.

Fan Wu's patch for the ems_usb driver properly shuts down the
interrupt URB.

A patch by me for the esd driver fixes a potential use-after-free
originated in the acc_start_xmit() function.

Wentao Liang's patch for the flexcan driver fixes a OF node reference
leak in flexcan_setup_stop_mode_gpr().

Anton Olsson's patch for the kvaser_usb driver refactors the endpoint
lookup, while Cen Zhang's patch validates the command format before
parsing in the hydra receive path.

A patch by Fan Wu for the kvaser_pciefd driver fixes a use-after-free
in bec poll timer.

Jiale Yao's patch for the mcp251xfd driver rejects devices without
match data.

The next patch by Wentao Liang fixes a clk leak in the error path of
the sun4ican_probe()'s function.

Hemanth Selam's patch for the ucan driver fixes a repeated word 'is'
in a comment.

Maximilian Zimmermann's patch for the xilinx CAN driver adds the
setting the ESI and BSR flags in the receive path if they are active.

regards,
Marc

---

The following changes since commit d8674294aefef02266c4d47ad10131f1bffbe534:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-08 22:21:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.4-20261015

for you to fetch changes up to 8348b75aa230036a14d805eec574aeb0e1b95f86:

  can: xilinx_can: set CAN FD flags on received frames (2026-10-15 03:36:49 +0200)

----------------------------------------------------------------
linux-can-next-for-7.4-20261015

----------------------------------------------------------------
Anton Olsson (1):
      can: kvaser_usb: refactor endpoint lookup

Biju Das (3):
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
      can: rcar_canfd: Derive max_channels from the device tree
      can: rcar_canfd: Add support for Renesas RZ/G3L

Cen Zhang (Microsoft Security FORGE Labs) (1):
      can: kvaser_usb: validate command format before parsing in hydra receive path

Chaosheng Qu (1):
      can: cc770: don't discard the IRQ lookup error in probe

Claudiu Beznea (5):
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
      can: rcar_canfd: Fix typos in macro names
      can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
      can: rcar_canfd: Do not set registers selecting the CAN mode
      can: rcar_canfd: Add support for Renesas RZ/G3S

Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Fan Wu (2):
      can: ems_usb: use usb_kill_urb() to stop the intr URB
      can: kvaser_pciefd: fix use-after-free in bec poll timer

Hemanth Selam (1):
      can: ucan: fix repeated word 'is' in comment

Jiale Yao (1):
      can: mcp251xfd: mcp251xfd_probe(): reject devices without match data

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Krzysztof Kozlowski (1):
      dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

Marc Kleine-Budde (6):
      Merge patch series "can: take rtnl_lock() before leaving the notifier list"
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"
      Merge patch series "can: rcar_canfd: Add support for Renesas RZ/G3S"
      Merge patch series "Add support for Renesas RZ/G3L CANFD"
      Merge patch series "dt-bindings: net: can: grcan: convert to DT schema"
      can: esd: acc_start_xmit(): avoid use-after-free of skb after can_put_echo_skb()

Maximilian Zimmermann (1):
      can: xilinx_can: set CAN FD flags on received frames

Oliver Hartkopp (6):
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: proc: remove pointers from CAN specific proc output
      can: isotp: fix filter removal race between release and netns change
      can: bcm: fix filter removal race between release and netns change
      can: raw: take rtnl_lock() before leaving the notifier list
      can: remove Softing CANcard driver

Quchaosheng (3):
      dt-bindings: net: can: convert grcan to DT schema
      can: grcan: update the binding file reference in the driver comment
      can: cc770: fix the clock divider check on the platform bus

Runyu Xiao (1):
      can: proc: reset pkg_stats atomics individually

Sang-Heon Jeon (1):
      can: raw: remove redundant NULL check before netdev_hold()

Triet Hoang (1):
      can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Wentao Liang (2):
      can: flexcan: flexcan_setup_stop_mode_gpr: fix OF node reference leak
      can: sun4i_can: sun4ican_probe(): fix clk leak

 .../bindings/net/can/aeroflexgaisler,grcan.yaml    |  65 ++
 .../devicetree/bindings/net/can/grcan.txt          |  28 -
 .../bindings/net/can/renesas,rcar-canfd.yaml       |  50 +-
 Documentation/networking/can.rst                   |  12 +-
 drivers/net/can/Kconfig                            |   1 -
 drivers/net/can/Makefile                           |   1 -
 drivers/net/can/bxcan.c                            |   8 +-
 drivers/net/can/cc770/cc770_platform.c             |   9 +-
 drivers/net/can/ctucanfd/ctucanfd.h                |   4 +-
 drivers/net/can/ctucanfd/ctucanfd_pci.c            |   4 +-
 drivers/net/can/ctucanfd/ctucanfd_platform.c       |   4 +-
 drivers/net/can/dev/skb.c                          |  16 +-
 drivers/net/can/esd/esdacc.c                       |  12 +-
 drivers/net/can/flexcan/flexcan-core.c             |   1 +
 drivers/net/can/grcan.c                            |   4 +-
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |   3 +-
 drivers/net/can/m_can/m_can_pci.c                  |   8 +-
 drivers/net/can/rcar/rcar_canfd.c                  | 103 ++-
 drivers/net/can/softing/Kconfig                    |  31 -
 drivers/net/can/softing/Makefile                   |   5 -
 drivers/net/can/softing/softing.h                  | 168 ----
 drivers/net/can/softing/softing_cs.c               | 335 --------
 drivers/net/can/softing/softing_fw.c               | 700 -----------------
 drivers/net/can/softing/softing_main.c             | 864 ---------------------
 drivers/net/can/softing/softing_platform.h         |  41 -
 drivers/net/can/spi/hi311x.c                       |   8 +-
 drivers/net/can/spi/mcp251x.c                      |   8 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   7 +-
 drivers/net/can/sun4i_can.c                        |  11 +-
 drivers/net/can/usb/ems_usb.c                      |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |   2 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  19 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  | 166 +++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  17 -
 drivers/net/can/usb/ucan.c                         |   2 +-
 drivers/net/can/xilinx_can.c                       |   6 +
 include/linux/can/core.h                           |   2 +-
 include/linux/can/dev.h                            |   2 +-
 include/linux/can/skb.h                            |   4 +-
 net/can/af_can.c                                   |  21 +-
 net/can/af_can.h                                   |   2 +-
 net/can/bcm.c                                      |  56 +-
 net/can/gw.c                                       |   9 +-
 net/can/isotp.c                                    |  34 +-
 net/can/j1939/main.c                               |   2 +-
 net/can/proc.c                                     |  49 +-
 net/can/raw.c                                      |  24 +-
 47 files changed, 535 insertions(+), 2395 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt
 delete mode 100644 drivers/net/can/softing/Kconfig
 delete mode 100644 drivers/net/can/softing/Makefile
 delete mode 100644 drivers/net/can/softing/softing.h
 delete mode 100644 drivers/net/can/softing/softing_cs.c
 delete mode 100644 drivers/net/can/softing/softing_fw.c
 delete mode 100644 drivers/net/can/softing/softing_main.c
 delete mode 100644 drivers/net/can/softing/softing_platform.h
