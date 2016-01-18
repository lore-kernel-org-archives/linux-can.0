From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make
 use of IRQ offloading
Date: Mon, 18 Jan 2016 23:04:48 +0100
Message-ID: <569D6180.8030906@pengutronix.de>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
 <87egdf5eca.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XKFVNkfDl5A6MoqS87OiWEUwe9NmuecF2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44171 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756689AbcARWE7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2016 17:04:59 -0500
In-Reply-To: <87egdf5eca.fsf@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, bhupesh.sharma@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XKFVNkfDl5A6MoqS87OiWEUwe9NmuecF2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2016 12:14 PM, Holger Schurig wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>=20
>> Testing and feedback welcome.
>=20
> And here it is, albeit a bit late:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at /home/schurig/d/mkarm/linux-4.4/drivers/net/c=
an/rx-fifo.c:203 can_rx_fifo_irq_offload+0x214/0x264()
> can_rx_fifo_irq_offload: No messages found, RX-FIFO out of sync?
> Modules linked in: bnep btusb btrtl btbcm btintel bluetooth smsc95xx us=
bnet mii imx_sdma flexcan dlog(O)
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.4.0 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)

Thanks for testing, this driver triggers what we think a hardware bug,
resulting in packages are not beeing filled into the correct order into
the hardware. There are some people at fsl/nxp looking into this issue
at the hardware level.

> flexcan/flexcan-calculate-default-value-for-imask1-during-runtime.patch=

> flexcan/flexcan-make-TX-mailbox-selectable-during-runtime.patch
> flexcan/rx-fifo-Add-support-for-simple-irq-offloading.patch
> flexcan/flexcan-make-use-of-rx-fifos-irq_offload_simple.patch
> flexcan/flexcan-add-missing-register-definitions.patch
> flexcan/flexcan-activate-individual-RX-masking-and-initialize-reg_rximr=
=2Epatch
> flexcan/flexcan-add-quirk-FLEXCAN_QUIRK_ENABLE_EACEN_RRS.patch
> flexcan/flexcan-reg_imask2_default.patch
> flexcan/rx-fifo-introduce-software-rx-fifo-implementation.patch
> flexcan/flexcan-add-support-for-rx-fifo-based-software-FIFO-implementat=
ion.patch
> flexcan/flexcan-switch-imx6-and-vf610-to-software-based-fifo.patch

You can omit the last patch and it should work.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XKFVNkfDl5A6MoqS87OiWEUwe9NmuecF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWnWGAAAoJEP5prqPJtc/HcRQIAL1eK3vjHLbRHqtXNZYUnjF3
7vVxzmNnEjyF6I4CiNAhAC8xBTQwykY+TtokqIzGATPgM6iu/gp8wbv0sxw5sq34
IXzlElRdIZL+n4XiVs1IQKZCgzmGCtRB/oW1J5sG7dOVrlM3NdHdmm81Qi3ELgMJ
zCUzf1Ix0owpZtz4djCaUXdYTbk/mzp3NwOFCta4s54qBNR+XFRj8TGic/dltG5Z
y0xIOZCYp4d6TXtg+3zwWsYkH0O9nPyAmc44icmFqsWGV6r2i9Mw18Y5YRyBF9N2
n2yxvLrQgpABpcrmhw0AhqDFLmAgwmcrejyzkVnNoQ3NTiAraQV/dhmBxIiiTu4=
=vNBu
-----END PGP SIGNATURE-----

--XKFVNkfDl5A6MoqS87OiWEUwe9NmuecF2--
