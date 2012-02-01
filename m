From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 17:45:02 +0100
Message-ID: <4F296C0E.7030106@grandegger.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com> <4F295865.2040304@pengutronix.de> <4F295EB8.3090202@pengutronix.de> <4F296068.9090009@peak-system.com> <4F2960EF.6000308@pengutronix.de> <4F296503.4030801@grandegger.com> <4F296A39.60709@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40333 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2BAQpL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:45:11 -0500
In-Reply-To: <4F296A39.60709@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/01/2012 05:37 PM, Stephane Grosjean wrote:
> Le 01/02/2012 17:14, Wolfgang Grandegger a =E9crit :
>>
>> Yes, static inline functions please. I think we should have:
>>
>> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE=
)
>>     /* or a real option selecting the LED support */
>>
>>     ... one ifdef block with the real implementation ...
>> #else
>> static inline int peak_pciec_led_init(...) {return -EINVAL;}
>> static inline void peak_pciec_led_init(...) {}
>> #endif
>=20
> Well, there was/is some confusion indeed: I thought #ifdef/#endif blo=
cks
> were not welcome in code (that's the reason of the i2c_xxx() #defines=
)
> If I'm allowed to use at least one, the above option looks ok for me.

Well, we need at least one #ifdef somewhere if we do not want to use a
registration framework, I think. I will have a closer look to the drive=
r
later on my way home...

Wolfgang.
