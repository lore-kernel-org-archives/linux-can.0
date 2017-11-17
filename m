From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/7] R-Car D3 (r8a77995) CAN support
Date: Fri, 17 Nov 2017 11:41:22 +0100
Message-ID: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44565 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdKQKlj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Nov 2017 05:41:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

Here's CAN and CAN FD support for the R-Car D3. This is a by-the-datasheet
implementation, with the datasheet missing some bits, namely the pin map.
I filled in the gaps with frog DNA^W^W^Wby deducing the information from
pin numbers already in the PFC driver, so careful scrutiny is advised.

CU
Uli


Ulrich Hecht (7):
  pinctrl: sh-pfc: r8a77995: Add CAN support
  pinctrl: sh-pfc: r8a77995: Add CAN FD support
  arm64: dts: r8a77995: Add CAN external clock support
  arm64: dts: r8a77995: Add CAN support
  arm64: dts: r8a77995: Add CAN FD support
  can: rcar_can: document r8a77995 (R-Car D3) compatibility strings
  can: rcar_canfd: document r8a77995 (R-Car D3) compatibility strings

 .../devicetree/bindings/net/can/rcar_can.txt       | 13 ++--
 .../devicetree/bindings/net/can/rcar_canfd.txt     | 13 ++--
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 64 ++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              | 86 ++++++++++++++++++++++
 4 files changed, 164 insertions(+), 12 deletions(-)

-- 
2.7.4

