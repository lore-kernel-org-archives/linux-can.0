From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: J1939 Linux
Date: Thu, 14 Apr 2016 14:31:09 +0200
Message-ID: <570F8D8D.9020403@pengutronix.de>
References: <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
 <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
 <570F75D7.6000708@pengutronix.de>
 <20160414122240.GB7409@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="itNlW3wNfLMGGpnPbNIhvum6DWbuB2sW1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52538 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754363AbcDNMbg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 08:31:36 -0400
In-Reply-To: <20160414122240.GB7409@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>, gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--itNlW3wNfLMGGpnPbNIhvum6DWbuB2sW1
Content-Type: multipart/mixed; boundary="w8qeAldOXujjkFUMUSd5UHcJm2GoMXbRi"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>,
 gianluca <gianlucarenzi@eurek.it>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <570F8D8D.9020403@pengutronix.de>
Subject: Re: J1939 Linux
References: <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
 <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
 <570F75D7.6000708@pengutronix.de>
 <20160414122240.GB7409@airbook.vandijck-laurijssen.be>
In-Reply-To: <20160414122240.GB7409@airbook.vandijck-laurijssen.be>

--w8qeAldOXujjkFUMUSd5UHcJm2GoMXbRi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2016 02:22 PM, Kurt Van Dijck wrote:
>> On 04/14/2016 12:03 PM, Kurt Van Dijck wrote:
>>> I pushed j1939d-v3.19.
>>>
>>> I created the branch by merging & cherry-pick, as suggested earlier.
>>> I didn't have compile problems.
>>>
>>> I have not tested it, yet I foresee no problems, or at least no
>>> differences compared to my other j1939d-vx.xx branches.
>>
>> I want to do the first steps of mainlining j1939. Which is the preferr=
ed
>> branch? I've started with j1939/j1939d-v4.3.
>=20
> I'm not sure if mainlining introduces a big squash, or a regular merge.=


I'll first squash everything and then probably move the bits modifying
existing files into a separate patch.

> I'd say that j1939d-v4.1 show a cleaner history.

I'll rebase both to v4.5 to see if there's a difference.

> The only reason for existence of j1939-v4.3 is that I was working with =
a
                                   ^^^^^^^^^^
You mean "j1939d-v4.3" with a "d".

> v4.3 at that point.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--w8qeAldOXujjkFUMUSd5UHcJm2GoMXbRi--

--itNlW3wNfLMGGpnPbNIhvum6DWbuB2sW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXD42NAAoJED07qiWsqSVqZk0IAJnHY3xhik+1RIWYlII6QQM8
svUAGnbAiPuVVRCGjygyBJKXLRklRkYeo8XhZpuwqrdgrT9Yw5CafVYuOIG8qqfH
Rt5IK/j7xxtmG4YAHFKtGP94OfyMNAwcgEKfpj/9eEMqnQetyxTcdPUrGRv4l1pR
j0jA5dH0QckYRAW5asQzJs0ISMt3JpSDkhjHco0G4K5mJixxX/z5aF+9b0gxlj2U
DKoUbAUPI6iUffJRukcTyblb+aeeiucgLg8Zjtc1m1QqWWavySFoY4m1+Bo4t/1Z
S8Z6H6pTnawd2qpmcAcljFXlNlVL2peNHbPGYRrtlCYqkuXyxtu4Vbwfi+59oWg=
=JtyP
-----END PGP SIGNATURE-----

--itNlW3wNfLMGGpnPbNIhvum6DWbuB2sW1--
