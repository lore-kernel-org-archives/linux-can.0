From: <tthayer@altera.com>
Subject: [PATCH] net: c_can: Add support for DCAN Module RAM Init
Date: Wed, 16 Apr 2014 13:29:32 -0500
Message-ID: <1397672973-3480-1-git-send-email-tthayer@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0101.outbound.protection.outlook.com ([207.46.100.101]:50041
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755278AbaDPSi6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Apr 2014 14:38:58 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de
Cc: socketcan@hartkopp.net, anilkumar@ti.com, tglx@linutronix.de, tthayer.linux@gmail.com

This patch adds support for the general DCAN module which has
the RAM Init bit in the CFR register [offset 0x18]. The existing
D_CAN implementation was written for TI which uses a separate
register (outside the D_CAN module) for CAN RAM initialization.
I do not have access to the TI D_CAN implementation so if someone 
can test on that platform, it would be appreciated.

[PATCH] net: c_can: Add support for D_CAN RAM Init bit in D_CAN
