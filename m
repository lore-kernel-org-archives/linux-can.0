From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/4] can: c_can: Add suspend/resume and pinctrl support
Date: Mon, 3 Sep 2012 17:22:15 +0530
Message-ID: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48985 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756374Ab2ICLxK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 3 Sep 2012 07:53:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>

Adds suspend/resume functionality of d_can driver along with d_can
raminit support which is required to initialize RAM while data
transmission.

This patch series also adds pinctrl support to c_can driver. These
patches were tested on AM335x-EVM.

This patch-series is based ontop of runtimePM patch submitted
earlier - https://patchwork.kernel.org/patch/1348081/

AnilKumar Ch (4):
  can: c_can: Adopt pinctrl support
  can: c_can: Add d_can raminit support
  ARM: AM33XX: board-generic: Add of_dev_auxdata to pass d_can raminit
  can: c_can: Add d_can suspend resume support

 arch/arm/mach-omap2/board-generic.c    |   40 +++++++++++++-
 arch/arm/mach-omap2/control.h          |    4 ++
 drivers/net/can/c_can/c_can.c          |   91 ++++++++++++++++++++++++++++++++
 drivers/net/can/c_can/c_can.h          |    7 +++
 drivers/net/can/c_can/c_can_platform.c |   87 ++++++++++++++++++++++++++++--
 include/linux/can/platform/c_can.h     |   36 +++++++++++++
 6 files changed, 261 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/can/platform/c_can.h

-- 
1.7.9.5

