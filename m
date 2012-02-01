From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 17:14:59 +0100
Message-ID: <4F296503.4030801@grandegger.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com> <4F295865.2040304@pengutronix.de> <4F295EB8.3090202@pengutronix.de> <4F296068.9090009@peak-system.com> <4F2960EF.6000308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39170 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab2BAQPP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:15:15 -0500
In-Reply-To: <4F2960EF.6000308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: s.grosjean@peak-system.com, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/01/2012 04:57 PM, Marc Kleine-Budde wrote:
> On 02/01/2012 04:55 PM, Stephane Grosjean wrote:
>> Le 01/02/2012 16:48, Marc Kleine-Budde a =E9crit :
>>> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODUL=
E)
>>> #define peak_pci_support_pcie()    (1)
>>> #else
>>> #define peak_pci_support_pcie()    (0)
>>> #endif
>>>
>>> In the probe function you can write:
>>>
>>> probe() {
>>>     ...
>>>
>>>     if (peak_pci_support_pcie()&&
>>>     pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID) {
>>>         ...
>>>     }
>>> }
>>>
>>> There should be no ifdefs left in the code. One question remains, i=
s the
>>> i2c core clever enough to define no-ops if the i2c subsystem is swi=
tched
>>> off?
>>> I just tried - :( - it doesn't work
>>>
>>> drivers/net/can/sja1000/peak_pci.c: In function
>>> 'peak_pciec_write_pca9553':
>>> drivers/net/can/sja1000/peak_pci.c:267: error: implicit declaration=
 of
>>> function 'i2c_transfer'
>>> drivers/net/can/sja1000/peak_pci.c: In function 'peak_pciec_init':
>>> drivers/net/can/sja1000/peak_pci.c:491: error: implicit declaration=
 of
>>> function 'i2c_del_adapter'
>>>
>>> Marc
>>
>> What about that:
>>
>>> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODUL=
E)
>>> #define peak_pci_support_pcie()    (1)
>>> #else
>>> #define peak_pci_support_pcie()    (0)
>> #define i2_transfer(a, b, c)
>> #define i2c_del_adapter(a)

Why that? I think there is some confusion.

>>> #endif
>=20
> This is an option, please make it static inline function, to have
> typechecking.
>=20
> Wolfgang, what do you think?

Yes, static inline functions please. I think we should have:

#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
	/* or a real option selecting the LED support */

	... one ifdef block with the real implementation ...
#else
static inline int peak_pciec_led_init(...) {return -EINVAL;}
static inline void peak_pciec_led_init(...) {}
#endif

In the rest of the code, only the above two functions should be used.
Should work, if I have not overlooked something.

Hope it's clear what I mean.

Wolfgang.

