From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 1/9] can: peak_usb: updates and CANFD support
Date: Tue, 27 Jan 2015 17:41:41 +0100
Message-ID: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34151 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbA0Qlx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 11:41:53 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org

Hey,

picking up St=C3=A9phane's work.

Changes since v9
- 1/9: convert peak_usb_adapters_list from NULL termination to
       ARRAY_SIZE usage
- 2/9: constify struct peak_usb_adapter

regards,
Marc

