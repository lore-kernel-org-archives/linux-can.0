From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Mon, 17 Jun 2013 08:10:43 +0200
Message-ID: <51BEA863.1040704@hostmobility.com>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net> <51BDB1ED.1040603@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:59780 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab3FQGKy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 02:10:54 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so2024941lab.23
        for <linux-can@vger.kernel.org>; Sun, 16 Jun 2013 23:10:52 -0700 (PDT)
In-Reply-To: <51BDB1ED.1040603@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


On 06/16/2013 02:39 PM, Wolfgang Grandegger wrote:
> On 06/16/2013 01:20 PM, mirza@hostmobility.com wrote:
>>
>>
>> -------- Ursprungligt meddelande --------
>>> Fr=E5n: Wolfgang Grandegger <wg@grandegger.com>
>>> Skickat: den 16 juni 2013 11:19
>>> Till: Mirza Krak <mirza.krak@hostmobility.com>
>>> =C4mne: Re: Dual SJA1000 can controllers on SMP system.
>>>
>>> On 06/13/2013 02:47 PM, Mirza Krak wrote:
>>>> Dear Sirs.
>>>>
>>>> I am running a 3.1.10 kernel on Nvidia Tegra 2 CPU (Dual Core). No=
t
>>>> vanilla kernel (Linux4Tegra).
>>>>
>>>> We are using dual can controllers connected on th external data bu=
s on
>>>> our custom hardware. The can controllers are SJA1000.
>>>
>>> What external data bus is the CAN controller connected to?
>>> And which CAN controller board/card?
>>
>> As I mentioned the CAN controllers are SJA1000 and the SJA1000 chip =
is integrated in our board. No external card/board for SJA1000 chip.
>>
>> It is connected to the Nvidia Tegra 2 externa data bus (a.k.a SNOR).
>>
>>>> Driver that is used is vanilla sja1000 driver (sja1000.c)
>>>
>>> Which bus driver is used and how do you load the module?
>>
>> The bus driver is tegra_snor and is linked in statically in the kern=
el.
>
> The low-level device initialization and access is not done in sja1000=
=2Ec
> but by another driver module, e.g., sja1000_isa, sja1000_platform,
> ems_pci.c. What module are you using? What functions are you using to
> access the SNOR bus?

Aah off course. The low-level device driver is sja1000_platform.c. The=20
functions I am using are sp_read_reg8 and sp_write_reg8 which I have=20
slightly modified. Since I don't use multiplexed bus functionality I=20
write the address first.

   static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
{
	iowrite8(reg, priv->reg_base);
	return ioread8(priv->reg_base + 0x20);
}

static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 =
val)
{
	iowrite8(reg, priv->reg_base);
	iowrite8(val, (priv->reg_base + 0x20));
}

>
> Wolfgang.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
