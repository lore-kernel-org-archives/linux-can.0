From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: PCAN-PCIe FD & mcba_usb mainline status?
Date: Sun, 5 Mar 2017 20:06:27 +0100
Message-ID: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:28917 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdCETGh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 5 Mar 2017 14:06:37 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>

Hi Marc,

these drivers are hanging around since January:

[PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
http://marc.info/?l=linux-can&m=148483988920494&w=2

[PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
http://marc.info/?l=linux-can&m=148534935211400&w=2

What prevents you from pushing these drivers to mainline?

Regards,
Oliver
