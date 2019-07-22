From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 1/1] can: sja1000: f81601: add Fintek F81601 support
Date: Mon, 22 Jul 2019 11:11:11 +0200
Message-ID: <7a1009d4-b741-c8ce-ebf4-b825ca109fc9@pengutronix.de>
References: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <563b0d71-3c60-d32c-cf19-73611f68d45a@pengutronix.de>
 <b7c9026a-a887-bc84-3297-c319d18686c3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZcSJg83ihcoezYlmfzJrxiCw9YChKZp24"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b7c9026a-a887-bc84-3297-c319d18686c3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, wg@grandegger.com, peter_hong@fintek.com.tw
Cc: davem@davemloft.net, f.suligoi@asem.it, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZcSJg83ihcoezYlmfzJrxiCw9YChKZp24
Content-Type: multipart/mixed; boundary="nrpiinlGmf10hpvp3bmpRLLX3aQIiOT12";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, wg@grandegger.com,
 peter_hong@fintek.com.tw
Cc: davem@davemloft.net, f.suligoi@asem.it, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Message-ID: <7a1009d4-b741-c8ce-ebf4-b825ca109fc9@pengutronix.de>
Subject: Re: [PATCH V2 1/1] can: sja1000: f81601: add Fintek F81601 support
References: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <563b0d71-3c60-d32c-cf19-73611f68d45a@pengutronix.de>
 <b7c9026a-a887-bc84-3297-c319d18686c3@gmail.com>
In-Reply-To: <b7c9026a-a887-bc84-3297-c319d18686c3@gmail.com>

--nrpiinlGmf10hpvp3bmpRLLX3aQIiOT12
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/22/19 10:36 AM, Ji-Ze Hong (Peter Hong) wrote:
> Hi Marc,
>=20
> Marc Kleine-Budde =E6=96=BC 2019/7/22 =E4=B8=8B=E5=8D=88 04:15 =E5=AF=AB=
=E9=81=93:
>> On 7/22/19 8:22 AM, Ji-Ze Hong (Peter Hong) wrote: >> +/* Probe F81601=
 based device for the SJA1000 chips and register each
>>> + * available CAN channel to SJA1000 Socket-CAN subsystem.
>>> + */
>>> +static int f81601_pci_add_card(struct pci_dev *pdev,
>>> +			       const struct pci_device_id *ent)
>>> +{
>>> +	struct sja1000_priv *priv;
>>> +	struct net_device *dev;
>>> +	struct f81601_pci_card *card;
>>> +	int err, i, count;
>>> +	u8 tmp;
>>> +
>>> +	if (pcim_enable_device(pdev) < 0) {
>>
>> I'm missing a corresponding disable_device().
>>
> I'm using managed pcim_enable_device(), Does it need call
> pci_disable_device() ??

Right.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nrpiinlGmf10hpvp3bmpRLLX3aQIiOT12--

--ZcSJg83ihcoezYlmfzJrxiCw9YChKZp24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl01fa8ACgkQWsYho5Hk
nSA1wgf+JYc4Fg5gqeiEg4rAfiLMJRb8fIs4ERK5aZto3d0apI+TGVtN/2b9uIpT
ouR1Yzyg6PxC8Pdey2zZsOsIRcgxzo5o9CpL9UFOEC6f095RHO9H0sCdzk3XLJ87
oM/sEW1P5CGVqu5VroXwyKSqB4AHGxi6KxmUi6x4iMFQGqnEV3WIjdXE4M60mVNR
VDsE/U5eUxQLUVpG6hyUCEfOmeRG9IRWqMS/wTqbH8KpYGQsMrVpIXZPHmBEP9SQ
gUU65aSzbXSC6MqQ79j2x7maKzU4QPGCI3J/mDBRCy0dVrjDZrX/AhrCA64Jgar1
CgMuyppTXdJC0MIIxjay/ORSihVevQ==
=uMBx
-----END PGP SIGNATURE-----

--ZcSJg83ihcoezYlmfzJrxiCw9YChKZp24--
