From: matthias.fuchs@esd.eu
Subject: [PATCH v2 0/2] can: usb: esd_usb2: Add support for CAN-USB/Micro and listen-only mode
Date: Mon, 29 Oct 2012 10:54:46 +0100
Message-ID: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55011 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab2J2J4M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 05:56:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Matthias Fuchs <matthias.fuchs@esd.eu>

From: Matthias Fuchs <matthias.fuchs@esd.eu>

Changes in v2:
- split in two separate patches
- don't check can.ctrlmode depedant on product variant.
  This is handled by the linux-can framework.

Matthias Fuchs (2):
  can: usb: esd_usb2: Add support for listen-only mode
  can: usb: esd_usb2: Add support for CAN-USB/Micro

 drivers/net/can/usb/esd_usb2.c |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

-- 
1.7.4.1

