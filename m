From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 11:37:01 +0200
Message-ID: <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mQiNwHBQJePMaOTLO2FwiaRCMdDvdwLqb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50540 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964851AbcJFJhP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 05:37:15 -0400
In-Reply-To: <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mQiNwHBQJePMaOTLO2FwiaRCMdDvdwLqb
Content-Type: multipart/mixed; boundary="AxGqGAXgJeQKiJjB1i3SRpaehuCAUWKD0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>,
 Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161006092403.GA26915@airbook.vandijck-laurijssen.be>

--AxGqGAXgJeQKiJjB1i3SRpaehuCAUWKD0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 11:24 AM, Kurt Van Dijck wrote:
>>> * e2447ef: make TP data transmission work again
>>>   This commit fixes a mistake you've done with the fall-trough
>>>   statements in j1939tp_txnext (this isn't the easiest state machien =
on
>>>   Earth :-) ).
>>
>> Thanks.
>>
>> I have cherry picked both and will push them to v4.7. If everything
>> works on the v4.7 branch, I'll squash most of it together an move to v=
4.8.
>>
>> Thoughts?
>=20
> 1) I'll try to move module parameters to /proc/sys/net/can-j1939/ items=
=2E

Tnx.

> 2) Tonight, I happen to meet an "open source license" expert.
>    I'll try to discuss with him the email address thing.

IANAL: I think the tool pick up the Author of the commit. The (c)
copyright line is not relevant for tools, only humans...and lawyers.
Have a look at the .mailmap feature for author and/or email address
mapping: https://git-scm.com/docs/git-shortlog

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AxGqGAXgJeQKiJjB1i3SRpaehuCAUWKD0--

--mQiNwHBQJePMaOTLO2FwiaRCMdDvdwLqb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9hs9AAoJED07qiWsqSVqrTsIAKreSrYovUHLA2V3RaXN0izE
rIDjDpL2MDX1DX6J9qyF5YuovoOvLdi5aiWGSkRw8w9OGcZ1h1q2DHBq1BxIg5bx
LTv/WqHxf8s10NlJmCZ5Ujev1vr6e5VnCflj0H2g2ivJBXwuU1OsWA2VMvncaKoa
JCtfneaCAJe0vpg7iBe3VLPU7RgI9SVQTI4ChkJhW3AKVkKMVAWU6ljfy32Z/c64
5XhuFtu4MrUblnEeCXGXCxSWr/ehUNqQzk1n7R801E10fhagnHOUDyY6SeXwk26D
UizPB/TgnwY/AylkBC34fldMAWSNXBYVvUFxhICmreNEc1brN7+nsKmovU0H/+o=
=YvnL
-----END PGP SIGNATURE-----

--mQiNwHBQJePMaOTLO2FwiaRCMdDvdwLqb--
