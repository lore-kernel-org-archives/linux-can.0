From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH 0/4] Consolidate and unify state change handling
Date: Thu, 18 Sep 2014 16:25:36 +0000
Message-ID: <541B0780.4020101@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0089.outbound.protection.outlook.com ([157.56.111.89]:21760
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932092AbaIRQkO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Sep 2014 12:40:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi,

Here are my patches to improve consistency of error-state handling 
between platforms.

These are also my first patches posted to the linux kernel, so I 
apologise in advance if I'm doing something wrong.

Andri Yngvason (4):
  can: dev: Add generic error-state-change handling
  can: flexcan: Use generic error-state-change handling
  can: mscan: Use generic error-state-change handling
  can: sja1000: Use generic error-state-change handling

  drivers/net/can/dev.c             | 79 
+++++++++++++++++++++++++++++++++++++++
  drivers/net/can/flexcan.c         | 66 ++------------------------------
  drivers/net/can/mscan/mscan.c     | 62 ++++++++++++++----------------
  drivers/net/can/sja1000/sja1000.c | 29 +++++---------
  include/linux/can/dev.h           | 10 +++++
  include/uapi/linux/can/error.h    |  1 +
  6 files changed, 130 insertions(+), 117 deletions(-)

