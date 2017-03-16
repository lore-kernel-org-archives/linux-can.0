From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 11:11:57 +0100
Message-ID: <54435ee2-2eb8-8467-8cee-196153cb2229@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
 <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
 <28711d42-4fc8-4fd6-3e74-60116984885c@pengutronix.de>
 <c7299ea9-3651-1519-f067-2792fe02b63c@lipowsky.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oqg1HDBK8l9BxrKkvClH43Qj8QkSOHExc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34541 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbdCPKMF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 06:12:05 -0400
In-Reply-To: <c7299ea9-3651-1519-f067-2792fe02b63c@lipowsky.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Efim Monjak <emonjak@lipowsky.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oqg1HDBK8l9BxrKkvClH43Qj8QkSOHExc
Content-Type: multipart/mixed; boundary="TsPNaLGEJFmCHlPp0vV8tkcOmOskjLm64";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Efim Monjak <emonjak@lipowsky.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org
Message-ID: <54435ee2-2eb8-8467-8cee-196153cb2229@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
 <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
 <28711d42-4fc8-4fd6-3e74-60116984885c@pengutronix.de>
 <c7299ea9-3651-1519-f067-2792fe02b63c@lipowsky.de>
In-Reply-To: <c7299ea9-3651-1519-f067-2792fe02b63c@lipowsky.de>

--TsPNaLGEJFmCHlPp0vV8tkcOmOskjLm64
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 11:06 AM, Efim Monjak wrote:
>> NAPI is supposed to be activated once you get an interrupt. But the
>> actual read of the messages and putting it into the networking stack i=
s
>> done in NAPI, which comes after the IRQ.
>=20
> Yes using of napi contains both issues NAPI-too-late and IRQ-too-late.

Yes - but IRQ-too-late cannot be fixed or worked around in the driver.

>>>> Implementing rx-offload on the drivers passing skbs in the IRQ handl=
er
>>>> will probably fix the out-of-order issue.
>>> Were possible by rx-offload implementing make skbs no such memory
>>> wasting for CAN data?
>> I'm not sure if I understand your question correctly. In CAN you need
>> still one skb for each CAN frame.

> Yes an skb contains one CAN frame. As I have written early socket
> show me receive buffer is about 163000 bytes. After overflow 320 CAN
> frames are read from socket. I think receive buffer is full in this
> case. If no place in receive buffer is used for other proposes=20
> 163000bytes/320 skbs with CAN frames make about 500 bytes/skb. Linux
> show CAN MTU is 16 byte big. What I mean: need an skb about a half of
> kbyte to contain 16 bytes? Sure skbs are parts of list but do they
> need this all memory?

Yes - that's the overhead we accept for making use of the socket
infrastructure in linux. Feel free to dig into the possibilities of
aggregating several CAN frames into a single skb. On the ethernet side
they have things like GRO.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TsPNaLGEJFmCHlPp0vV8tkcOmOskjLm64--

--oqg1HDBK8l9BxrKkvClH43Qj8QkSOHExc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljKZO0ACgkQHv7KIOw4
HPZ0iAf+IC8Jj7gsIxQOeOmusYrvZnZ4TKyXynSJ1pgETWVHayGZcTNNQG+EhhMW
0GY+9WxZwpBO8ATlgMBYvCfaJZXMKrVve0340QWAbVPnQ+zLfvHxYRpl64efqEN8
k4eSvVMdXmctiAJgfFzBepCWyvf+koWnpF65GMzDyvHmlD/O9+zv+JaOUNsT1EPs
D76zqkzlJ/Fi+q5Ue92WdKSbmG1E/KBDDmGFW8meK8uJQvsZSpPa1LTrF2AoSjci
X+7+5gXaD8m49U8yQWfj0TDr24kbHph+iSqZ93Q7mdoQOroiBq+GMuW+jRl5n1A7
wSb6D3zdOFGMgvWwB7aO1+NmS2QvNw==
=y9NE
-----END PGP SIGNATURE-----

--oqg1HDBK8l9BxrKkvClH43Qj8QkSOHExc--
