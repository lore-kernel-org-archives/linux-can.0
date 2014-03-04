From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 1/7] Add CAN FD infrastructure for CAN driver
Date: Tue,  4 Mar 2014 21:44:08 +0100
Message-ID: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54681 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbaCDUoT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 15:44:19 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Picking up Oliver's patches.

I've added Stephane's Acked-by to all patches.

Changes since v9:
- 3/7 + 4/7
  I moved the simplified "if" in can_get_bittiming() from 4/7 into 3/7,
  so the more complicated if is not introduced in the first place.
- 5/7
  In can_changelink(), when setting the data bittining, I removed the call to
  priv->do_set_data_bittiming().
  Further I moved the new "if (data[IFLA_CAN_DATA_BITTIMING])" at the bottom,
  so that all "if"s are sorted by "IFLA_".
- 6/7
  can_change_mtu(): fix indention after "default" in "switch"

Marc

