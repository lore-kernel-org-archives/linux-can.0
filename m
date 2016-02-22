From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make
 use of IRQ offloading
Date: Mon, 22 Feb 2016 16:19:28 +0100
Message-ID: <56CB2700.80107@pengutronix.de>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
 <87egdf5eca.fsf@gmail.com> <569D6180.8030906@pengutronix.de>
 <569D82BE.1000007@optusnet.com.au>
 <CAJ=nTsv39BL85Tbgp86CzMS-fUhGx0627POVKTXaRMETNoAnDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Leq0EMDm0HvvbMnGF2aRUR4PJcbKtmlIA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51133 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752924AbcBVPTj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Feb 2016 10:19:39 -0500
In-Reply-To: <CAJ=nTsv39BL85Tbgp86CzMS-fUhGx0627POVKTXaRMETNoAnDA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>, tom_usenet@optusnet.com.au
Cc: Holger Schurig <holgerschurig@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, kernel@pengutronix.de, bhupesh.sharma@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Leq0EMDm0HvvbMnGF2aRUR4PJcbKtmlIA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2016 04:16 PM, Mirza Krak wrote:
> Applied this patch series to my 4.1.5 kernel and for what it is worth
> I get the same error on VF610 after approximately 500 k frames.
>=20
> [  118.751463] WARNING: CPU: 0 PID: 0 at drivers/net/can/rx-fifo.c:205
> can_rx_fifo_irq_offload+0x2dc/0x30c()         [  118.761065]
> can_rx_fifo_irq_offload: No messages found, RX-FIFO out of sync?
>                                               [  118.768137] Modules
> linked in: mx4_pic(O) mcp251x [last unloaded: mx4_pic]
>                                         [  118.775108] CPU: 0 PID: 0
> Comm: swapper Tainted: G           O
> 4.1.15-00058-gd84a5e156db7-dirty #1               [  118.784355]
> Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)

Thanks for the feedback. The fsl/nxp people are working on this. They
gave me a hint I'll verify and test today,

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Leq0EMDm0HvvbMnGF2aRUR4PJcbKtmlIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWyycAAAoJED07qiWsqSVqB1UH/08gQNopzs+1JCu048a4hLih
7J4jJGy8vsKt7h3o5eNl5LVhsqyVpH/TWUuDUlQjYiqSWFVVd4cHDqrqp2pk48Wu
Xg3kRsVzaiyeAR4Zru9pqN/Wg+s6qmeVmF5nijBVCLjVc5XcimKpxoaCu9vr4WiP
sRpoOmJRBfqVxCEqOGEi/I/LXboGnYYqBCMCNl5XCcXB9XqjEp10GVa7aUvkCuRx
qKDzU1RTwKRgbLHwyestqGTm5z7iuIO/75g43XNI+P4R7PAX7eypJ6fhkKAILYX+
flKh3Q2vcx/jPGM+N375BOZUM7DKkriWZRzUiSRjRmTzMUEiHzj3mlao//TrXTQ=
=lVSF
-----END PGP SIGNATURE-----

--Leq0EMDm0HvvbMnGF2aRUR4PJcbKtmlIA--
