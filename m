From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/2] arm: imx/mxs: enable flexcan driver
Date: Mon,  2 Jul 2012 11:02:59 +0200
Message-ID: <1341219781-26107-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36941 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449Ab2GBJDG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 05:03:06 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org

Hello,

as the flexcan driver has DT binding for some time now. This patch makes
the flexcan driver available in the can drivers menu if a SOC with flexcan
is enabled.

Changes since v2:
- improve commit message as requested by Shawn

regards, Marc


