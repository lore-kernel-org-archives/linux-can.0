Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A0346E58;
	Mon, 17 Aug 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009672; cv=none; b=Tp6NXQfCHgl8JfI12Kcck5BWonlZPyL81kLN0NBQtike0fmavfDE1JXvtRlrGse6INLtkemXamf83ZmI7DhduCWqSWvhegDexqalTNw5/IcLtZ7GB9qF1I9wVYj1B9W0nbjknpX0rAUJ5I6Y/AYEvkLBxyYy7eq0ByNGR60O5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009672; c=relaxed/simple;
	bh=xsmEvP9/CLLtp6AXkRjihEgbulQDLNVYC2OeYiqkSYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq4kDtmJSxhZck7b0vkYT9ywCDAcDn1jFMXz/N5POYHhe3FtGhE7zK7ImoY0NUXtt35IyutM1Q8pNGaPUvtZaG+AJ0vu0pTL3Ijj0sHwYNpkDKbJR/Tk21uZlZnDEWybe+pKurN4XW5nycAX0aCx+RJCe+PSPt3Zv+jI936tAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6779920227E;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220c-0v;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F28A2585153;
	Mon, 17 Aug 2026 23:34:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/11] pull-request: can-next 2026-08-18
Date: Tue, 18 Aug 2026 01:24:27 +0200
Message-ID: <20260817233420.2068204-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,


this is a pull request of 11 patches for net-next/main.

The first patch is by Sean Nyekjaer, targets the tcan4x5x driver and
puts the device into sleep mode before removing the driver.

Pavel Pisa's patch fixes the colors in the documentation of the TX
buffer FSM of CTU CAN FD driver.

2 patches by Cunhao Lu add support for the rockchip 3588 SoC to the
rockchip CAN-FD driver.

Kuniyuki Iwashima contributes per-netns device unregistration for the
vxcan driver.

Eduard Bostina converts the TI HECC DT bindings doc to DT schema.

Harini T contributes 2 patches to the xilinx_can driver to document
phys and update maintainer.

A patch by bui duc phuc converts the m_can driver to use
of_property_present() for wakeup-source.

Fanbo He's patch fixes a typo in the gs_usb driver.

The last patch is by Markus Schneider-Pargmann and removed not needed
driver_data from the m_can PCI driver.

regards,
Marc

---

The following changes since commit e6a5d573d24cd375e09d24f136523cb3cc85c9d3:

  net: dsa: drop explicit NULL comparisons (2026-08-14 13:57:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.3-20260818

for you to fetch changes up to f6a48a7b10be44c470f5ce1037ebaaf343f384f7:

  can: m_can: pci: Remove driver_data (2026-08-17 19:20:38 +0200)

----------------------------------------------------------------
linux-can-next-for-7.3-20260818

----------------------------------------------------------------
Cunhao Lu (2):
      dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
      can: rockchip: add RK3588 CAN support

Eduard Bostina (1):
      dt-bindings: net: can: Convert TI HECC to DT schema

Fanbo He (1):
      drivers: gs_usb: gs_usb_probe(): fix typo in error message

Harini T (2):
      MAINTAINERS: Replace maintainer for Xilinx CAN driver
      dt-bindings: can: xilinx_can: Document phys property

Kuniyuki Iwashima (1):
      can: vxcan: support per-netns device unregistration.

Marc Kleine-Budde (2):
      Merge patch series "dt-bindings: can: rockchip: add rk3588 CAN-FD compatible"
      Merge patch series "dt-bindings: can: xilinx_can: Document phys and update maintainer"

Markus Schneider-Pargmann (The Capable Hub) (1):
      can: m_can: pci: Remove driver_data

Pavel Pisa (1):
      docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD

Sean Nyekjaer (1):
      can: tcan4x5x: put tcan into sleep when removing driver

bui duc phuc (1):
      can: m_can: Use of_property_present() for wakeup-source

 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  4 +-
 .../bindings/net/can/ti,am3517-hecc.yaml           | 64 ++++++++++++++++++++++
 .../devicetree/bindings/net/can/ti_hecc.txt        | 32 -----------
 .../devicetree/bindings/net/can/xilinx,can.yaml    |  5 +-
 .../device_drivers/can/ctu/fsm_txt_buffer_user.svg |  4 +-
 MAINTAINERS                                        |  2 +-
 drivers/net/can/m_can/m_can.c                      |  2 +-
 drivers/net/can/m_can/m_can_pci.c                  |  6 +-
 drivers/net/can/m_can/tcan4x5x-core.c              | 31 +++++++++--
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 17 ++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  5 +-
 drivers/net/can/rockchip/rockchip_canfd.h          | 14 ++++-
 drivers/net/can/usb/gs_usb.c                       |  2 +-
 drivers/net/can/vxcan.c                            | 26 +++++----
 14 files changed, 155 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

