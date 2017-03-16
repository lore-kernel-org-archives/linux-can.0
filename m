From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 09:34:38 +0100
Message-ID: <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s7HxWhQrI24AOCIn6aKwMpJptCFGTMIMB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49387 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751104AbdCPIer (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 04:34:47 -0400
In-Reply-To: <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s7HxWhQrI24AOCIn6aKwMpJptCFGTMIMB
Content-Type: multipart/mixed; boundary="vkwIAjwbHjvmkbdUtnKxiCsXFOeoEn7Ic";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org
Message-ID: <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
In-Reply-To: <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>

--vkwIAjwbHjvmkbdUtnKxiCsXFOeoEn7Ic
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 09:01 AM, Oliver Hartkopp wrote:
> On 13.03.2017 10:47, Marc Kleine-Budde wrote:
>> On 03/13/2017 07:54 AM, Alexander Stein wrote:
>>>> @Marc: What was the reason to implement NAPI that days? Has it ever =
been
>>>> proved that NAPI had a remarkable positive effect in opposite to a
>>>> direct CAN frame processing in the interrupt context?
>>>
>>> One reason to use NAPI is out-of-order issues on SMP systems :-( You =
know the
>>> problem: http://marc.info/?l=3Dlinux-can&m=3D143642135416355&w=3D2
>>> If this is not resolved, things get even worse.
>>> Well, now that there is generic FIFO-offload feature (drivers may nee=
d changes
>>> to use it) there is an easy way to read CAN frames with low latency w=
hile
>>> processing them in non-IRQ context.
>>> IMHO reading CAN frames in softirq (NAPI) may be too late in some cas=
es, in RT
>>> kernels this may be even worse.
>>
>> ACK.
>=20
> Would then implementing CAN rx-offload on all(!) CAN drivers fix the=20
> NAPI-too-late and the out-of-order issue?

Implementing rx-offload on the drivers using NAPI, will fix the
NAPI-too-late issue (and turn it into a IRQ too late issue).

Implementing rx-offload on the drivers passing skbs in the IRQ handler
will probably fix the out-of-order issue.

I'm not sure if the USB and SPI drivers are affected by the out-of-order
issue.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vkwIAjwbHjvmkbdUtnKxiCsXFOeoEn7Ic--

--s7HxWhQrI24AOCIn6aKwMpJptCFGTMIMB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljKTh4ACgkQHv7KIOw4
HPboGgf9ECQYSNQpLuZLbFZstw5uQFJ+hOexLSw2n5mWBhV7H/7qZjRcohIzKEpG
AbxNuU4Fx3dEhUXLjpsoS+zioVf9RV9nWGh2V907cgrrVBtKw0c3vN8kSC+Dxfwl
RpRpDq0dcLj5xeaFHx4nQy9ye3/zNzuMda4ulRUZAglTX1C4Gnl8LzT4IbHULK4A
UCEkjqfV+kjdGbYPk9b3vOGiLzRRhSxc1YUzo7+bYK7BAEPf6FnUas95WBnPPUYH
/5JyMiSyvZ3gwQqjcew00XhkTiJ4cXmipAmQnGYeOjenhk3sxfSLUNtIwxM/Mdht
l6W9qH4M6Yd0zTurzLCUTa057fyvhg==
=qj/+
-----END PGP SIGNATURE-----

--s7HxWhQrI24AOCIn6aKwMpJptCFGTMIMB--
