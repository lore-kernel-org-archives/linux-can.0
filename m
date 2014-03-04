From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v11 0/7] Add CAN FD infrastructure for CAN driver
Date: Tue,  4 Mar 2014 23:00:10 +0100
Message-ID: <1393970417-15399-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45815 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbaCDWA3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 17:00:29 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Again, it's me messing in Oliver's patches.

changes since v10
- 5/7: Re-add call to priv->do_set_data_bittiming().
- 6/7 + 7/7: don't touch "if (data[IFLA_CAN_DATA_BITTIMING])" in 7/7, but in 6/7

Marc

