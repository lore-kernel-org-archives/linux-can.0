From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: introduce CANFD_FDF flag for mixed content in struct
 canfd_frame
Date: Fri, 14 Apr 2017 15:04:06 +0200
Message-ID: <be5e8910-a98f-51a8-3c2a-8fd61e676025@pengutronix.de>
References: <20170411134343.3089-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uEfBlUids2SPOwch4KCTnQJ66S5wDgn4M"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41147 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751698AbdDNNEN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 09:04:13 -0400
In-Reply-To: <20170411134343.3089-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uEfBlUids2SPOwch4KCTnQJ66S5wDgn4M
Content-Type: multipart/mixed; boundary="3m66BqmbDMmfspRj2BAM4nmxNkQ5iCMRR";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <be5e8910-a98f-51a8-3c2a-8fd61e676025@pengutronix.de>
Subject: Re: [PATCH] can: introduce CANFD_FDF flag for mixed content in struct
 canfd_frame
References: <20170411134343.3089-1-socketcan@hartkopp.net>
In-Reply-To: <20170411134343.3089-1-socketcan@hartkopp.net>

--3m66BqmbDMmfspRj2BAM4nmxNkQ5iCMRR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 03:43 PM, Oliver Hartkopp wrote:
> The struct can_frame and struct canfd_frame intentionaly share the same=

> layout to be able to write CAN frame content into a CAN FD frame struct=
ure.
> When this is done the former differentiation via CAN_MTU / CANFD_MTU ge=
ts
> lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of=

> using struct canfd_frame for mixed CAN / CAN FD content (dual use).
> N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside o=
f
> struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux=
=2E

Sorry, I don't get the usecase. Who will evaluate this bit? The
userspace, when using vcan? What does it mean, when this bit is set?
That we have a CAN frame within a struct canfd_frame?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3m66BqmbDMmfspRj2BAM4nmxNkQ5iCMRR--

--uEfBlUids2SPOwch4KCTnQJ66S5wDgn4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljwyMYACgkQHv7KIOw4
HPYv5gf+P/mUdwaHXYeZpyANcguwRzrhq1rWIuutj5Rsze9rMz08/jdVm4oIi8gL
5K4T7wlyx3Jrh3wl0UqCHv9HlYjq51JYM1yyaN4wswOdT4qhGndxn7bU06f02akK
QJMI0SWpr7wc0EFe/mJ9dzZ+lcxu/1zpO/O5qIayXUn8sgu//myFzEhRVTw41CmW
Pje6PBx1ZYbxGrFSOUM+m1WNUp0ZyaFIaRIMesOXZ545Qt+wFU4Z4oz5iRJxQb1R
9nbxqVyAaCpBsx1hnXgRzfDaBmfqmbfgBL3E9lcHJhgzwsaHfMHFxD0l4pQoBDJt
Mr10db3u/8Pf9VUclVCvOa8zTTCh3g==
=2TUz
-----END PGP SIGNATURE-----

--uEfBlUids2SPOwch4KCTnQJ66S5wDgn4M--
