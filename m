From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/9] upcoming pull request: const annoations + flexcan + janz-ican3 update
Date: Fri, 20 Jul 2012 13:11:40 +0200
Message-ID: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42078 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab2GTLLx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

Hello,

this is my upcoming pull request to David. Ira, I had a trivial conflict
while merging your patches. Further I improved the ican3_to_can_frame and
can_frame_to_ican3 functions. The helper "get_can_dlc()" is to limit the
dlc value coming from the controller, further only dlc bytes are copied
from and to the controller, not the whole frame. (see patch 5/9).

This pull request will also contain the flexcan update for imx53 and the
bittiming_const annotation posted earlier this week.

Pleae review and test.
Feel free to send Acked-by, Tested-by, Reviewed-by etc :)

regards, Marc


