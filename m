From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: Several patches mainline status
Date: Thu, 13 Apr 2017 10:15:57 +0200
Message-ID: <f7bde974-b438-ca28-39c6-2ecf0bd8df3f@peak-system.com>
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
 <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:49245 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdDMIP4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Apr 2017 04:15:56 -0400
In-Reply-To: <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>, "mario.huettel@gmx.net" <mario.huettel@gmx.net>, Mario Kicherer <dev@kicherer.org>, Andreas Werner <andreas.werner@men.de>

Hi,

IMHO the below list is missing this patches list too:

[PATCH 0/2] can: peak: Add support of new USB device

sent on 03/27, which adds a new USB device Id. to the list of supported 
devices. Can you check this, please?

Regards,

Stéphane

Le 11/04/2017 à 15:53, Oliver Hartkopp a écrit :
> Hi Marc,
>
> here's my list of pending patches to be considered for upstream:
>
> [PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
> STATUS: we both reviewed this patch -> should be ok
> http://marc.info/?l=linux-can&m=148483988920494&w=2
>
> [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
> STATUS: We introduced infrastructure (fixed bitrate/termination)
> http://marc.info/?l=linux-can&m=148534935211400&w=2
>
> [PATCH v4 1/7] can: m_can: (upgrade to newer IP cores)
> STATUS: we both reviewed this patch & tested by Quentin Schulz
> For that reason I would suggest to upstream Mario's v4 patch set:
>
> http://marc.info/?l=linux-can&m=149165343604033&w=2
> http://marc.info/?l=linux-can&m=149165343304029&w=2
> http://marc.info/?l=linux-can&m=149165343304030&w=2
> http://marc.info/?l=linux-can&m=149165343604031&w=2
> http://marc.info/?l=linux-can&m=149165343604032&w=2
> http://marc.info/?l=linux-can&m=149165343804036&w=2
> http://marc.info/?l=linux-can&m=149165343704035&w=2
>
> [PATCH RESEND] net: can: Introduce MEN 16Z192-00 CAN controller driver
> STATUS: No review so far?
> http://marc.info/?l=linux-can&m=146952497113100&w=2
> http://marc.info/?l=linux-can&m=146857017211840&w=2
>
> [PATCH can-next] can: fix initial calculation of total rx/tx rate in 
> CAN statistics
> STATUS: integrated into following netns complete patch
> http://marc.info/?l=linux-can&m=146779206204365&w=2
>
> [PATCH RFC v2] can: complete initial namespace support
> STATUS: completes & fixes initial netns patch
> http://marc.info/?l=linux-can&m=149182812827576&w=2
>
> And now (brandnew):
> [PATCH] can: introduce CANFD_FDF flag for mixed content in struct 
> canfd_frame
> STATUS: Was sitting for some time on my box. NVIDIA is doing similar 
> stuff in their BSP for their Drive PX2
> http://marc.info/?l=linux-can&m=149191823322125&w=2
>
> Regards,
> Oliver
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Stéphane Grosjean
PEAK-System France
132, rue André Bisiaux
F54320 MAXEVILLE
Tél : +(33) 9.72.54.51.97

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
