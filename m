From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v11 01/10] can: peak_usb: updates and CANFD support
Date: Tue, 27 Jan 2015 19:30:28 +0100
Message-ID: <1422383438-7432-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44643 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbbA0Sal (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 13:30:41 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org

Hey

this series applies to net-next/master.

changes since v10:
- cherry picked 1/10 from net/master, needed for 10/10
- ssquahes Oliver's patch that marks adapter as non-ISO (10/10)

