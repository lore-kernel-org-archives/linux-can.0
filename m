Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795126295;
	b=PDvxxzRenf12NCim8jMto+WDnbzpieCGBc84uUMkyrxjFSfzsUXC1dlqBWIHWzEx9f3c
	 DAtF49HIzoxF/yiWPdrBxMVNsHqgolTaRxMR5VUJ5qX8x7f3OBqoVd68IX3VKr6ZRS7sV
	 aJyqsE0zpVRB8nrBV/zuBN7KPhQJ4KDaj9w2aFDT57WGBHK6LN7U+9w+8RpGM52IVtsOs
	 O6INREdJUiTjRcU/kKdAsM+V6XcIaqUirI7l5BGXuenk5KLjHYhFTxMrieA2gZiC2MgdH
	 /TsGtu2IwOtUXAFvXgCUm+80blRIlcN1hCGfIl+62ns7KzjhKFycQCmYXtkHOlbnLKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DmEVD8INAT6i9vwisrBLXVE3Fd+dY6OwHmJtgFvATZ8=;
	b=2En3PRmD03rxgSBncjq3AHVoXEGViP/wfH7xuWB6v6tOYr+c78VbGngSnIOMrqRtq9MX
	 okAjt7bIT/aI7YD0zaG3fyFEi63exnDuHYr5HZwtwpHLCq1wymadBvA5UjWt30pGTACKU
	 dv9TLI0OIPH0tC11n0dyTWGeMEELUgliDpVVVNkyg4mWCuPftbkTtIgm4AdLyKLYJQP0/
	 w8h07dCkZbmFkq0Cy+fdPcBkeyICyGjgTGUJvWgPATqh76fvC5q6hUBBlcKSopwjAnqKT
	 DJ/cRzXhG0/r1Bhya3Xsedbks/S6ewfPA0rodLBz7Vz+Uqr4bk6S+TGl/mjvqG/vjUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MXnKkLWE;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3F606A320;
	Thu, 19 Nov 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C3F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MXnKkLWE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E5931205B30;
	Thu, 19 Nov 2026 23:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmEVD8INAT6i9vwisrBLXVE3Fd+dY6OwHmJtgFvATZ8=;
	b=MXnKkLWEm/xgPCrDx2vFv4oChWglb7cBGs08SLfiKW5zAs2fF+NP4Q/cgcXGGeKneIfP6s
	/dypFJSH4dkcMbu1Dhq/ny0YHylc8YiY7dnnSojoH6Lyek4BA8wgsYZGpaRNO42/nZdpz9
	+I/7g7UL9rYydhLrvWBTBiN9OwCIN+FxcIOKps7tgbLU2LXTbQoFX/4QgJF+AR2pbOes5Q
	BgNCo6vjrGILc//GRrKqPItoaJlcBTw4md3GWBvMrJfLQRNIqEv84//9slfIlfi1WSwzqn
	0IzUlHts+I03ScnXvzwh7PqMe8lpPojbxYPSq2l8csNXm/L9k2FYuqeqK4a9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmEVD8INAT6i9vwisrBLXVE3Fd+dY6OwHmJtgFvATZ8=;
	b=PtfDmLLLNlIxZXwkuozUsvY9ix2RuF2+Dav3CKAn0ut8Xsh5ebRBhn5Udx0tuco8LmVcqi
	WbDd/XGHN5FJEOHc9OdQJo2Pr3jV5RrNxDXUyhvomq2I+e9pcELRc5b+Hbx0GouGdA3QLX
	ckLJ692xAN4CpBv+hV4h3M9R6trrRcJ9JjltcY+xwXxdRmZMjcG6z9UeL/7jlMcsqgGpQ+
	7V0p5B3F/PpGik1u526OCkMAU4AKVX5OclvGGyDHdFZlKPGtD56GtCy4h6D03paB1tNekP
	xb5QYZN/XaphrmmOT87CUObg1NiZVX4eX+uFNLHdZRMb5/NS/j8hqyEDalP/mw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126287; a=rsa-sha256;
	cv=none;
	b=Px8WWG18SHqnnPAQqo1PHYIVlEkwma7FLAx3MrCkbg0bCjU8IuLbUIdc8pbJbGZu8q0vUp
	pTF4QYp63ETxcOAGUlJZCHwfwcvySh1GH8CuLtPHHWOQd9qILyzrA9OLqb9XGqyanfqOdb
	BfmqclzRF0VEEEoCNoZ/SKFt+G3GlUDiEnp4RWnjRjMwjceApm7st6SNY791tiQFSjBDQ8
	SHyudwafXHPJvj/i9edEM/RLS/mjHrc2+CwdihXaZPUwfJKV7nG+2+h/oPmNRg1QdwMVGy
	bvX1PaaeBO/T7g/CErj/cNlD4k0qTqQaOtbPls2cfnqSm44icVDiE0jNLK2luA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z61-11;
	Thu, 19 Nov 2026 23:11:27 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 911105F0993;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/13] pull-request: can-next 2026-11-19
Date: Thu, 19 Nov 2026 22:58:36 +0100
Message-ID: <20261119220936.155728-1-mkl@pengutronix.de>
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
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 13 patches for net-next/main.

Stéphane Grosjean's patch adds him as a maintainer for the PEAK-System
CAN drivers.

A patch by Sang-Heon Jeon removes a redundant NULL check before
netdev_hold() in the CAN RAW protocol.

Magnus Aagaard Sørensen contributes a patch to remove the unused
function safe_candev_priv().

Triet Hoang converts several CAN drivers to DEFINE_SIMPLE_DEV_PM_OPS().

Wentao Liang's patch fixes a clock leak in the suni4_can driver.
(fix clock leak, found by LLM)

5 patches by Chaosheng Qu clean up the error handling for
platform_get_irq() in several CAN drivers.
(fix error handling, found by LLM, but not been seen in real world
 systems)

Oliver Hartkopp's patch removes the obsolete Softing CANcard driver.

A patch by Hemanth Selam removes a repeated word in a comment in the
ucan driver.

The last patch is by Maximilian Zimmermann and sets CAN FD related
flags on received frames in the xilinx_can driver.
(fix a real problem, can be seen in production system)

regards,
Marc

---

The following changes since commit 24630ff92eff08500ec4772728d4b1fa08c28f47:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-11-19 10:02:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.5-20261119

for you to fetch changes up to 1d527d7ecfaf5cdf6cc75f94d3d8e23c0d17b537:

  can: xilinx_can: set CAN FD flags on received frames (2026-11-19 22:52:36 +0100)

----------------------------------------------------------------
linux-can-next-for-7.5-20261119

----------------------------------------------------------------
Chaosheng Qu (5):
      can: cc770: don't discard the IRQ lookup error in probe
      can: sun4i_can: don't discard the IRQ lookup error in probe
      can: at91_can: don't discard the IRQ lookup error in probe
      can: janz-ican3: don't discard the IRQ lookup error in probe
      can: ifi_canfd: don't discard the IRQ lookup error in probe

Hemanth Selam (1):
      can: ucan: fix repeated word 'is' in comment

Magnus Aagaard Sørensen (1):
      can: dev: remove unused safe_candev_priv()

Marc Kleine-Budde (1):
      Merge patch series "can: don't discard the platform_get_irq() error in probe"

Maximilian Zimmermann (1):
      can: xilinx_can: set CAN FD flags on received frames

Oliver Hartkopp (1):
      can: remove Softing CANcard driver

Sang-Heon Jeon (1):
      can: raw: remove redundant NULL check before netdev_hold()

Stéphane Grosjean (1):
      MAINTAINERS: add entry for PEAK-System CAN drivers

Triet Hoang (1):
      can: convert to DEFINE_SIMPLE_DEV_PM_OPS()

Wentao Liang (1):
      can: sun4i_can: sun4ican_probe(): fix clk leak on unbound

 MAINTAINERS                                |  12 +
 drivers/net/can/Kconfig                    |   1 -
 drivers/net/can/Makefile                   |   1 -
 drivers/net/can/at91_can.c                 |   9 +-
 drivers/net/can/bxcan.c                    |   8 +-
 drivers/net/can/cc770/cc770_platform.c     |   7 +-
 drivers/net/can/dev/dev.c                  |  12 -
 drivers/net/can/ifi_canfd/ifi_canfd.c      |   2 +-
 drivers/net/can/janz-ican3.c               |   2 +-
 drivers/net/can/m_can/m_can_pci.c          |   8 +-
 drivers/net/can/softing/Kconfig            |  31 --
 drivers/net/can/softing/Makefile           |   5 -
 drivers/net/can/softing/softing.h          | 168 ------
 drivers/net/can/softing/softing_cs.c       | 335 -----------
 drivers/net/can/softing/softing_fw.c       | 700 -----------------------
 drivers/net/can/softing/softing_main.c     | 864 -----------------------------
 drivers/net/can/softing/softing_platform.h |  41 --
 drivers/net/can/spi/hi311x.c               |   8 +-
 drivers/net/can/spi/mcp251x.c              |   8 +-
 drivers/net/can/sun4i_can.c                |   9 +-
 drivers/net/can/usb/ucan.c                 |   2 +-
 drivers/net/can/xilinx_can.c               |   6 +
 include/linux/can/dev.h                    |   3 -
 net/can/raw.c                              |   3 +-
 24 files changed, 54 insertions(+), 2191 deletions(-)
 delete mode 100644 drivers/net/can/softing/Kconfig
 delete mode 100644 drivers/net/can/softing/Makefile
 delete mode 100644 drivers/net/can/softing/softing.h
 delete mode 100644 drivers/net/can/softing/softing_cs.c
 delete mode 100644 drivers/net/can/softing/softing_fw.c
 delete mode 100644 drivers/net/can/softing/softing_main.c
 delete mode 100644 drivers/net/can/softing/softing_platform.h
