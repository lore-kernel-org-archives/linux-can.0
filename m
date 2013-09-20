From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <hj.oertel@t-online.de>
Subject: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 01:03:28 +0200
Message-ID: <1881932.U1kQQJkqCz@heinz.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1643385.czHBXS5iaL"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61896 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab3ITXDt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Sep 2013 19:03:49 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


--nextPart1643385.czHBXS5iaL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello Linux CAN community,

long before SocketCAN, which now is part of the Linux kernel drivers, c=
an4linux was available as the CAN device driver for Linux.

I now like to add it to the kernel source tree as well. What to you thi=
nk about it. And how should I start and proceed?
I would like to start with the Xilinx XCANPS as can be found on the Zyn=
q processor. Maybe also with one PCI board, the CPC-PCI (EMS W=FCnsche)=
.

What is the best way? My current development for the PC is based on Ope=
nSuse with kernel 3.7.10. for Xilinx it is kernel 3.10. Can I send a pa=
tch against 3.7 and to whom can I send it?

Hope to get some answers helping me with the project. Thanks.
--=20
mit freundlichen Gr=FC=DFen
       Heinz-J=FCrgen Oertel
--nextPart1643385.czHBXS5iaL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJSPNRPAAoJENViPQy9fcm78KMH/A1EYMLvDWSFTqV2bNZbmmxN
2klkf56VOafvpw1ndgJ0sdmVDJU9JlnC6R0o/aootQMYJ75ForaDfyAteaWITJLJ
vHTDGnFtEU/f3OytJCa2B1Eslg22/h1loRxQU2Kk8/+SuupdwbjaCf5XxAsljcEx
80UtmuKl3Bkr4y9o+XMVu3t87ONLD112A1uluxx3nWZKz9WTJtzbWd+dw34yIuvW
CkXBFQ6+A6bI/YjFq7N7PHkk23hpl/utW0T2UpTm3AL3DmMCAet2m406PVbAPTP1
s1KBMC7JiDJ4kcBStrmtxQtxINxWZMzazHP+vesNfbQj/I13HC6DRxwuw6fGtj8=
=bepl
-----END PGP SIGNATURE-----

--nextPart1643385.czHBXS5iaL--

