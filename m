From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Bitrate and CAN status support for slcan
Date: Tue, 15 Apr 2014 16:51:03 +0200
Message-ID: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:40111 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960AbaDOOw0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 10:52:26 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This series adds bitrate selection support. It uses the API described
in the SLCAN-API which is identical on all listed serial interfaces.
Thus slcan only supports that limited set of bitrates, as only a bitrate
index is sent over serial wire.
Patch 5 also adds support for CAN status polling. This has do be done
regulrarly from CPU side.
Tests have been done on a LAWICEL CANUSB device.

Best regards,
Alexander
