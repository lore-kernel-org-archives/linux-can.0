From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 0/5 resend] can: various fixes to xilinx_can driver
Date: Fri, 26 Jan 2018 16:27:18 +0200
Message-ID: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:60718 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752393AbeAZOhu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 26 Jan 2018 09:37:50 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>

Hi all,

I submitted a few bugfixes in Feb 2017 ("can: various fixes to
xilinx_can driver") but they were not applied, so here they are again.

I seem to have missed CCing Michal Simek (the maintainer per
MAINTAINERS) last time, but I've included him in the loop now so he can
comment.

The last patch saw several revisions after comments from Marc, the one here
is the same as the last version posted back then.

I've rebased them on top of linux-can/master and tested on Zynq-7000 HW.


Anssi Hannula (5):
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: only report warning and passive states on state changes
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting

 drivers/net/can/xilinx_can.c | 314 +++++++++++++++++++++++++++------
 1 file changed, 256 insertions(+), 58 deletions(-)

-- 
Anssi Hannula / Bitwise Oy

