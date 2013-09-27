From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 21:55:49 +0200
Message-ID: <5245E2C5.1030705@pengutronix.de>
References: <21060.15934.600859.167074@ipc1.ka-ro> <524455FD.7070808@pengutronix.de> <20130926155422.GQ12758@n2100.arm.linux.org.uk> <CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com> <21061.21191.197931.54061@ipc1.ka-ro> <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uIPdoN7hFhAnApHk02xOwErp40PHrkJ84"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53048 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3I0T4H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 15:56:07 -0400
In-Reply-To: <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matt Sealey <neko@bakuhatsu.net>
Cc: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uIPdoN7hFhAnApHk02xOwErp40PHrkJ84
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2013 07:24 PM, Matt Sealey wrote:
> On Fri, Sep 27, 2013 at 4:41 AM, Lothar Wa=C3=9Fmann <LW@karo-electroni=
cs.de> wrote:
>>> If r2 is indeed the address of the access, then this is entirely down=

>>> to a misuse of the hardware; from the manual:
>>>
>>> ~
>>> When the FEN bit is set in the MCR, the memory area from 0x80 to 0xFF=
 (which is
>>> normally occupied by MB0 to MB7) is used by the reception FIFO engine=
=2E
>>> Table 34-6
>>> shows the Rx FIFO data structure. The region 0x80-0x8F contains an
>>> message buffer
>>
>> What manual are you referring to? In my "i.MX 6Dual/6Quad Applications=

>> Processor Reference Manual, Rev. 1, 04/2013" flexcan is chapter 26 and=

>> Table 34-6 is: Single-Ended Source Termination Resistance Settings
>> of the HDMI interface.
>=20
> Actually that was from the i.MX53 manual.. it's table 26-7 in the MX6
> manual and the description is different, but the hardware operation is
> *identical*.

Yes, mx25, mx35, mx53 and mx28 seem to be identical when it comes to the
message buffers. The flexcan on mx6 has an additional acceptance filter
functionality.

>>> I'm surprised this ever worked.. if the area 0x90-0xDF is being used
>>> by the FIFO internally then the difference between i.MX53 ('working')=

>>> and i.MX6Q ('imprecise abort') is that the i.MX6Q is causing the
>>> proper bus response. We can only hope that the i.MX53 is ONLY not
>>> causing the proper bus response and not actually letting you write
>>> into a FIFO internal data area..
>>
>> This seems a plausible explanation.
>>
>> The definition:
>> |struct flexcan_mb {
>> |       u32 can_ctrl;
>> |       u32 can_id;
>> |       u32 data[2];
>> |};
>> |
>> |/* Structure of the hardware registers */
>> |struct flexcan_regs {
>> |       u32 mcr;                /* 0x00 */
>> [...]
>> |       struct flexcan_mb cantxfg[64];
>> |                                 ^^
>> has obviously nothing to do with reality!
>=20
> It does, as you found later, reflect reality as it is where the
> message buffers 0-5 go when the FIFO is disabled. After that there are
> filter registers.. some unions or egregious casting is required, but
> the structure is semi-correct.
>=20
> This is defined in the i.MX6Q manual at least in section 26.4:
>=20
> ~~~
> 26.4 Message Buffer Structure
> Message Buffer Address: Base + 0x0080-0x047C
> ~~~
>=20
> But when FEN is set, this is internal FIFO data after entry 0, as
> defined in section 26.5:
>=20
> ~~~
> 26.5 Rx FIFO Structure
> When the MCR[RFEN] bit is set, the memory area from $80 to $DC (which
> is normally
> occupied by MBs 0 to 5) is used by the reception FIFO engine.
>=20
> The region 0x80-0x8C contains the output of the FIFO which must be
> read by the CPU as
> a Message Buffer. This output contains the oldest message received and
> not read yet. The
> region 0x90-0xDC is reserved for internal use of the FIFO engine.
> ~~~
>=20
> Marc - I don't think FLEXCAN has changed layout at all in these areas.
> The hardware always worked this way..

All flexcan cores support the RX FIFO, the mx6 supports an additional
mode for different acceptance filters.

> The only difference here  is that the i.MX53 is doing something weird
> on the bus. The i.MX6Q is giving the absolutely correct BRESP for the
> transfer to the peripheral (in effect, a "go away, this is my data"
> failure, which the CPU turns into an imprecise abort since it no idea
> which transaction it committed aeons ago caused it).
>=20
> Writes to 0x90 to 0xDF while MCR[FEN] is set *should* cause a data
> abort.. because it's not even a read-only region, it *should* be
> totally inaccessible to the CPU.
>=20
> The question I have is, when MCR[FEN] is set on i.MX53, does reading
> from those reserved registers give anything but 0's or garbage? I'm
> curious, that's all, it doesn't really matter ;)

The driver only read from message buffer 0, and uses buffer 8 for tx.
The others are not accessed, unless in that chip start routine. We don't
need this loop, it comes from the original driver. I think no one has
ever noticed that bug, because all other CPUs have not complained.

The driver without the loop is working on mx6 and Lothar is testing it
on mx53.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uIPdoN7hFhAnApHk02xOwErp40PHrkJ84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJF4sUACgkQjTAFq1RaXHMuAACgl01PNap8zGnt2zUQQcaAFaK8
aJkAniSAOZI7N0RdZr+UafxNzcqcVeaL
=eDIC
-----END PGP SIGNATURE-----

--uIPdoN7hFhAnApHk02xOwErp40PHrkJ84--
