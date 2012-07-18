From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] ARM i.MX53: add flexcan support
Date: Wed, 18 Jul 2012 11:42:41 +0200
Message-ID: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56676 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2GRJnB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 05:43:01 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de

Hello,

this series adds flexcan support to mx53 clock and device tree. In order
to work, an updated flexcan driver is needed, which is currently under
review [1].

This series applies to v3.5-rc7.

regards, Marc

[1] http://www.spinics.net/lists/arm-kernel/msg185139.html


