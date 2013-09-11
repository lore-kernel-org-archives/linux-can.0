From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 22:11:04 +0200
Message-ID: <5230CE58.3020604@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SqVPSGVGIoDpGdWbWMfIhfVFnWrCgu33s"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33607 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab3IKULL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 16:11:11 -0400
In-Reply-To: <1378929884-sup-7223@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SqVPSGVGIoDpGdWbWMfIhfVFnWrCgu33s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2013 10:05 PM, Ico Doornekamp wrote:
> * On 2013-09-11 21:37:06 +0200, Marc Kleine-Budde wrote:
> =20
>> On 09/11/2013 07:42 PM, Ico wrote:
>>> 1. capture-ico.pcap: CAN-232 interface, slcan, x86_64
>>> 2. capture-yegor.pcap: VScom USB-CAN interface, slcal, x86
>>
>> BTW:
>>
>>> file *.pcap
>>> capture-ico.pcap:   pcap-ng capture file - version 1.0
>>> capture-yegor.pcap: tcpdump capture file (little-endian) - version 2.=
4 (SocketCAN, capture length 65535)
>>
>> You are using different tools.
>=20
> That's fine for all I know, since a sniff is a sniff. The original
> question - which endianess is the right one (and what causes the wrong
> endian sniff) - still stands.

I don't think so, there seems to be two different capture formats, the
tcpdump's and the wireshark's one.

I'm not familiar with the tcpdump capture format, but the
"(little-endian)" above suggests that the format supports both little
and big endianes.

And I'm neither familiar with wireshark. Is there an abstraction for the
different capture formats? Who handles the different endianesses? Maybe
it's a bug in the CAN dissector.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SqVPSGVGIoDpGdWbWMfIhfVFnWrCgu33s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIwzlgACgkQjTAFq1RaXHMm7ACfZwX28VFvUeq89If2iC19HAHR
2EIAn0d8RgPwTlbxZ8K5FRe374Sv60cN
=i539
-----END PGP SIGNATURE-----

--SqVPSGVGIoDpGdWbWMfIhfVFnWrCgu33s--
