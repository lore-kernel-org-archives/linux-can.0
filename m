From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 boards
Date: Wed, 01 Feb 2012 14:46:57 +0100
Message-ID: <4F294251.4040600@grandegger.com>
References: <1328094132-20738-1-git-send-email-s.grosjean@peak-system.com> <4F2929CD.90604@grandegger.com> <4F293035.2060201@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34435 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab2BANrA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 08:47:00 -0500
In-Reply-To: <4F293035.2060201@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 02/01/2012 01:29 PM, Stephane Grosjean wrote:
> Le 01/02/2012 13:02, Wolfgang Grandegger a =E9crit :
>> On 02/01/2012 12:02 PM, Stephane Grosjean wrote:
>>> This patch adds the support for the following 3x sja1000 based PCI
>>> boards
>>> from PEAK-System Technik (www.peak-system.com):
>>>
>>> PCAN-PCI Express (1 or 2 channels)
>>> PCAN-ExpressCard (1 or 2 channels)
>>> PCAN-miniPCI (1 or 2 channels)
>>>
>>> This version also updates Kconfig.
>>>
>>> Signed-off-by: Stephane Grosjean<s.grosjean@peak-system.com>
>>> ---
>>>   drivers/net/can/sja1000/Kconfig    |    7 +-
>>>   drivers/net/can/sja1000/peak_pci.c |  510
>>> +++++++++++++++++++++++++++++++++--
>>>   2 files changed, 484 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/net/can/sja1000/Kconfig
>>> b/drivers/net/can/sja1000/Kconfig
>>> index 36e9d59..d178e01 100644
>>> --- a/drivers/net/can/sja1000/Kconfig
>>> +++ b/drivers/net/can/sja1000/Kconfig
>>> @@ -44,11 +44,12 @@ config CAN_EMS_PCI
>>>         (http://www.ems-wuensche.de).
>>>
>>>   config CAN_PEAK_PCI
>>> -    tristate "PEAK PCAN PCI/PCIe Cards"
>>> +    tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>>>       depends on PCI
>> It now also depends on I2C.

To be more precise, it depends on "CONFIG_I2C_ALGOBIT".

> Yes you're right...but if I added such a dependency, I2C would be
> mandatory, even for the other PEAK PCI boards

Yes, and I was already thinking if it's a good idea...

>=20
> I would prefer:
>=20
> 1 - Changing Kconfig : like that
>=20
> config CAN_PEAK_PCI
>         tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
>         depends on PCI
>         ---help---
>           This driver is for the PCAN-PCI/PCIe/miniPCI cards
>           (1, 2, 3 or 4 channels) from PEAK-System Technik
>           (http://www.peak-system.com).
>=20
>           The I2C driver must be selected to fully support the
>           PCAN-ExpressCard card LEDs.

Does the PCAN-ExpressCard card work without I2C? If yes, I would be
enough to use CONFIG_I2C_ALGOBIT directly around the relevant code.

> config CAN_PEAK_PCIEC
>         bool "PEAK PCAN-ExpressCard Card"
>         depends on CAN_PEAK_PCI && I2C
>         ---help---
>           Add full support of the PCAN-ExpressCard card
>           (1, 2, 3 or 4 channels) from PEAK-System Technik
>           (http://www.peak-system.com).
>=20
>=20
> 2 - adding some #ifdef CONFIG_PEAK_PCIEC/ #endif in peak_pci.c around
> all what concerns leds management.

Not only LED management but the *complete* support for the
PCAN-ExpressCard card, in case I2C is mandatory. Using a separate file,
e.g. peak_pciec.c would be nice, but I think it does not make the code
more readable. Therefore, I think a few #ifdef are tolerable.

Wolfgang.

