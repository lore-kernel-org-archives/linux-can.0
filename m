From: Marek Vasut <marex@denx.de>
Subject: [PATCH V3 0/4] Synchronise IFI CANFD driver with real world
Date: Wed,  2 Mar 2016 21:23:17 +0100
Message-ID: <1456950201-4812-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58835 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbcCBUXd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Mar 2016 15:23:33 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, Marek Vasut <marex@denx.de>

Thus far, this driver was only tested on a hardware synthesised in
the warm and safe insides of an FPGA, only against another IFI CANFD
core. The real hardware arrived now and I tested the IFI CANFD driver
against different, harsh, real-world CAN controller.

This uncovered a few bugs, so here are the fixes for those.

Marek Vasut (4):
  net: can: ifi: Fix clock generator configuration
  net: can: ifi: Fix TX DLC configuration
  net: can: ifi: Fix RX and TX ID mask
  net: can: ifi: Add obscure bit swap for EFF frame IDs

 drivers/net/can/ifi_canfd/ifi_canfd.c | 96 ++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 35 deletions(-)

-- 
2.7.0

