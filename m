From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 0/6] can: flexcan: fix state transition, suppress irq flooding
Date: Wed, 13 Sep 2017 09:31:54 +0000
Message-ID: <38c9a9bdde424391807d3f6f7bf767fb@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:33778 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdIMJb6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2017 05:31:58 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 6fc859dea2a4f930a41e5a26345d3fa2f4b908d5 Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Tue, 12 Sep 2017 16:06:13 +0800
Subject: [PATCH 0/6] can: flexcan: fix state transition, suppress irq flooding

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
[PW]ERR_STATE quirks to limit error interrupt occurences to the mininum
required to report correct state transitions.

Patch 4~6 enables proper [PW]ERR_STATE on i.MX6, i.MX28 and p1010 to
enable correct state transitions on these SOCs.

This series applies to kernel v4.13-rc5, but should also work on any
kernel which already switched to the rx-offload version of the flexcan
driver.

Wolfgang Grandegger (1):
  can: flexcan: fix i.MX28 state transition issue

Zhu Yi (5):
  can: flexcan: fix state transition regression
  can: flexcan: rename legacy error state quirk
  can: flexcan: implement error passive state quirk
  can: flexcan: fix i.MX6 state transition issue
  can: flexcan: fix p1010 state transition issue

 drivers/net/can/flexcan.c | 95 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 15 deletions(-)

-- 
2.7.4



