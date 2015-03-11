From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/3] can: kvaser_usb: Fix tx queue start/stop
 race conditions
Date: Wed, 11 Mar 2015 16:36:52 +0100
Message-ID: <55006114.8030702@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150311152353.GA12260@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ppxGgtrEWJCTDJ39qeX5rNcSks8vW8vcI"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150311152353.GA12260@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ppxGgtrEWJCTDJ39qeX5rNcSks8vW8vcI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2015 04:23 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> A number of tx queue wake-up events went missing due to the
> outlined scenario below. Start state is a pool of 16 tx URBs,
> active tx_urbs count =3D 15, with the netdev tx queue open.
>=20
> start_xmit()                             tx_acknowledge()
> ............                             ................
> atomic_inc(&tx_urbs);
> if (atomic_read(&tx_urbs) >=3D 16) {
>                         URB completion IRQ!
>                         -->
>                                          atomic_dec(&tx_urbs);
>                                          netif_wake_queue();
>                                          return;
>                         <--
>                         end of IRQ!
>     netif_stop_queue();
> }
>=20
> At the end, the correct state expected is a 15 tx_urbs count
> value with the tx queue state _open_. Due to the race, we get
> the same tx_urbs value but with the tx queue state _stopped_.
> The wake-up event is completely lost.
>=20
> Thus avoid hand-rolled concurrency mechanisms and use a proper
> lock for contexts protection.

I'm missing a spin_lock_init(), right? Please compile and test your code
with everything switch on in Kernel hacking -> Lock Debugging.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ppxGgtrEWJCTDJ39qeX5rNcSks8vW8vcI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVAGEYAAoJECte4hHFiupUTD0P/jYFBXSun+suppD3PLaBBBeB
GpkpDdauwmFu5NNf/11rnPsyNLBrbuZ+pKI0Wb2fUlva4KWVk0SFX54+31g+5j6/
1b9ri7KipwqjazzcQtU+nbL6LyKc0WatUJ2S2lAHemJEybZysi7FpUZRp7J1RNBT
/4bNcnSf55Mx2qdDD4XbwsTbVptoLq68Dx15caq0nk+AEll94UqIZq2uAaxAuHnr
sqnMB8tz9mZRg+2q+3gSkfTiD2z00z7RCgvbdvgJHJcPrmmwcbcCwhASRHNNUOe7
TYthplmEHPGR1fsCJGum9B5SQUa0QrpM+Lw4JzRt1s3WMhwfoBX3MWGrBZkZzkZA
7jfINuoFKXViZ0YS4w9498J4T14jwVQSbnEodksT3p6Yk/VyBP+U76JJZX+9JuNI
25HwRRCU1Zkq4TSmK7j/x8XTfZwXhDnsk2Acd1NKxCwEZT6eizeEV10M34bqpq76
8o3lzVIMARhkhUhQfKc98mj6aOzi2r4el3nQ+sZckTu8G8MSoiKKTuG21PmxHU1W
iNwXgcfxqD8CNuZfKoc4W4yciWgmnXfhHlu/i078j8GQaUVn08fJNRUt5gDospF0
6J/n9N5Z5yQ/JY6ruwCvTo0Ks+0nio822Oc5cV42I1VQLqj9dRLwP/8oZdzZovwC
/zwXm/HMDrdKnLfPKhPK
=3aWF
-----END PGP SIGNATURE-----

--ppxGgtrEWJCTDJ39qeX5rNcSks8vW8vcI--
