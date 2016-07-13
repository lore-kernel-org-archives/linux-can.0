From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch
 flexcan driver to use it
Date: Wed, 13 Jul 2016 09:46:38 +0200
Message-ID: <ae40b714-4027-51f9-7dc0-56183cd1b1ef@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <CAJ=nTsuOfu4jyT6tiH+1fWarmSOVHV29zEm2sg6PphXTxKVHLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qEEScbHCx2tgwdPOuT0nHudUEEK8VX45u"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41222 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750854AbcGMHqx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2016 03:46:53 -0400
In-Reply-To: <CAJ=nTsuOfu4jyT6tiH+1fWarmSOVHV29zEm2sg6PphXTxKVHLQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, david@protonic.nl

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qEEScbHCx2tgwdPOuT0nHudUEEK8VX45u
Content-Type: multipart/mixed; boundary="ltvuPFMtCcFfRH3r8qrKW2Psj1qITuR7i"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, david@protonic.nl
Message-ID: <ae40b714-4027-51f9-7dc0-56183cd1b1ef@pengutronix.de>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch
 flexcan driver to use it
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <CAJ=nTsuOfu4jyT6tiH+1fWarmSOVHV29zEm2sg6PphXTxKVHLQ@mail.gmail.com>
In-Reply-To: <CAJ=nTsuOfu4jyT6tiH+1fWarmSOVHV29zEm2sg6PphXTxKVHLQ@mail.gmail.com>

--ltvuPFMtCcFfRH3r8qrKW2Psj1qITuR7i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2016 09:28 AM, Mirza Krak wrote:
> 2016-07-04 20:32 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
>> Hello,
>>
>> this patch takes up the idea to read the CAN frames in IRQ context and=
 send
>> them later in NAPI. The first two patches add each an offloading schem=
e.
>>
>> The first one is for hardware FIFO based cores, like the flexcan in FI=
FO mode.
>> The second one requires mailboxes with timestamps. The mailboxes are r=
ead and
>> sorted by timestamp in IRQ context, sending is done later in NAPI aswe=
ll.
>>
>> The remaining patches modify the flexcan driver to make use of it. imx=
6 and
>> vf610 SoCs can make use of the 64 mailbox software FIFO, while older S=
oCs still
>> use flexcan's 6 mailbox deep hardware FIFO.
>>
>> Testing on any flexcan core is highly appreciated.
>=20
> Did a test run on v2 series on my VF610 SOC.
>=20
> I do not see any problems with order anymore [1] and it recovers fine
> from "ERROFRAMES" [2]. No other issues to report.
>=20
> Tested-by: Mirza Krak <mirza.krak@hostmobility.com>

Thanks.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ltvuPFMtCcFfRH3r8qrKW2Psj1qITuR7i--

--qEEScbHCx2tgwdPOuT0nHudUEEK8VX45u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXhfHeAAoJED07qiWsqSVqngMH/3P2u4sXQfGuxm1l23lWPnhg
dDxwlRLBmcrz1wlmloVR1MGfstw0tq/+T3Z9L7GB9ZCyR2drNTdERp7+l/3djPo9
LyAJWkV7KI/XWsMm+68rRC9J7M0BqirOBfyKrFP9ug2H/fHgsfe2sl23XVxw8AkV
J2FAgzUhH3QS2cZr6rQXUAcR1hnN7PGBdER8vHGPMbZ6JDa+SxWf2vXZInx12PwM
YF06ipHrzEkGpotyzLKYFohQiA5zvRC9LTEfCVKhmFF8lbum6o16exbryOSbYUAY
JYmgeMbALXfq6iAHw5QUhhirNt+Kgi5hBUBjE1XyQkRLK1TYMJQ9iPA9XHMgbFQ=
=2mUg
-----END PGP SIGNATURE-----

--qEEScbHCx2tgwdPOuT0nHudUEEK8VX45u--
