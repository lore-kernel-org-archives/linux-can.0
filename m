From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 1/3 v7] can/usb: PEAK-System Technik USB adapters driver
 core
Date: Fri, 02 Mar 2012 10:29:15 +0100
Message-ID: <4F5092EB.9000303@peak-system.com>
References: <1330354431-12974-1-git-send-email-s.grosjean@peak-system.com>
 <1330354431-12974-2-git-send-email-s.grosjean@peak-system.com>
 <4F4FB03C.9030003@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57312 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570Ab2CBJ3Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Mar 2012 04:29:25 -0500
In-Reply-To: <4F4FB03C.9030003@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

So, to confirm once for all:

a serie of patches could define several additions/changes to the same file?

> > I asked myself, why this was optimized in this way. IMO adding
> >
> > 1. PCIEC support
> > 2. PCMCIA support
> >
> > within two patches would be better, right?
> Yes:
> 1. add PCIEC in Kconfig + .c file changes
> 2. add PCMCIA in Kconfig and Makefile + new .c file

> diff --git a/drivers/net/can/usb/peak_usb/Makefile b/drivers/net/can/usb/peak_usb/Makefile
> new file mode 100644
> index 0000000..1aefbc8
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
> +peak_usb-y = pcan_usb_core.o pcan_usb.o pcan_usb_pro.o
> Same problem with bisecability here, please fix.

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt 
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt 
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391 
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
