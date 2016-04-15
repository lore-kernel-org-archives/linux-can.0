From: Julien Pilet <julien@anemomind.com>
Subject: Re: Bad reading from mcp2515 with j1939
Date: Fri, 15 Apr 2016 15:02:39 +0200
Message-ID: <4C069C3C-A7B8-4D3D-BA66-0D2140E93996@anemomind.com>
References: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com> <20160415101957.GA22129@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_F91CAFC3-9282-465B-A2DB-8242E3A0965A"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-can-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:47902 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbcDONDm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Apr 2016 09:03:42 -0400
In-Reply-To: <20160415101957.GA22129@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


--Apple-Mail=_F91CAFC3-9282-465B-A2DB-8242E3A0965A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

Thanks for your response.

I managed to reproduce the error and validate that the reading is =
erroneous.

I have one device sending can messages. I have two device reading, one =
being my mcp2515, the other is a usb nmea2000 adapter from actisense.

Beside the changing sequence id (first byte) I expect to read always the =
same data. So I ran:

./candump can0  | grep 09FD0200 | grep -v "19 00 60 7A FA FF FF"

It selects only the messages I=E2=80=99m interested in (09FD0200) and =
remove correct frames. Most frames are correct and are not displayed. A =
few frames show wrong values, though:
  can0  09FD0200   [8]  AA 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  C2 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  AA 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  AE 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  A6 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  86 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  E6 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  8E 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  8E 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  A2 99 00 60 7A FA FF FF
  can0  09FD0200   [8]  CA 99 00 60 7A FA FF FF

It is again the MSB bit of byte number 2 which is wrong. It should show =
19 00, not 99 00. On the other reading device, I see correctly 19 00. So =
the problem is in the reading.

I tried switching triple-sampling on and off, but it does not change =
anything.

I observed the same issue on different physical devices, so it is not an =
isolated issue.

Julien

> On 15 avr. 2016, at 12:19, Kurt Van Dijck =
<dev.kurt@vandijck-laurijssen.be> wrote:
>=20
> I'm sure that your host does not introduce a problem.
> The 80 00 appears on the wire. Your linux kernel can't change that :-)
>=20
> Can you validate your claim that this is erroneous?
> Can you see these frames exactly the same on an other host?


--Apple-Mail=_F91CAFC3-9282-465B-A2DB-8242E3A0965A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXEOZvAAoJEGcI0CImx551resH/3ZqrFtqxTZ/J8tqecIrKaAJ
Re4mBXldnAXLYUWD7uWFirJ7kKuwW9a1D45Ivu8NegPlsti2AtAnoyJPRhlsThwi
I5QQwW1Iyl3nQNjfg1of85ktc6Yt3+D+Ld9zpbNi49sej3tYl2QSQzY1KikLDAoy
Nuad0PmXR11K8gL8XOMttcJvzTwu1/rc955qXwe1eb9CBm6tcVYvlKPQ60GPwfuX
2A5iiyFfqB2avG9DwdjDZsjpGiKMRfdecDyQo+ood2JFa+STrwb6jNFC6fODEHs3
8kYdekAry5wNpeCipDlmrgDUoBrAS7HHtzj+sEyv654vUmcbBsCqF2dQv9Xv/D0=
=lMTO
-----END PGP SIGNATURE-----

--Apple-Mail=_F91CAFC3-9282-465B-A2DB-8242E3A0965A--
