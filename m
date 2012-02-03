From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Fri, 03 Feb 2012 11:59:48 +0100
Message-ID: <4F2BBE24.5090601@grandegger.com>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com> <4F2ACFE9.3080602@hartkopp.net> <4F2B16F9.8020903@hartkopp.net> <4F2BB498.60606@grandegger.com> <4F2BBA8C.3020501@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50580 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab2BCK7v (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 05:59:51 -0500
In-Reply-To: <4F2BBA8C.3020501@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/03/2012 11:44 AM, Stephane Grosjean wrote:
> Le 03/02/2012 11:19, Wolfgang Grandegger a =E9crit :
>> On 02/03/2012 12:06 AM, Oliver Hartkopp wrote:
>>> On 02.02.2012 19:03, Oliver Hartkopp wrote:
>>>
>>>
>>> The problem is that the PCAN-ExpressCards without galvanic isolatio=
n
>>> (IPEH-003000, IPEH-003001) are not working at all when the I2C stuf=
f
>>> is not
>>> initialized.
>> If that is true...
>=20
> Yes this is true but for PCAN-ExpressCard without galvanic isolation
> only, that is, PCAN-ExpressCard with galvanic isolation won't need I2=
C
> stuff..
>=20
>> What about this:
>>
>>   config CAN_PEAK_PCI
>>     tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
>>     depends on PCI
>>     ---help---
>>       This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 chann=
els)
>>       from PEAK Systems (http://www.peak-system.com).
>>       This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
>>       (1, 2, 3 or 4 channels) from PEAK-System Technik
>>       (http://www.peak-system.com).
>>
>>       The I2C bit-banging algorithm (I2C ALGOBIT) needs to be select=
ed to
>>       support PCAN-ExpressCard (PCIeC) cards.
>>
>>
>>    config CAN_PEAK_PCIEC
>>       bool "PEAK PCAN-Express Cards"
>>       depends on CAN_PEAK_PCI&&  I2C_ALGOBIT
>>       default y
>=20
> So, I think that the following is closer to the truth:
>=20
>  config CAN_PEAK_PCI
> -    tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
> +    tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>     depends on PCI
>     ---help---
>       This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
>       (1, 2, 3 or 4 channels) from PEAK-System Technik
>       (http://www.peak-system.com).
>=20
>       The I2C bit-banging algorithm (I2C ALGOBIT) needs to be selecte=
d to
> -      support PCAN-ExpressCard (PCIeC) cards.
> +      support PCAN-ExpressCard cards models without galvanic isolati=
on
> +       that is, IPEH-003000 and IPEH-003001.
>=20
>  config CAN_PEAK_PCIEC_I2C
> +     bool "PEAK non-isolated PCAN-ExpressCard Cards"
>      depends on CAN_PEAK_PCI&&  I2C_ALGOBIT
>      default y
> +    ---help---
> +        Say Y here if your PEAK-System Technik PCAN-ExpressCard is n=
ot
> equipped
> +        with any galvanic isolation (IPEH-003000 and IPEH-003001)  .
>=20
>=20
> (sorry for the manual-made patch style)

Well, that is even more confusing. What happens if there is no LED
support. If the LEDs are not blinking or illuminated users might think
the card is not working. I would go for CAN_PEAK_PCIEC config enabling
the support for the PCIEC *explicitly*. I mean, no support for the PCIE=
C
if CAN_PEAK_PCIEC is not enabled. You may want to use the select trick
if you prefer on that config. What do the others think?

Wolfgang.
