From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: make user of struct of_device_id.data const
Date: Fri, 13 Jul 2012 15:04:22 +0200
Message-ID: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50407 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252Ab2GMNE2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 09:04:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello,

my coworker Uwe just posted a series to make of_device_id.data const [1].
This series changes the users of of_device_id.data to const in the CAN tree.

Marc

[1] http://www.spinics.net/lists/arm-kernel/msg184407.html


