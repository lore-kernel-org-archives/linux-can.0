From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO
 mode and ERRATA ERR005829
Date: Thu, 09 Apr 2015 17:40:52 +0200
Message-ID: <55269D84.1070606@pengutronix.de>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com> <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NKR8PKGvhBxEAujQ3brjKMflx0LM8PwLO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55721 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbbDIPlC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 11:41:02 -0400
In-Reply-To: <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh Sharma <bhupesh.sharma@freescale.com>, linux-can@vger.kernel.org
Cc: arnd@arndb.de, bhupesh.linux@gmail.com, Sakar.Arora@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NKR8PKGvhBxEAujQ3brjKMflx0LM8PwLO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2015 05:24 PM, Bhupesh Sharma wrote:
> This patch adds support for non RX-FIFO (legacy) mode and ERRATA
> ERR005829 handling in flexcan driver.

What about
25e924450fcb can: flexcan: implement workaround for errata ERR005829
?
> Both these features are now selectable via Kconfig entries and hence ca=
n
> be turned-on/off as per a SoC feature set availability.

Sorry Kconfig is not an option here.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NKR8PKGvhBxEAujQ3brjKMflx0LM8PwLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVJp2HAAoJECte4hHFiupUPrgP/jUDL24IobYnNDUWqiqz1oKy
vH2Ku9LdktjToNOi0Kx8CdTFAbDMm5AGdXdIm5mXHE5STUJa5c/Ui4GsH398EvVp
vqE/IaCLmDWDqXwPPl8bjQtdMzcg3iezjfJCGnRf0H2bzrx+OJj31p5bNG8ZJS/9
CzTcjLnwRWZCMxARBV1aCA2LGFO1nIOM4cwRu2gHbkCW+CB55/AoH7DwbHttXw9o
o3w1n7vtWpFf0Wm4AdE8WAh67EMVXY5JbwgbgigHu2zonBrFNGpuhjaK1w3200iR
mG6Rqco8nvvyrh/FOtfji60dHE5OHnEDfDkvfrxuzkxneIz9a4R697EVKybySpN2
oSpEb4z1GwPEVgHAENMNmF73icm5WoNgmfUr5GQk4MQevkkeH6Tbjzp6AtxOebdd
1QVXk2rujz5PttHuOzFN1drH/jTKIerWiGatM0ABWqDLJRhhxofumv66oxN5fgIK
X8aug/Is5onyrEkjxcLjf8+0a9H8k6G+c083cckaROiMP6Zc43gHfnvMVWHiqC0A
0fPjUkM/vD/DMhDd8XXvfXuIySECn9Lj/B1EocMXbgI4BPHaAaH8a+26qzRsr7AP
YnwI8eJySIMHuLSU2vz09GgET7VMxRjbyp3EYTvWrXHg7/jX5s8FK/KgLSpvPGUs
46a/tN2nd4TH8AHLDVtT
=kwHv
-----END PGP SIGNATURE-----

--NKR8PKGvhBxEAujQ3brjKMflx0LM8PwLO--
