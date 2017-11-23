From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] Documentation : can : flexcan : Add big-endian
 property to device tree
Date: Thu, 23 Nov 2017 11:02:15 +0100
Message-ID: <f859951e-072f-499b-5e86-1aaeb789a549@pengutronix.de>
References: <1511430935-29783-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ogscwt4nAg39k395woW8ksMklEbQdvISA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511430935-29783-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ogscwt4nAg39k395woW8ksMklEbQdvISA
Content-Type: multipart/mixed; boundary="DdJV9KshpldM8fpdIvgMdOWkS8ErwTXBG";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org,
 linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org
Message-ID: <f859951e-072f-499b-5e86-1aaeb789a549-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] Documentation : can : flexcan : Add big-endian
 property to device tree
References: <1511430935-29783-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
In-Reply-To: <1511430935-29783-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>

--DdJV9KshpldM8fpdIvgMdOWkS8ErwTXBG
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 10:55 AM, Pankaj Bansal wrote:
> The FlexCAN controller can be modelled as little or big endian dependin=
g
> on SOC design. This device tree property identifies the controller
> endianness and the driver reads/writes controller registers based on
> that.
>=20
> This is optional property. i.e. if this property is not present in
> device tree node then controller is assumed to be little endian. if thi=
s
> property is present then controller is assumed to be big endian.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>

Please document the default behaviour in the bindings if the big-endian
property is missing.

This and the other series have to be applied in the correct order,
otherwise you break bisectability when removing the "fsl,p1010-flexcan"
from the mx{25,35,53} devicetree before adding the compatible to the
driver. Maybe merge these two series?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DdJV9KshpldM8fpdIvgMdOWkS8ErwTXBG--

--Ogscwt4nAg39k395woW8ksMklEbQdvISA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloWnKcACgkQHv7KIOw4
HPa3vggAv0Wxn+wQQBbFfgZvDICa6Mi/HdeRjbTXr+BMsXKcXFLPFTqSTB96m38J
ZYac5gU5LuN6Ae3JdLX22kNEl4aF4fbFRqkb5xrzIIaUqr8wfOKUoIETD4F+iW9n
CjWV7UFv4Tl1VqhNVLVezWikXK14ZKkYGDNzbxm07hOhs24/YsbwypJx+vnyyPvN
8R7sYGQ3VjMoO6gnseLu0ToGfge+A1xGIOoENFokvOgn9FsUDIFnZu1o+caGd//e
DBYs5ul5bw82AyLHmHL64hNLik8hktTFi+G558j/fWdlsJPa6XU+lV9IKkPNVS5Z
WAfJ/Q53L9/DfWbZCeobWUvgGWvwWA==
=1rFh
-----END PGP SIGNATURE-----

--Ogscwt4nAg39k395woW8ksMklEbQdvISA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
