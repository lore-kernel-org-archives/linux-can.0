From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
Date: Fri, 10 Nov 2017 13:49:03 +0100
Message-ID: <b27d6e14-c6d7-5c4b-0588-093684cbe57b@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <a08c34d0-5870-b4b3-f68d-3db33ba3e950@pengutronix.de>
 <AM0PR0402MB3940A39D32C4725DE1B8C426F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <e87441cc-3848-1125-f4f0-02f1a630c36b@pengutronix.de>
 <AM0PR0402MB394051B0FAADBC45AF71439CF1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MtuB2lslQog7bgVIes5Xksjfb40xe2nPO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM0PR0402MB394051B0FAADBC45AF71439CF1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MtuB2lslQog7bgVIes5Xksjfb40xe2nPO
Content-Type: multipart/mixed; boundary="4j6Oox4wBteJt5QElS7qQrbGGuRNbRo9f";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>,
 "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
 "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>,
 "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <b27d6e14-c6d7-5c4b-0588-093684cbe57b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
 <a08c34d0-5870-b4b3-f68d-3db33ba3e950-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <AM0PR0402MB3940A39D32C4725DE1B8C426F1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
 <e87441cc-3848-1125-f4f0-02f1a630c36b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <AM0PR0402MB394051B0FAADBC45AF71439CF1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
In-Reply-To: <AM0PR0402MB394051B0FAADBC45AF71439CF1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>

--4j6Oox4wBteJt5QElS7qQrbGGuRNbRo9f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 01:35 PM, Pankaj Bansal wrote:
>>> 3. Regarding backward compatibility with PowerPC, I see that there is=
 only one platform in PowerPC architecture that is using flexcan.
>>>     There is only one platform in "arch/powerpc/boot/dts/" having fle=
xcan node. p1010si-post.dtsi
>>>     I have added the big-endian property in that platform and have te=
sted it on P1010 platform after backporting the patch to Freescale SDK 1.=
4 linux.
>>>     I have sent the patch for this. See "[PATCH 2/3] powerpc: dts: P1=
010: Add endianness property to flexcan node"
>>>     I believe these changes can be accepted for both powerpc and arm =
and other architectures that use flexcan.
>>
>> No, this is not acceptable. You break the device tree. Please add the =
le, be information to the devtype data.
>=20
> I don't understand how this breaks device tree? can you please elaborat=
e? This method is already being used in other specifications.

Boot a new kernel with an old tree on a PPC board -> flexcan will not wor=
k.

See this talk for more information for stable device tree ABI:

https://elinux.org/images/0/0e/OSELAS.Presentation-ELCE2017-DT.pdf
https://www.youtube.com/watch?v=3D6iguKSJJfxo

> You can refer "Documentation/devicetree/bindings/usb/usb-ehci.txt" or
> "Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt" Or
> "Documentation/devicetree/bindings/regmap/regmap.txt".

> In my opinion, keeping this info in devtype data is not good idea.
> E.g. say two platforms which have same FlexCAN hardware revision,
> will have same quirks. BUT these two platforms implement FlexCAN in
> le and be fashion respectively.

Then it's two different platforms. Simply add another compatible to the
driver.

> With current FlexCAN driver, these two platforms can have same
> devtype data. And we need not to change flexcan.c if we want to add
> support for a second platform. We can just add device tree for that
> platform (which would be needed anyway), and it can work. We can
> mention endianness in device tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4j6Oox4wBteJt5QElS7qQrbGGuRNbRo9f--

--MtuB2lslQog7bgVIes5Xksjfb40xe2nPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFoD8ACgkQHv7KIOw4
HPZHVAgAzLGJjRBYnAjvdifqbLrqGJLhLRLk37BL+Dw1HO7MhgOjNVoMoqFtc8TC
ceNQlcDJgOX5fAANVH72IY3O1WGq0P1yiXOCPp1Bq3eyC9S5xvoiSRuFDMg2FPIM
5lXKMRFW558+4h8aVPiw1o58LIV8c/vEoVCBHrpkHVP92NAcFzCpIQtgBa74YPOh
Mja5GwHaLQNbFFW8DoxXJs/jcHBCopd7KjgyBZExqnwtr9KFFRMRx42jVTrb3I3N
3E+T7QgCe7H4rQxTC6qu9nl4kGa1SsOEmXuZOH0X4svqHNyMm3WHYeY+eg+6wewt
YgBtOlB6v3SiAv6WtAQhwdFcJmKpYg==
=iS1I
-----END PGP SIGNATURE-----

--MtuB2lslQog7bgVIes5Xksjfb40xe2nPO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
