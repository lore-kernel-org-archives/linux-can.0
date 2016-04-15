From: Julien Pilet <julien@anemomind.com>
Subject: Re: Bad reading from mcp2515 with j1939
Date: Fri, 15 Apr 2016 18:25:43 +0200
Message-ID: <86B92DF4-DB93-457E-8BFB-7FA1BBBE2B4D@anemomind.com>
References: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com> <20160415101957.GA22129@airbook.vandijck-laurijssen.be> <4C069C3C-A7B8-4D3D-BA66-0D2140E93996@anemomind.com> <57110047.3040305@grandegger.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_10E23B7C-C27B-41F2-AE79-F579D1A0C965"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41004 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbcDOQZs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Apr 2016 12:25:48 -0400
In-Reply-To: <57110047.3040305@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


--Apple-Mail=_10E23B7C-C27B-41F2-AE79-F579D1A0C965
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

Thanks a lot for your help, I found the error. There was a resistor that =
was not supposed to be there (120ohms between CANH and CANL). Removing =
it solved the problem.

Thanks again. Have a great week-end!

Julien.

> On 15 avr. 2016, at 16:52, Wolfgang Grandegger <wg@grandegger.com> =
wrote:
>=20
> Maybe the hardware does not work properly. Try lowering the SPI bus =
frequency or other hw parameters.


--Apple-Mail=_10E23B7C-C27B-41F2-AE79-F579D1A0C965
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXERYIAAoJEGcI0CImx551oVAH/0tICw1YoY7u2cflwh1T1YDn
KYQCeLk87tpXiSBgrWcmf8Mdfb+PWltkDgNASvDD6h6AWmmf9FjypbBM74hRMtGa
H2/+AGH/p1zO5jkRXd6K5hGvZd4OSqWdDhMzZhVSenUhoBM//xswf7t17KsRbTIy
Pjv3rSJcoIU3LSeM3YSNhGYJL5Edg1/W3vncX45ZrcMMSO/zW42RjGgTO/2Pva0B
zXP7PEv4BIbLRLBy0LhUG5p+jcdYHfyKJwQPOGSWhPtz1KFRCKnQQ5cOfaSGnut+
Og029AGvETAT6VnPRUQKOqEpRKv1kHsQtajyvEIGMV2tc78IlWnbABq7PsxE5hw=
=RN85
-----END PGP SIGNATURE-----

--Apple-Mail=_10E23B7C-C27B-41F2-AE79-F579D1A0C965--
