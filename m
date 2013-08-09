From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2013-08-09
Date: Fri,  9 Aug 2013 11:44:05 +0200
Message-ID: <1376041446-24058-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52021 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965779Ab3HIJoV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2013 05:44:21 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, davem@davemloft.net

here is a fix for the v3.11 release cycle:

Stephane Grosjean has found and fixed a potential wrong length for the mempy()
in pcan_usb's decode usb data function.

regards,
Marc

