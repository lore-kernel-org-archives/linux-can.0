From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Mon, 30 Sep 2013 13:39:25 +0200
Message-ID: <524962ED.9000605@pengutronix.de>
References: <21060.15934.600859.167074@ipc1.ka-ro> <524455FD.7070808@pengutronix.de> <20130926155422.GQ12758@n2100.arm.linux.org.uk> <CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com> <21061.21191.197931.54061@ipc1.ka-ro> <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com> <5245E2C5.1030705@pengutronix.de> <21065.23354.418805.871480@ipc1.ka-ro> <52495E24.4080703@pengutronix.de> <21065.25189.119250.773885@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aRvrmsfQJnQjlFaqtmCGtkSvQCImL3bwm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48802 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab3I3Ljn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2013 07:39:43 -0400
In-Reply-To: <21065.25189.119250.773885@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: Matt Sealey <neko@bakuhatsu.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aRvrmsfQJnQjlFaqtmCGtkSvQCImL3bwm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2013 01:37 PM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Marc Kleine-Budde writes:
>> On 09/30/2013 01:06 PM, Lothar Wa=C3=9Fmann wrote:
>>> Hi,
>>>
>>> Marc Kleine-Budde writes:
>>>> On 09/27/2013 07:24 PM, Matt Sealey wrote:
>>>>> Marc - I don't think FLEXCAN has changed layout at all in these are=
as.
>>>>> The hardware always worked this way..
>>>>
>>>> All flexcan cores support the RX FIFO, the mx6 supports an additiona=
l
>>>> mode for different acceptance filters.
>>>>
>>>>> The only difference here  is that the i.MX53 is doing something wei=
rd
>>>>> on the bus. The i.MX6Q is giving the absolutely correct BRESP for t=
he
>>>>> transfer to the peripheral (in effect, a "go away, this is my data"=

>>>>> failure, which the CPU turns into an imprecise abort since it no id=
ea
>>>>> which transaction it committed aeons ago caused it).
>>>>>
>>>>> Writes to 0x90 to 0xDF while MCR[FEN] is set *should* cause a data
>>>>> abort.. because it's not even a read-only region, it *should* be
>>>>> totally inaccessible to the CPU.
>>>>>
>>>>> The question I have is, when MCR[FEN] is set on i.MX53, does readin=
g
>>>>> from those reserved registers give anything but 0's or garbage? I'm=

>>>>> curious, that's all, it doesn't really matter ;)
>>>>
>>>> The driver only read from message buffer 0, and uses buffer 8 for tx=
=2E
>>>> The others are not accessed, unless in that chip start routine. We d=
on't
>>>> need this loop, it comes from the original driver. I think no one ha=
s
>>>> ever noticed that bug, because all other CPUs have not complained.
>>>>
>>>> The driver without the loop is working on mx6 and Lothar is testing =
it
>>>> on mx53.
>>>>
>>> I can confirm, that the driver still works on i.MX53 as before the
>>> patch.
>>> Is someone going to prepare a patch, or should I do it, as I was the
>>> one who first brought up this issue?
>>
>> I have a patch ready, it's basically what I send you. Can I add your
>> Tested-by?
>>
> Yes, of course.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--aRvrmsfQJnQjlFaqtmCGtkSvQCImL3bwm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJJYu0ACgkQjTAFq1RaXHM7HQCfcjIlJc+vIVM3MSpURMaV5cjE
XaoAoIAYmCqmC9H4nWbVLc4Y4fIrwc+6
=0H2y
-----END PGP SIGNATURE-----

--aRvrmsfQJnQjlFaqtmCGtkSvQCImL3bwm--
