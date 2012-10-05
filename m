From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable
 and compilable on SPARC
Date: Fri, 05 Oct 2012 11:19:55 +0200
Message-ID: <506EA63B.1060109@pengutronix.de>
References: <506D9266.6010707@gaisler.com> <1349359150-18012-1-git-send-email-andreas@gaisler.com> <506DA06D.3070003@pengutronix.de> <506DA769.6090000@pengutronix.de> <506EA200.1040500@gaisler.com> <506EA2F3.2080609@pengutronix.de> <506EA57A.3020002@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB15517B01D700608D74BD10F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43552 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab2JEJUE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 05:20:04 -0400
In-Reply-To: <506EA57A.3020002@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB15517B01D700608D74BD10F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/05/2012 11:16 AM, Andreas Larsson wrote:
> On 10/05/2012 11:05 AM, Marc Kleine-Budde wrote:
>> On 10/05/2012 11:01 AM, Andreas Larsson wrote:
>>> On 10/04/2012 05:12 PM, Marc Kleine-Budde wrote:
>>>> On 10/04/2012 04:42 PM, Marc Kleine-Budde wrote:
>>>>> On 10/04/2012 03:59 PM, Andreas Larsson wrote:
>>>>>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>>>>>
>>>>> Looks better. However on sparc and sparc64, I'm seeing this warning=
=2E
>>>>>   From my point of view a false positive.
>>>>>
>>>>>> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function
>>>>>> 'sja1000_ofp_remove':
>>>>>> linux/include/linux/ioport.h:165:18: warning: 'res.end' is used
>>>>>> uninitialized in this function [-Wuninitialized]
>>>>>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note:
>>>>>> 'res.end' was declared here
>>>>>> linux/include/linux/ioport.h:165:2: warning: 'res.start' is used
>>>>>> uninitialized in this function [-Wuninitialized]
>>>>>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note:
>>>>>> 'res.start' was declared here
>>>>
>>>> Looking at the preprocessed code, the compiler is right:
>>>>
>>>>> # 30
>>>>> "/home/frogger/pengutronix/socketcan/linux/include/linux/of_address=
=2Eh"
>>>>> static inline __attribute__((always_inline))
>>>>> __attribute__((no_instrument_function)) int
>>>>> of_address_to_resource(struct device_node *dev, int index,
>>>>>         struct resource *r)
>>>>> {
>>>>>    return -22;
>>>>> }
>>>>
>>>> http://lxr.free-electrons.com/source/include/linux/of_address.h#L29
>>>>
>>>> Why is CONFIG_OF_ADDRESS not set in my .config?
>>>
>>> In drivers/of/Kconfig, OF_ADDRESS depends on !SPARC as sparc handles =
a
>>> bunch of open firmware things differently. There is a sparc-specific
>>> implementations of of_address_to_resource.
>>>
>>> I'll send in a patch changing of_address.h so that
>>> of_address_to_resource gets declared extern for sparc instead of an
>>> empty inline function. That should solve the problem as far as I see =
it.
>>>
>>> There is a similar thing with CONFIG_OF_IRQ, of_irq.h and
>>> irq_of_parse_and_map, but there irq_of_parse_and_map is declared outs=
ide
>>> of #ifdef CONFIG_OF_IRQ because of the sparc specific implementation.=

>>
>> I've noticed that, too. With the patch you posted the driver cannot
>> work, as the header files provide just no-ops of the of functions.
>> Please test your patch before posting :).
>=20
> My test branch is pre commit a850a7554442f08d3e910c6eeb4ee216868dda1e
> that introduced the empty functions and the dependency on
> CONFIG_OF_ADDRESS in of_address.h. So there everything worked fine.

But that commit is aka v3.4-rc1~172^2~18, which means it was included in
v3.4 and this is way old.

> Makes it clear that it is time to rebase the set of external patches
> that I need to run my hardware.

Sounds like a plan.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB15517B01D700608D74BD10F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBupjsACgkQjTAFq1RaXHPXJQCgjxrsaCGTYHwwaY/L7HYNNIVe
MVIAoIu1evHBSv1E5HkS2Put4dxE3vGn
=2t9S
-----END PGP SIGNATURE-----

--------------enigB15517B01D700608D74BD10F--
