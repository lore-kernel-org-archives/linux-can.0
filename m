From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 0/4] Bitrate and CAN status support for slcan
Date: Mon, 12 May 2014 11:58:40 +0200
Message-ID: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55379 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752579AbaELKAN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 06:00:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

This is the second (and probably last) patchset for Bitrate and CAN status
support for slcan. It is based on v3.15-rc5 including the suggestions from
Marc.
I'm aware this will not be accepted mainline, this is just for the records
in case someone else want to do it.
With the current C_CAN fixes we don't need this actually anyway.

Best regards
Alexander

Alexander Stein (4):
  can: slcan: Convert to can_dev interface
  can: slcan: Send open/close command upon interface up/down
  can: slcan: Add bitrate change support
  can: slcan: Add CAN status flag support

 drivers/net/can/Kconfig |  41 ++---
 drivers/net/can/slcan.c | 404 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 363 insertions(+), 82 deletions(-)

-- 
1.8.5.5

