From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Several patches mainline status
Date: Tue, 11 Apr 2017 15:53:50 +0200
Message-ID: <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:34554 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbdDKNyc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Apr 2017 09:54:32 -0400
In-Reply-To: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>, "mario.huettel@gmx.net" <mario.huettel@gmx.net>, Mario Kicherer <dev@kicherer.org>, Andreas Werner <andreas.werner@men.de>

Hi Marc,

here's my list of pending patches to be considered for upstream:

[PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
STATUS: we both reviewed this patch -> should be ok
http://marc.info/?l=linux-can&m=148483988920494&w=2

[PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
STATUS: We introduced infrastructure (fixed bitrate/termination)
http://marc.info/?l=linux-can&m=148534935211400&w=2

[PATCH v4 1/7] can: m_can: (upgrade to newer IP cores)
STATUS: we both reviewed this patch & tested by Quentin Schulz
For that reason I would suggest to upstream Mario's v4 patch set:

http://marc.info/?l=linux-can&m=149165343604033&w=2
http://marc.info/?l=linux-can&m=149165343304029&w=2
http://marc.info/?l=linux-can&m=149165343304030&w=2
http://marc.info/?l=linux-can&m=149165343604031&w=2
http://marc.info/?l=linux-can&m=149165343604032&w=2
http://marc.info/?l=linux-can&m=149165343804036&w=2
http://marc.info/?l=linux-can&m=149165343704035&w=2

[PATCH RESEND] net: can: Introduce MEN 16Z192-00 CAN controller driver
STATUS: No review so far?
http://marc.info/?l=linux-can&m=146952497113100&w=2
http://marc.info/?l=linux-can&m=146857017211840&w=2

[PATCH can-next] can: fix initial calculation of total rx/tx rate in CAN 
statistics
STATUS: integrated into following netns complete patch
http://marc.info/?l=linux-can&m=146779206204365&w=2

[PATCH RFC v2] can: complete initial namespace support
STATUS: completes & fixes initial netns patch
http://marc.info/?l=linux-can&m=149182812827576&w=2

And now (brandnew):
[PATCH] can: introduce CANFD_FDF flag for mixed content in struct 
canfd_frame
STATUS: Was sitting for some time on my box. NVIDIA is doing similar 
stuff in their BSP for their Drive PX2
http://marc.info/?l=linux-can&m=149191823322125&w=2

Regards,
Oliver

