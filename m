From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: flexcan: add hardware controller version support
Date: Wed, 27 Jun 2012 11:51:52 +0200
Message-ID: <4FEAD7B8.2000601@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <4FEAC3EF.3060606@pengutronix.de> <4FEACAAB.1000002@grandegger.com> <4FEAD5CF.9070601@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCED94AA78BE7E7A3441BFAD6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55494 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab2F0Jv7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 05:51:59 -0400
In-Reply-To: <4FEAD5CF.9070601@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Hui Wang <jason77.wang@gmail.com>, davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org, Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCED94AA78BE7E7A3441BFAD6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 11:43 AM, Wolfgang Grandegger wrote:
> Hi Marc,
>=20
> On 06/27/2012 10:56 AM, Wolfgang Grandegger wrote:
>> On 06/27/2012 10:27 AM, Marc Kleine-Budde wrote:
>>> On 06/27/2012 10:19 AM, Hui Wang wrote:
>>>> At least in the i.MX series, the flexcan contrller divides into ver_=
3
>>>> and ver_10, current driver is for ver_3 controller.
>>>>
>>>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>>>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.=

>>>> Its reset value is 0xffffffff, this means ID Filter Table must be
>>>> checked when receive a packet, but the driver is designed to accept
>>>> everything during the chip start, we need to clear this register to
>>>> follow this design.
>>>>
>>>> Add a hw_ver entry in the device tree, this can let us distinguish
>>>> which version the controller is, if we don't set value to this entry=
,
>>>> the hw_ver is 3 by default, this is backward compatible for existing=

>>>> platforms like powerpc and imx35.
>>>
>>> Is it possible to read this value from the hardware?
>>> Another possibility would be to introduce a new compatible device in =
the
>>> device tree.
>>
>> I vote for the latter. IIRC, in the past we already had some discussio=
n
>> on how to handle version dependent Flexcan hardware, e.g. by using
>> flexcan-vX.X or being expicit using fsl,p1010-flexcan. Search for "Add=

>> support for powerpc" in the netdev mailing list. I added the
>> devicetree-discuss ml for that reason.
>=20
> I looked up the threads and found:
>=20
>   http://marc.info/?w=3D4&r=3D1&s=3DFix+up+fsl-flexcan+device+tree+bi&q=
=3Dt
>=20
> In the Flexcan driver we currently only have:
>=20
>   static struct of_device_id flexcan_of_match[] =3D {
>         {
>                 .compatible =3D "fsl,p1010-flexcan",
>         },
>         {},
>   };
>=20
> What compatible string do they actually use for the i.MX6Q board? Shawn=

> or Hui? We need to fix that. From the discussion mentioned above I thin=
k
> "fsl,flexcan-v10" would be acceptable. Unfortunately, we do not known

As far as I understand the DT, the name should be something like

"fsl,${OLDEST_SOCK_THAT_HAS_THIS_VERSION_OF_FLEXCAN}-flexcan".

> the internal version of the Flexcan controllers used in the various
> PowerPC and ARM SOCs. We already realized some differences with
> interrupts and bus error handling between i.MX28 and i.MX35. Would be
> nice if someone (from Freescale?) could finally clarify that.

That information would be interesting.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCED94AA78BE7E7A3441BFAD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/q17gACgkQjTAFq1RaXHPLlwCcDHK7bdq9mUd84lDjtSGjEd8F
ghcAnR3uzQyBu5a1xyFYhiYGLaxLRzui
=kOL5
-----END PGP SIGNATURE-----

--------------enigCED94AA78BE7E7A3441BFAD6--
