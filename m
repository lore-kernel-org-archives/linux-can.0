From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Wed, 01 Feb 2012 17:37:13 +0100
Message-ID: <4F296A39.60709@peak-system.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com>
 <4F295865.2040304@pengutronix.de> <4F295EB8.3090202@pengutronix.de>
 <4F296068.9090009@peak-system.com> <4F2960EF.6000308@pengutronix.de>
 <4F296503.4030801@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:33426 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab2BAQhW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:37:22 -0500
In-Reply-To: <4F296503.4030801@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 01/02/2012 17:14, Wolfgang Grandegger a =E9crit :
>
> Yes, static inline functions please. I think we should have:
>
> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
> 	/* or a real option selecting the LED support */
>
> 	... one ifdef block with the real implementation ...
> #else
> static inline int peak_pciec_led_init(...) {return -EINVAL;}
> static inline void peak_pciec_led_init(...) {}
> #endif

Well, there was/is some confusion indeed: I thought #ifdef/#endif block=
s=20
were not welcome in code (that's the reason of the i2c_xxx() #defines)
If I'm allowed to use at least one, the above option looks ok for me.

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
