From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/3] remove do_get_state() callback
Date: Mon,  7 Oct 2013 16:46:05 +0200
Message-ID: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51931 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab3JGOqW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:46:22 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello,

this patch series removes the do_get_state() callback from the driver
interface, as it is not needed to get the state of the interface.

regards,
Marc

