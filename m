From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Sun, 16 Jun 2013 14:39:09 +0200
Message-ID: <51BDB1ED.1040603@grandegger.com>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34549 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3FPMjL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Jun 2013 08:39:11 -0400
In-Reply-To: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mirza@hostmobility.com
Cc: linux-can@vger.kernel.org

On 06/16/2013 01:20 PM, mirza@hostmobility.com wrote:
>=20
>=20
> -------- Ursprungligt meddelande --------
>> Fr=E5n: Wolfgang Grandegger <wg@grandegger.com>
>> Skickat: den 16 juni 2013 11:19
>> Till: Mirza Krak <mirza.krak@hostmobility.com>
>> =C4mne: Re: Dual SJA1000 can controllers on SMP system.
>>
>> On 06/13/2013 02:47 PM, Mirza Krak wrote:
>>> Dear Sirs.
>>>
>>> I am running a 3.1.10 kernel on Nvidia Tegra 2 CPU (Dual Core). Not
>>> vanilla kernel (Linux4Tegra).
>>>
>>> We are using dual can controllers connected on th external data bus=
 on
>>> our custom hardware. The can controllers are SJA1000.
>>
>> What external data bus is the CAN controller connected to?
>> And which CAN controller board/card?
>=20
> As I mentioned the CAN controllers are SJA1000 and the SJA1000 chip i=
s integrated in our board. No external card/board for SJA1000 chip.
>=20
> It is connected to the Nvidia Tegra 2 externa data bus (a.k.a SNOR).=20
>=20
>>> Driver that is used is vanilla sja1000 driver (sja1000.c)
>>
>> Which bus driver is used and how do you load the module?
>=20
> The bus driver is tegra_snor and is linked in statically in the kerne=
l. =20

The low-level device initialization and access is not done in sja1000.c
but by another driver module, e.g., sja1000_isa, sja1000_platform,
ems_pci.c. What module are you using? What functions are you using to
access the SNOR bus?

Wolfgang.

