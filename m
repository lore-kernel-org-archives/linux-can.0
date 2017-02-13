From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 0/5] can: various fixes to xilinx_can driver
Date: Mon, 13 Feb 2017 15:12:03 +0200
Message-ID: <20170213131208.20227-1-anssi.hannula@bitwise.fi>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:41144 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbdBMNbD (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 13 Feb 2017 08:31:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>

Hi,

Here are several bugfixes for the xilinx_can driver found while taking
the driver into use.

I've marked the three more serious ones for stable (issues with RX/TX
FIFOs and RX overrun). Those are also the ones that mostly remove code
instead of adding lines.


Anssi Hannula (5):
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: only report warning and passive states on state changes
      can: xilinx_can: fix TX FIFO accounting getting out of sync

 xilinx_can.c |  208 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 142 insertions(+), 66 deletions(-)


-- 
Anssi Hannula / Bitwise Oy

