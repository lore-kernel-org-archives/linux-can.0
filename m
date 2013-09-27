From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 11:43:59 +0200
Message-ID: <5245535F.6020804@pengutronix.de>
References: <21060.15934.600859.167074@ipc1.ka-ro> <524455FD.7070808@pengutronix.de> <20130926155422.GQ12758@n2100.arm.linux.org.uk> <52445FBE.4060503@ti.com> <21061.20097.221946.197751@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="unkEvogRw9NlkiF17m2g5324tqDgTENDS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37499 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3I0JoT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 05:44:19 -0400
In-Reply-To: <21061.20097.221946.197751@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--unkEvogRw9NlkiF17m2g5324tqDgTENDS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2013 11:23 AM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Santosh Shilimkar writes:
>> On Thursday 26 September 2013 11:54 AM, Russell King - ARM Linux wrote=
:
>>> On Thu, Sep 26, 2013 at 05:42:53PM +0200, Marc Kleine-Budde wrote:
>>>> On 09/26/2013 04:01 PM, Lothar Wa=C3=9Fmann wrote:
>>>>> Hi,
>>>>>
>>>>> when enabling the can interface with 'ifconfig can0 up' (after
>>>>> configuring the bitrate with canconfig) on an i.MX6Q board (TX6) I'=
m
>>>>> getting the following kernel dump:
>>>>>
>>>>> |flexcan 2094000.flexcan can0: writing ctrl=3D0x0a212003
>>>>> |flexcan 2094000.flexcan can0: flexcan_set_bittiming: mcr=3D0x59800=
00f ctrl=3D0x0a212003
>>>>> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing mcr=3D0x=
79a2020f
>>>>> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing ctrl=3D0=
x0a21ac53
>>>>> |Unhandled fault: imprecise external abort (0x1c06) at 0x00057adc
>>>>
>>>> Looks like a NULL pointer deref to me. But it doesn't make any sense=
,
>>>> because the offset is way beyond the length of the struct flexcan_re=
gs.
>>>
>>> NULL pointer derefs don't produce imprecise external aborts.  I belie=
ve
>>> that the FAR is unpredictable for such aborts as well, which means th=
e
>>> "at xxxx" should be ignored.
>>>
>> yep .. FAR is never reliable for imprecise external aborts.
>>
>>> Bearing in mind that it is imprecise, that means that the abort happe=
ned
>>> sometime in the past, so the PC isn't reliable either.
>>>
>>> The code here is:
>>>
>>>    0:	f57ff04e 	dsb	st
>>>    4:	e3a01000 	mov	r1, #0
>>>    8:	e5820000 	str	r0, [r2]
>>>    c:	f57ff04e 	dsb	st
>>>   10:	e5820004 	str	r0, [r2, #4]
>>>
>>> Given the dsbs there, it's probably the str r0, [r2] which provoked i=
t,
>>> and we can see from the register dump, r2 is not NULL.
>>>
>>> It's probably complaining that a clock necessary for the peripherals
>>> registers to be accessible is not running.
>>>
>> Not sure if it helps but almost 90% of the imprecise external aborts
>> cases I have seen on OMAP attributed to clock not being available
>> at the IP register accesses race conditions either at SW or
>> hardware(clock settling time). And rest of the 10 % majority falling
>> into interconnect synchronization issues.
>>
> I already checked this by enabling all clocks with devmem.
> If a clock would be missing I would expect all register wriites to
> fail not the register write to the _second_ mailbox (after the first
> mailbox has been successfully initialized).

They layout of the flexcan varies in the different imx chips. I'm
comparing the datasheets at the moment. As Russell pointed out the area
staring at offset 0x80 is by the reception FIFO engine.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--unkEvogRw9NlkiF17m2g5324tqDgTENDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJFU18ACgkQjTAFq1RaXHMeEwCgiuPWg9md7p+pZrrzxZlFGiUU
as4An32ZGkWxucT5bCfZbtcrfgtbhc3P
=0rVW
-----END PGP SIGNATURE-----

--unkEvogRw9NlkiF17m2g5324tqDgTENDS--
