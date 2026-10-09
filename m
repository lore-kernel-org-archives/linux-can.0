Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E7344F557;
	Fri,  9 Oct 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553416; cv=pass; b=DSPLEIInh1S/akltbWJfr1kmaaehVlCSSJ+mw/RK+AvUAguFhTOLhcWv6eKeTs9iHVi2sgEKneivYKl4IgIIVvJlyZIqh9kkfhNO1JZ7AiooCHfm8yAHdvxS13xj5M7yW/H4F38ppQuztEIJvAXkKYBE56/JqwWwGWgm1a0JIYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553416; c=relaxed/simple;
	bh=C3llQs9e6hQh3PlU5bf0kC+TmnayG5R/K0ZiaX4DmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWlmMgAun9pbyXGHADNvvObVEdvHqaNeq9I2zcUzY2E0sI2nnRlmLXDGy0G1wUHchhjwjXFOPDYTGNWS4kh80N5cuQ5uhquuMaQj+LvZ0g0w8PCUDPpq8OxFeHJdAIT6o/mVbJocuZ8W1rGzChLw6TDCRcaacos4wLoJffH3ulM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=REJnXsV9; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="REJnXsV9"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 71B35200926;
	Fri, 09 Oct 2026 15:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DLgWnRMiuhepfy3mYVM5rMjO3GgNwPrgv2X67GQc110=;
	b=REJnXsV9DTM4H39rqKD6wfC7R6f82U2Z0gNzgF0WrwMiIkuPDN1Va2eRrkNQ4zNqutLDm4
	yahgxgxptOHGC8Yen7dtVNla5bCY03CmQ5WGini3BqECxQQaboupgVIRxCZI0386c/5fH7
	wlcsklIDQsgMx0rcfy3daWLWAiMp/NGORbC7qQhR5q5h+Uv6o8sSAvEVv3KP0kDUrbA75R
	5ucdiKKCWfmN6DiSVpZktzLLNM8jLPRyLJPbhfOUTqMHszyWs9S6TstoU7QKi5G8u7ZTD8
	+rVhF5pdo8kklpHQD88m3OeuXJ89VcjD/j0mhw2bjarInJ468yHsS3EXCumVFQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553411; a=rsa-sha256;
	cv=none;
	b=Jrdesj4XKEnrWLm3lDPHzVuBTbPHPN39ztUI20RvrU5lgX370hy8eLii8Smw/cg5pmZELp
	DokiMmQDiAanxTSugqCVRuwKwojviE5XI+wxRUBchsDWCIVRK8AEPs0A1a1sGIdibl4Aio
	eDi3O6ZumMJNlPEY7anM6Y+avi3GL68l99CMqG74zgVrgNnxI52NKS5GJCiWes8Mo3my/U
	X6od/gyBiDh1365vfqRRNNW8v0qxXBmhS9mSNP2uzcpsES2T+5UI29aqoTrcXVrQw/APXS
	MWl4CMTIe0AlVSsska6MiYtBCpelnYqcdLOWoqab+9Wq311ZBt+rdoWaU6pUFA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DLgWnRMiuhepfy3mYVM5rMjO3GgNwPrgv2X67GQc110=;
	b=Mttrh6ehDKAjTqwOVctcPAbzYU/hwFtj4zJrFBtDlaArSux9KosWxPiRsQLqQ6yi6YxRVl
	mfvHxk4lr1Yad9z3oBGKKK86EFmqZsgvUDVx7jaeKd9L8Of1BWqUa/lsgcvA8uyXpSz6nw
	RQQpxN2gy0DnF6FdtwQbIQ4AMfD643tlANBMDbJJ/UoQMTzYiyC70QKIr0fu8HyEZH1AXD
	XHSfYeVx64VDy/EE7pdlnHX68QQEc7e6vETMgGix33Sp5tdPPekPPqOJsF4oN7h+exYRB5
	gHI0NXlUwDpPSO9UGQ40XvMHo1EXgUFt57mQnbfK2QJauEWcvPlE3ItGv8Tv+g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsl-0053RV-19;
	Fri, 09 Oct 2026 15:43:31 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EFB525BD89B;
	Fri, 09 Oct 2026 13:43:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
Date: Fri,  9 Oct 2026 15:27:32 +0200
Message-ID: <20261009134323.64064-1-mkl@pengutronix.de>
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

Triet Hoang's patch converts several drivers to
DEFINE_SIMPLE_DEV_PM_OPS().

The next 2 patches target the cc770 driver and are by Chaosheng Qu.
They fix error propagation in cc770_platform_probe() and fix a clock
divider check.

A patch by me for the esd driver fixes a potential use-after-free
originated in the acc_start_xmit() function.

Wentao Liang's patch for the flexcan driver fixes a OF node reference
leak in flexcan_setup_stop_mode_gpr().

Ji-Ze Hong contributes a patch for the f81604 driver to fix
use-after-free on disconnect.

A patch by Runyu Xiao fixes a potential deadlock in the error path of
the hi311x CAN driver.

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

The following changes since commit d8674294aefef02266c4d47ad10131f1bffbe534:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-08 22:21:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.4-20261009

for you to fetch changes up to ec2634225bf22a34a79e6557fd34cdf1282658c7:

  can: xilinx_can: set CAN FD flags on received frames (2026-10-09 15:24:54 +0200)

----------------------------------------------------------------
linux-can-next-for-7.4-20261009

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

Ji-Ze Hong (Peter Hong) (1):
      can: f81604: f81604_close(): fix use-after-free on disconnect

Jiale Yao (1):
      can: mcp251xfd: mcp251xfd_probe(): reject devices without match data

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Krzysztof Kozlowski (1):
      dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

Marc Kleine-Budde (5):
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"
      Merge patch series "can: rcar_canfd: Add support for Renesas RZ/G3S"
      Merge patch series "Add support for Renesas RZ/G3L CANFD"
      Merge patch series "dt-bindings: net: can: grcan: convert to DT schema"
      can: esd: acc_start_xmit(): do not touch skb after can_put_echo_skb()

Maximilian Zimmermann (1):
      can: xilinx_can: set CAN FD flags on received frames

Oliver Hartkopp (3):
      can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
      can: proc: remove pointers from CAN specific proc output
      can: remove Softing CANcard driver

Quchaosheng (3):
      dt-bindings: net: can: convert grcan to DT schema
      can: grcan: update the binding file reference in the driver comment
      can: cc770: fix the clock divider check on the platform bus

Runyu Xiao (2):
      can: proc: reset pkg_stats atomics individually
      can: hi311x: drop hi3110_lock before free_irq() on open failure

Sang-Heon Jeon (1):
      can: raw: remove redundant NULL check before netdev_hold()

Tetsuo Handa (1):
      can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all()

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
 Documentation/networking/can.rst                   |  14 +-
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
 drivers/net/can/spi/hi311x.c                       |  11 +-
 drivers/net/can/spi/mcp251x.c                      |   8 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   7 +-
 drivers/net/can/sun4i_can.c                        |   8 +-
 drivers/net/can/usb/ems_usb.c                      |   2 +-
 drivers/net/can/usb/f81604.c                       |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |   2 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  19 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  | 165 +++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  17 -
 drivers/net/can/usb/ucan.c                         |   2 +-
 drivers/net/can/xilinx_can.c                       |   6 +
 include/linux/can/core.h                           |   2 +-
 include/linux/can/dev.h                            |   2 +-
 include/linux/can/skb.h                            |   4 +-
 net/can/af_can.c                                   |  21 +-
 net/can/af_can.h                                   |   2 +-
 net/can/bcm.c                                      |  23 +-
 net/can/gw.c                                       |   9 +-
 net/can/isotp.c                                    |  17 +-
 net/can/j1939/bus.c                                |  30 +
 net/can/j1939/main.c                               |   2 +-
 net/can/proc.c                                     |  43 +-
 net/can/raw.c                                      |  11 +-
 49 files changed, 520 insertions(+), 2374 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt
 delete mode 100644 drivers/net/can/softing/Kconfig
 delete mode 100644 drivers/net/can/softing/Makefile
 delete mode 100644 drivers/net/can/softing/softing.h
 delete mode 100644 drivers/net/can/softing/softing_cs.c
 delete mode 100644 drivers/net/can/softing/softing_fw.c
 delete mode 100644 drivers/net/can/softing/softing_main.c
 delete mode 100644 drivers/net/can/softing/softing_platform.h
