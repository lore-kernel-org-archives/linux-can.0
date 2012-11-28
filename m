From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 15:29:56 +0100
Message-ID: <50B61FE4.5090905@pengutronix.de>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com> <50B61E1B.8040904@rosetechnology.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAF0F357C3884D0B0A7B2095"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45619 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab2K1OaD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 09:30:03 -0500
In-Reply-To: <50B61E1B.8040904@rosetechnology.dk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAF0F357C3884D0B0A7B2095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/28/2012 03:22 PM, Henrik Bork Steffensen wrote:
> On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
>> On 11/27/2012 03:11 PM, Henrik Bork Steffensen wrote:
>> Hm, could you show your diffs.
> Do You mean a diff on these 7 lines, or a diff to the original file?
>=20
>>> I this case "at91_poll" is basicly the same as "c_can_poll", in both
>>> cases they call the function with the spinlock in the rx chain.
>> You don't need to protect against RX. Sorry, forgot that. On the c_can=

>> this is necessary due to concurrent accesses to the same message RAM.
> Ok, I think that at91_can.c might have an issue in register access.
> I am not sure, but I will look into it.
>=20
>>
>>> Looking at the patch Wolfgang sugested, I became uncertain of what th=
is
>>> patch actually wants to protect.
>>> Is it the registers in the cpu can interface? (mailboxes and control
>>> regs, i don't know the hw)
>> As mentioned above, on the c_can there is definitely a race with the
>> message ram due to the busy wait after accessing it. See:
>>
>>    http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L23=
7
>>
>>> Or is it the potential race between "c_can_start_xmit" and
>>> "c_can_do_tx" ?
>>> Or even the access to the net api?
>>>
>>> Would someone care to explain?
>> I will try. In at91_start_xmit, if we get interrupted
>>
>>     if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv)))&
>>                AT91_MSR_MRDY) ||
>>               (priv->tx_next&  get_next_mask(priv)) =3D=3D 0)
>>
>>         /* HERE */
>>
>>         netif_stop_queue(dev);
>>
>> and then at91_irq_tx() is called executing netif_wake_queue() we may e=
nd
>> up with a stopped tx queue. But I'm not yet 100% sure.
> Ok, thanks a lot.
>=20
> In my case i changed the driver to only use one mailbox for transmissio=
n.
> Which means that the "net_stop_queue" will be called every time a packe=
t
> is tx'ed.
> And the "net_wake_queue" will be called after the packet is actually
> transmitted.

In your first mail you've written that using only one mailbox increases
the probability for a lockup.

> This is as far as i can see this is 100% safe, provided that no further=

> "ndo_start_xmit"
> calls come before the wake_queue call.
>=20
>=20
> Anyway, after removing the spin_lock from rx, it loads fine and seems t=
o
> work.
> I will do a test with the suggested changes to the tx chain and get to
> the list
> if anything interesting appears.
>=20
> Thank You very much for Your help so far :-)

Can you send me a diff of your current changes?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCAF0F357C3884D0B0A7B2095
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC2H+gACgkQjTAFq1RaXHPyBACeKal3+53dyo+PbL1TfuDuNSGd
FdgAn0CcG77ry5qVgnlwIB5z0wGgkLVM
=4M5Q
-----END PGP SIGNATURE-----

--------------enigCAF0F357C3884D0B0A7B2095--
