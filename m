From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 0/3] hwinit support for non-TI devices
Date: Tue, 13 May 2014 15:40:18 +0200
Message-ID: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59066 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933404AbaEMNkZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 09:40:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello,

picking uo Pavel Machek's and Thor Thayer's patches.

changes since v3:
- split make const into seperate patch (1/3)
- squash make const of 32 bit accessor functions into existing 32-bit accesses (2/3)
- the remaining changes are on 3/3

Marc

