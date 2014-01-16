From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 1/5] License cleanup
Date: Thu, 16 Jan 2014 17:12:29 +0100
Message-ID: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55314 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbaAPQMh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 11:12:37 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=hardanger.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1W3pYa-0006ba-CP
	for linux-can@vger.kernel.org; Thu, 16 Jan 2014 17:12:36 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Picking up ukl's patches.

I've shuffled the orer a bit, first remove all unused headers, then add
explicit license information to isotp. I've split the move header patch into
two patches, so that the second patch only doesn't need to change the header
files contents. As Oliver requested, I'v also moved the isotp header.

regards,
Marc

