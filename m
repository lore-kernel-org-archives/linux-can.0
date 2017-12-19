From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 89/121] net/can/j1939/transport.c:1309
 j1939_session_fresh_new() error: use kfree_skb() here instead of kfree(skb)
Date: Tue, 19 Dec 2017 12:53:17 +0100
Message-ID: <434e7f6d-011e-3baf-e470-6c45534c31c4@pengutronix.de>
References: <20171216120827.ztws3ez5maqox7hx@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IlvU4opktcuk8T9JE3jGc1o1Kf24VWtFF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54141 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751198AbdLSLx0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Dec 2017 06:53:26 -0500
In-Reply-To: <20171216120827.ztws3ez5maqox7hx@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IlvU4opktcuk8T9JE3jGc1o1Kf24VWtFF
Content-Type: multipart/mixed; boundary="ATF6KDDsdBWxbqLVUVBH1hFcnNjOjeFg8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
 Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
Message-ID: <434e7f6d-011e-3baf-e470-6c45534c31c4@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 89/121] net/can/j1939/transport.c:1309
 j1939_session_fresh_new() error: use kfree_skb() here instead of kfree(skb)
References: <20171216120827.ztws3ez5maqox7hx@mwanda>
In-Reply-To: <20171216120827.ztws3ez5maqox7hx@mwanda>

--ATF6KDDsdBWxbqLVUVBH1hFcnNjOjeFg8
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/16/2017 01:08 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git j1939
> head:   31a3a5b6afa815d144da2d01940e493fb7b625f2
> commit: dbdee3fe09a691eb4ddfedd349be5ffe5e866fb9 [89/121] j1939: transp=
ort: use common prefix j1939_session{,list}_ for all session{,list} relat=
ed functions

Fixed.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ATF6KDDsdBWxbqLVUVBH1hFcnNjOjeFg8--

--IlvU4opktcuk8T9JE3jGc1o1Kf24VWtFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlo4/a0ACgkQHv7KIOw4
HPboZwgAw4Wt2oULcjf5Y0Xo9DwpEQHDoXcyR1Hi9pzeq82EEpfTSEWHANuOcfJv
AtE3TIKMWTpcU8NvFQ5VM4d3NhmFNTC7KTOMvtV1yV+IBw/Ekkn3ytP04TEblYjh
9pDyS7L2g8qzH1RpIq7CA/mOetImTb0RqK7VVBPnb14UmiTR4mIXKBylXUhh/GSv
PDQcFLsxY0xZEOSZvoO/GgpKh8ZCYFV54plZaZjbEUyJbkYK2vCP/KTsmY6H5qcD
Di/r982kanB4sI4DPaCKGdPhMPDrLHRPC9yKn7KWsOdGLn09il1x1gMaHjb1EnsF
8MLdOsvImO1BUOtMNNqZpYSxzY8OJw==
=bqO3
-----END PGP SIGNATURE-----

--IlvU4opktcuk8T9JE3jGc1o1Kf24VWtFF--
