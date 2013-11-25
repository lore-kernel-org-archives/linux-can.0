From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
Date: Mon, 25 Nov 2013 18:15:49 +0100
Message-ID: <1385399751-19109-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57788 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab3KYRP7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 12:15:59 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

Hello,

this series first fixes a bug in the flexcan driver, using the wrong clock for
the bit rate calculcation. The next patch switches the peripheral clock on
i.MX53 to lp_apm, which has a rate of 24 MHz. This is optimal for the CIA
recommended bit rates.

Tested on TQ's mba53 and mba6x [1].

Who is taking the series? Due to Lucas' patch:

    0a5b8df clk: imx5: introduce DT includes for clock provider

this series does not yet apply to my upstream (net-next/mastet).

Marc

[1] On i.MX6 the following patch is needed (which is already in Shawn's
    for-next):

    9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock

