From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/2] can: gs_usb: codingstyle fixes + set_phys_id callback
Date: Fri, 17 Jun 2016 12:03:25 +0200
Message-ID: <1466157807-12727-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46589 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159AbcFQKDa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 06:03:30 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=hardanger.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1bDqca-0003Yq-I3
	for linux-can@vger.kernel.org; Fri, 17 Jun 2016 12:03:28 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>

Hello,

v2 of Hubert and Maximilian work. Changes:

- split coding style changes into separate patch
- gs_usb_set_identify() return proper error value instead of -1

regards,
Marc

