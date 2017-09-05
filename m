From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 0/4] can: flexcan: fix state transition, suppress irq flooding
Date: Tue, 5 Sep 2017 08:33:46 +0000
Message-ID: <8ecfe5299d314440b9ccbab4acad5dc6@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:49255 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdIEIdu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Sep 2017 04:33:50 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 9253741b7d8bdd4fabe41a8dc2211869589f0f18 Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Tue, 5 Sep 2017 16:09:04 +0800
Subject: [PATCH 0/4] can: flexcan: fix state transition, suppress irq flooding

A state transition regression was found after the rx-offload patches
were introduced. Additionally, when FLEXCAN_QUIRK_BROKEN_ERR_STATE is
enabled, error interrupt flooding may happen. This can cause a
performance hit on low end systems in combination with high bitrates.

Patch 1 fixes the state change regression by calling flexcan_irq_state()
upon any interrupt.

Patch 2 renames the legacy FLEXCAN_QUIRK_BROKEN_ERR_STATE to
FLEXCAN_QUIRK_BROKEN_WERR_STATE. This is the first step to tackle the
error interrupt flooding issue.

Patch 3 introduces FLEXCAN_QUIRK_BROKEN_PERR_STATE and uses the two
[PW]ERR_STATE quirks to limit error interrupt occurrences to the minimum
required to report correct state transitions.

Patch 4 enables FLEXCAN_QUIRK_BROKEN_PERR_STATE on i.MX6 to enable
correct state transitions on this SOC.

All patches were tested on i.MX6 with kernel v4.11. They were also
tested with disabled [TR]WRN_INT and enabled
FLEXCAN_QUIRK_BROKEN_PERR_STATE and FLEXCAN_QUIRK_BROKEN_WERR_STATE on
i.MX6 to verify that it should work with:
1. new FlexCAN core (with    [TR]WRN_INT connected), and
2. old FlexCAN core (without [TR]WRN_INT connected)

Because we cannot perform test on FlexCAN cores except i.MX6, the fix is
not enabled for other SOCs, e.g. i.MX53. These SOCs could also benefit
after to enabling the appropriate [PW]ERR_STATE quirk.

This series applies to kernel v4.13-rc5, but should also work on any
kernel which already switched to the rx-offload version of the flexcan
driver.

Zhu Yi (4):
  can: flexcan: fix state transition regression
  can: flexcan: rename legacy error state quirk
  can: flexcan: implement error passive state quirk
  can: flexcan: fix i.MX6 state transition issue

 drivers/net/can/flexcan.c | 90 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 14 deletions(-)

-- 
2.7.4



