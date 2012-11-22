From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/8] can: add MODULE_ALIAS and MODULE_DEVICE_TABLE
Date: Thu, 22 Nov 2012 13:19:42 +0100
Message-ID: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48607 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab2KVTT5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:57 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=hardanger.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1TbVl3-0004cG-Ao
	for linux-can@vger.kernel.org; Thu, 22 Nov 2012 13:19:53 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

this series of patches adds a MODULE_ALIAS for the platform bindings and a
MODULE_DEVICE_TABLE for of bindings to drivers that lack these. This results in
modules that can be loaded automatically by udev.

regards, Marc

