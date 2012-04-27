From: =?iso-8859-15?q?Heinz-J=FCrgen?= Oertel <oe@port.de>
Subject: SocketCAN version numbering
Date: Fri, 27 Apr 2012 11:25:33 +0200
Message-ID: <201204271125.43138.oe@port.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4746912.CW66LbBbMB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:51816 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755389Ab2D0JZq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 05:25:46 -0400
Received: from business-178-015-016-250.static.arcor-ip.net ([178.15.16.250] helo=remote.port.de)
	by mx.professional-internet.de with esmtp (Exim 4.69)
	(envelope-from <oe@port.de>)
	id 1SNhQu-0008Sj-4Y
	for linux-can@vger.kernel.org; Fri, 27 Apr 2012 11:25:44 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

--nextPart4746912.CW66LbBbMB
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable


Hello,

What is the suggested way to get the SocketCAN version number?
On my two systems, according to Documentation/networking/can.txt, I always =
get=20

 $ cat /proc/net/can/version
 rev 20090105 abi 8

on different systems.
But one has support for error counters the other not with the same interfac=
e board

Regards
    Heinz

--nextPart4746912.CW66LbBbMB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iD8DBQBPmmYXA8IN2dIgYc8RAgJDAKDMI65ANCWBuuOJm/EkqDypd0AfaACg8nlb
+Yg1iofbsbH7A5XUyaHkKk0=
=B5Wu
-----END PGP SIGNATURE-----

--nextPart4746912.CW66LbBbMB--
