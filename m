From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mailmap
Date: Thu, 6 Oct 2016 15:23:34 +0200
Message-ID: <7c7ca8a6-957a-2777-b892-a009576d800e@pengutronix.de>
References: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
 <8c0ae82e-dd87-7b33-a8ea-c76db44e8491@pengutronix.de>
 <20161006132130.GA4131@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="X5rkEulIcCFQpXPHtOOcCQ1JJ3ls6Cm2L"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36998 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932125AbcJFNXk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 09:23:40 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <mkl@pengutronix.de>)
        id 1bs8eA-0007rj-7y
        for linux-can@vger.kernel.org; Thu, 06 Oct 2016 15:23:38 +0200
Received: from [172.17.34.175] (unknown [172.17.34.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Primary Intermediate Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 27A4F17A292
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2016 13:23:37 +0000 (UTC)
In-Reply-To: <20161006132130.GA4131@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X5rkEulIcCFQpXPHtOOcCQ1JJ3ls6Cm2L
Content-Type: multipart/mixed; boundary="uSeLF46oxQggB2xI8ArmguSJT88oAID6l";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Message-ID: <7c7ca8a6-957a-2777-b892-a009576d800e@pengutronix.de>
Subject: Re: mailmap
References: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
 <8c0ae82e-dd87-7b33-a8ea-c76db44e8491@pengutronix.de>
 <20161006132130.GA4131@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161006132130.GA4131@airbook.vandijck-laurijssen.be>

--uSeLF46oxQggB2xI8ArmguSJT88oAID6l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 03:21 PM, Kurt Van Dijck wrote:
>> On 10/06/2016 02:24 PM, Kurt Van Dijck wrote:
>>> Besides the legal aspect of squashing the whole j1939 tree, which I d=
id
>>> half on EIA, half in private time, it sure seems a good idea to fix
>>> the email address in .mailmap:
>>
>> I was hoping that .mailmap would replace the email address but it seem=
s
>> that it's really only used by shortlog.
>=20
> git log --use-mailmap

Nice - even more RTFM solves the problem :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uSeLF46oxQggB2xI8ArmguSJT88oAID6l--

--X5rkEulIcCFQpXPHtOOcCQ1JJ3ls6Cm2L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9lBWAAoJED07qiWsqSVq5YUIAIeq3H8UrtddJ5pZ2yfcPXEr
ovpsppVxkbvROW4oCc0WWB7GrYzdc2agA8tUuorsffW4IxEqbMh2JS1XbfvVNHJs
AiSEOTHobi4nt0VzfaOwdYsaFNRvrHkzcOQem9AEoBomaL/YdU9U/4ZgKtlhRvoq
bH4GOQNxhyIQ14/+D4hsgjmZ5v8P7kWFTXxPA7Y3QqqumWryR0rj/ibn0SiUTPbl
34QvQL/GrDBS6QmscAMvP0YtjUs6aoZWoaYnl3L2Bc1qe5CxgO4gGViDZxlpvbcx
6Fq/tVMgFfmbXUdW2UUQHeBtG62rnvxc0iXN0KShsJzZXuFKgKJtm36XB3Q1mcM=
=v6bh
-----END PGP SIGNATURE-----

--X5rkEulIcCFQpXPHtOOcCQ1JJ3ls6Cm2L--
