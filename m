From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 21:37:06 +0200
Message-ID: <5230C662.6010502@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HMnGn57UdIG8oxNtGTXrEuHTfwaUQujbf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55664 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab3IKTkc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 15:40:32 -0400
In-Reply-To: <1378920814-sup-4559@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMnGn57UdIG8oxNtGTXrEuHTfwaUQujbf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2013 07:42 PM, Ico wrote:
> 1. capture-ico.pcap: CAN-232 interface, slcan, x86_64
> 2. capture-yegor.pcap: VScom USB-CAN interface, slcal, x86

BTW:

> file *.pcap
> capture-ico.pcap:   pcap-ng capture file - version 1.0
> capture-yegor.pcap: tcpdump capture file (little-endian) - version 2.4 =
(SocketCAN, capture length 65535)

You are using different tools.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HMnGn57UdIG8oxNtGTXrEuHTfwaUQujbf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIwxmIACgkQjTAFq1RaXHNN0wCfZUYraFGQjAdfvDjZC9Xlj93q
g30AnjqDXkPLzJIT/sx/COj2UcneoruY
=NlBR
-----END PGP SIGNATURE-----

--HMnGn57UdIG8oxNtGTXrEuHTfwaUQujbf--
