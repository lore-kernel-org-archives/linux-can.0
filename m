From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 10:47:53 +0100
Message-ID: <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KGkq4HOK2SuupGwort0nimotfjCJV8ts9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48831 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752130AbdCMJsA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 05:48:00 -0400
In-Reply-To: <3972105.9n1vzaBFN5@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KGkq4HOK2SuupGwort0nimotfjCJV8ts9
Content-Type: multipart/mixed; boundary="UOXA3Qj8vWPML97QifxrAoCBVGR79hNIF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Stein <alexander.stein@systec-electronic.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org
Message-ID: <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
In-Reply-To: <3972105.9n1vzaBFN5@ws-stein>

--UOXA3Qj8vWPML97QifxrAoCBVGR79hNIF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 07:54 AM, Alexander Stein wrote:
>> @Marc: What was the reason to implement NAPI that days? Has it ever be=
en
>> proved that NAPI had a remarkable positive effect in opposite to a
>> direct CAN frame processing in the interrupt context?
>=20
> One reason to use NAPI is out-of-order issues on SMP systems :-( You kn=
ow the=20
> problem: http://marc.info/?l=3Dlinux-can&m=3D143642135416355&w=3D2
> If this is not resolved, things get even worse.
> Well, now that there is generic FIFO-offload feature (drivers may need =
changes=20
> to use it) there is an easy way to read CAN frames with low latency whi=
le=20
> processing them in non-IRQ context.
> IMHO reading CAN frames in softirq (NAPI) may be too late in some cases=
, in RT=20
> kernels this may be even worse.

ACK.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UOXA3Qj8vWPML97QifxrAoCBVGR79hNIF--

--KGkq4HOK2SuupGwort0nimotfjCJV8ts9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljGaskACgkQHv7KIOw4
HPYA9wgAiQt8O8RyTPY/eZEgCDMqqmvG/vidybn+mFpH22zNWDMhU5jb0QyKnmNL
WIp1jxdmHDSo4/dWEjKwlgRrvbNa4aAIgc5p85IYb+RMbGyFjRByfddqEQDngfR8
8/NDXjURoczO3CgOB81U9if/usQ/nNBcAyU59nT5BA9T4VEdYwhDw0rNDCNalgkz
TSuvwslTxO4Hvwcpg+RnE1ygiHBV6SGTrCc6BG2YmK1nv7mScYpXW63Yco+DtGPh
S99UjPPr1Hd7GZbbQ0YXi6rWnG40d6VtdvD7BICVYjFdcfhfos16ZgKtwuFYj/ac
vru+S0nwoza0502r20Zlk27a00Rcrg==
=T9od
-----END PGP SIGNATURE-----

--KGkq4HOK2SuupGwort0nimotfjCJV8ts9--
