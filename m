From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: [PATCH 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 21 Oct 2014 10:27:52 +0200
Message-ID: <54461908.2040502@hartkopp.net>
References: <1413199410-42938-1-git-send-email-Thomas.Koerper@esd.eu> <544537AE.6030607@hartkopp.net> <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1B54B@esd-s3.esd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:53114 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaJUI17 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Oct 2014 04:27:59 -0400
In-Reply-To: <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1B54B@esd-s3.esd.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VGhvbWFzIEvDtnJwZXI=?= <Thomas.Koerper@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 21.10.2014 09:46, Thomas K=C3=B6rper wrote:
>>> Signed-off-by: Thomas K=C3=B6rper <Thomas.Koerper@esd.eu>
>>
>> Capital letters in mail addresses - ugh.
>
> At least in the Signed-off string I will/can fix it :)
> Btw, what about the umlaut?, haven't found infos on how source may/sh=
all be encoded.

Some people use UTF-8 and many setups display strange things afterwards=
=2E
If you don't mind try 'oe' like in the mail address :-)


>> E.g. introduce a esdacc.h include and esdacc.c which contains the es=
dACC specific stuff (compare to sja1000.[ch]).
>
> Good idea, esd402.h will become esdacc.h and another source esdacc.c =
will be added.

cool

>
>> Does your driver support the PCI400 too?
>> http://esd.eu/en/products/can-pci400
>>
>> You because I have one of it and could do some testing then.
>
> No. But if you'd like to have a PCIe/402 for testing this shouldn't b=
e problem, I guess.

Thanks but I just lack some PCIe capable PC :-)
Do you plan to support the PCI400 later?


>> Does it make sense to name the directory 'esdacc' ?
>> There is ESD hardware in drivers/net/can/usb too.
>>
>> With esdacc we would have a CAN IP core specific directory like we h=
ave for the sja1000, c_can, etc ...
>
> I don't know. I was thinking of more (also none-esdACC) esd cards tha=
t might be added in the future.
>

ok. When you support active cards (like the softing cards) naming it es=
d fits=20
indeed. But SJA1000 based cards (from ESD) should still go into the sja=
1000 tree.

>>> +	  Support for CAN PCIe/402 cards from esd electronic system desig=
n
>>> +gmbh
>>
>> GmbH ??
>
> No...

Ah - I've seen it on your website.
'gmbh' looks like a part of a brand name.

Together with the website URL it looks fine.

>
>>> +#define DRV_NAME			"esd402_driver"
>>
>> esd402_pcie
>>
>> ?
>
> But a PCI/402 is under development, so what about esd402_pci?

ACK.

>
>>> +
>>> +static inline u32 ov_read32(struct esd_pci402_card *card, unsigned
>>> +short offs) {
>>> +	return ioread32be(card->addr_overview + offs); }
>>> +
>>> +static inline void ov_write32(struct esd_pci402_card *card,
>>> +			      unsigned short offs, u32 v)
>>> +{
>>> +	iowrite32be(v, card->addr_overview + offs); }
>>
>> Does it make sense to put these access functions into the same indir=
ection as you can see in the sja1000 or c_can driver?
>
> You mean the priv pointer instead of my card pointer? Think it should=
 become some acc pointer when moved to esdacc.c.

Yes. Exactly this was my intention.

Regards,
Oliver

