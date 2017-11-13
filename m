From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
Date: Mon, 13 Nov 2017 16:50:34 +0100
Message-ID: <15d6c00e-293d-1350-b955-d24b9d189a06@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <a08c34d0-5870-b4b3-f68d-3db33ba3e950@pengutronix.de>
 <AM0PR0402MB3940A39D32C4725DE1B8C426F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <e87441cc-3848-1125-f4f0-02f1a630c36b@pengutronix.de>
 <AM0PR0402MB394051B0FAADBC45AF71439CF1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <b27d6e14-c6d7-5c4b-0588-093684cbe57b@pengutronix.de>
 <AM0PR0402MB3940DE05B2BA456D0FF54498F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BfXfQhBhtOWaaghdVm0DIttkVe0bKxged"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM0PR0402MB3940DE05B2BA456D0FF54498F1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BfXfQhBhtOWaaghdVm0DIttkVe0bKxged
Content-Type: multipart/mixed; boundary="nuvxENl8BatJgh6FwQS1B8mkaSNKuhVFm";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>,
 "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
 "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>,
 "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <15d6c00e-293d-1350-b955-d24b9d189a06-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
 <a08c34d0-5870-b4b3-f68d-3db33ba3e950-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <AM0PR0402MB3940A39D32C4725DE1B8C426F1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
 <e87441cc-3848-1125-f4f0-02f1a630c36b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <AM0PR0402MB394051B0FAADBC45AF71439CF1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
 <b27d6e14-c6d7-5c4b-0588-093684cbe57b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <AM0PR0402MB3940DE05B2BA456D0FF54498F1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
In-Reply-To: <AM0PR0402MB3940DE05B2BA456D0FF54498F1540-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>

--nuvxENl8BatJgh6FwQS1B8mkaSNKuhVFm
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 05:32 PM, Pankaj Bansal wrote:
> Thanks for sharing the video and slides. It was really helpful. But I
> would still like to solve this problem using device tree property. My
> rationale behind it is that, if a platform designer uses same IP
> block whose support is present is linux kernel, but with different
> endianness. Then he would not need to add his platform data in each
> driver to support his platform in linux. He can just add endianness
> property in device tree and can use latest linux kernel right off the
> bat. This is also mentioned in
> "Documentation/devicetree/bindings/regmap/regmap.txt".
>=20
> Regmap defaults to little-endian register access on MMIO based
> devices, this is by far the most common setting. On CPU
> architectures that typically run big-endian operating systems
> (e.g. PowerPC), registers can be defined as big-endian and must
> be marked that way in the devicetree.
>=20
> This rule was apparently not followed in P1010RDB flexcan node.
>=20
> To solve this problem, I suggest that we define 2 optional device
> tree properties for flexcan. little-endian : for powerpc
> architecture, if this property is defined then controller is little
> endian otherwise big endian (default) big-endian : for other
> architectures, if this property is defined then controller is big
> endian otherwise little endian (default)
>=20
> Although the controller drivers should be architecture independent,
> but apparently there is no way around it in flexcan.

Please keep the endianess as default es stated in the comment in the driv=
er:

>> /* Abstract off the read/write for arm versus ppc. This
>>  * assumes that PPC uses big-endian registers and everything
>>  * else uses little-endian registers, independent of CPU
>>  * endianness.
>>  */

See description of commit 0e4b949e6620 ("can: flexcan: fix flexcan
driver build for big endian on ARM and little endian on PowerPc") for
more information.

I'll not ACK a change in the driver, that's breaking PPC.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nuvxENl8BatJgh6FwQS1B8mkaSNKuhVFm--

--BfXfQhBhtOWaaghdVm0DIttkVe0bKxged
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloJv0oACgkQHv7KIOw4
HPYqqQgAiVAmfp1P4EMMOkqoZ4OmFhvPCcFsKVUWVhcDUSGSLX6/be82r7tJYrYh
enLTw5cBbu+VcCewLIwi0zyk12kx0cvpJ+9b7Vuv5vFrwCCCj3kAXiEG1IjgfI10
OGtvTkBbNTjCljXmrHqVLeQBfH+jV7Xs13j7v8sFtM7jX4nvQMC3TLB3apInc2Kt
vxm1Rb+m9cayTktzuYznK1gtRW02nuP0m76TdDkpl7M3OmT1jpOKBAf/3w88iY74
THqXOETZW287LCVpsNYQdR3JtqOyJmSb3dRhyBqnOTMWjaQZyid83oqqw7IAQGa0
FdQtDNuKCgTCePWT7zxMaiXskH3FzQ==
=j9+a
-----END PGP SIGNATURE-----

--BfXfQhBhtOWaaghdVm0DIttkVe0bKxged--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
