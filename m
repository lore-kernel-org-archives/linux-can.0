From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 16:12:45 +0100
Message-ID: <50B629ED.40507@pengutronix.de>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com> <50B61E1B.8040904@rosetechnology.dk> <50B61FE4.5090905@pengutronix.de> <50B62947.4090300@rosetechnology.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9E4AD70A62BEF12A3F66B678"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47548 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301Ab2K1PMs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:12:48 -0500
In-Reply-To: <50B62947.4090300@rosetechnology.dk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E4AD70A62BEF12A3F66B678
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/28/2012 04:09 PM, Henrik Bork Steffensen wrote:
> On 11/28/2012 03:29 PM, Marc Kleine-Budde wrote:
>> On 11/28/2012 03:22 PM, Henrik Bork Steffensen wrote:
>>> On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
>>>> On 11/27/2012 03:11 PM, Henrik Bork Steffensen wrote:
>>>> Hm, could you show your diffs.
>>> Do You mean a diff on these 7 lines, or a diff to the original file?
>>>
>>>>> I this case "at91_poll" is basicly the same as "c_can_poll", in bot=
h
>>>>> cases they call the function with the spinlock in the rx chain.
>>>> You don't need to protect against RX. Sorry, forgot that. On the c_c=
an
>>>> this is necessary due to concurrent accesses to the same message RAM=
=2E
>>> Ok, I think that at91_can.c might have an issue in register access.
>>> I am not sure, but I will look into it.
>>>
>>>>> Looking at the patch Wolfgang sugested, I became uncertain of what
>>>>> this
>>>>> patch actually wants to protect.
>>>>> Is it the registers in the cpu can interface? (mailboxes and contro=
l
>>>>> regs, i don't know the hw)
>>>> As mentioned above, on the c_can there is definitely a race with the=

>>>> message ram due to the busy wait after accessing it. See:
>>>>
>>>>   =20
>>>> http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237=

>>>>
>>>>> Or is it the potential race between "c_can_start_xmit" and
>>>>> "c_can_do_tx" ?
>>>>> Or even the access to the net api?
>>>>>
>>>>> Would someone care to explain?
>>>> I will try. In at91_start_xmit, if we get interrupted
>>>>
>>>>      if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv)))&
>>>>                 AT91_MSR_MRDY) ||
>>>>                (priv->tx_next&   get_next_mask(priv)) =3D=3D 0)
>>>>
>>>>          /* HERE */
>>>>
>>>>          netif_stop_queue(dev);
>>>>
>>>> and then at91_irq_tx() is called executing netif_wake_queue() we may=

>>>> end
>>>> up with a stopped tx queue. But I'm not yet 100% sure.
>>> Ok, thanks a lot.
>>>
>>> In my case i changed the driver to only use one mailbox for
>>> transmission.
>>> Which means that the "net_stop_queue" will be called every time a pac=
ket
>>> is tx'ed.
>>> And the "net_wake_queue" will be called after the packet is actually
>>> transmitted.
>> In your first mail you've written that using only one mailbox increase=
s
>> the probability for a lockup.
>>
>>> This is as far as i can see this is 100% safe, provided that no furth=
er
>>> "ndo_start_xmit"
>>> calls come before the wake_queue call.
>>>
>>>
>>> Anyway, after removing the spin_lock from rx, it loads fine and seems=
 to
>>> work.
>>> I will do a test with the suggested changes to the tx chain and get t=
o
>>> the list
>>> if anything interesting appears.
>>>
>>> Thank You very much for Your help so far :-)
>> Can you send me a diff of your current changes?
>=20
> Hi,
>=20
> Please note that i have not yet tested it for lockup.
> So far i just did a simple rx/tx test.

How many TX mailboxes are you using? According to your patch, the number
is unchanged.

> Patch attached.
> Expect large offsets in line numbers.
>=20
> I have a few other small changes to at91_can.c which might be interesti=
ng.
> I will get back with them, after checking them against a recent kernel
> version.

Cool, I'm looking forward to see them.

tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9E4AD70A62BEF12A3F66B678
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC2Ke0ACgkQjTAFq1RaXHPGLACdFE0hvk7HrFrIj+wngkB7U6E9
bVgAoIlpxDICuDYSF+FE9NMZbpNKBEFc
=Skdt
-----END PGP SIGNATURE-----

--------------enig9E4AD70A62BEF12A3F66B678--
