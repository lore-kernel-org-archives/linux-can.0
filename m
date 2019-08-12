From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
Date: Mon, 12 Aug 2019 11:10:32 +0200
Message-ID: <5571da8a-de1f-f420-f6b7-81c6d8932430@pengutronix.de>
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3419807536863070388=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3419807536863070388==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="n406Pf6ucFPRr81ZBCSfLv22f4uepOdOB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n406Pf6ucFPRr81ZBCSfLv22f4uepOdOB
Content-Type: multipart/mixed; boundary="Bh7iV2cCBX2dzNWNFNsLjKNDADYAoxdLa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <5571da8a-de1f-f420-f6b7-81c6d8932430@pengutronix.de>
Subject: Re: [PATCH 0/5] can: xilinx_can: Bug fixes
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>
In-Reply-To: <7ecaa7df-3202-21d8-de93-5f6af3582964@pengutronix.de>

--Bh7iV2cCBX2dzNWNFNsLjKNDADYAoxdLa
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/12/19 11:05 AM, Marc Kleine-Budde wrote:
> On 8/12/19 9:28 AM, Appana Durga Kedareswara rao wrote:
>> This patch series fixes below issues
>> --> Bugs in the driver w.r.to CANFD 2.0 IP support
>> --> Defer the probe if clock is not found
>>
>> Appana Durga Kedareswara rao (3):
>>   can: xilinx_can: Fix FSR register handling in the rx path
>>   can: xilinx_can: Fix the data updation logic for CANFD FD frames
>>   can: xilinx_can: Fix FSR register FL and RI mask values for canfd 2.=
0
>>
>> Srinivas Neeli (1):
>>   can: xilinx_can: Fix the data phase btr1 calculation
>>
>> Venkatesh Yadav Abbarapu (1):
>>   can: xilinx_can: defer the probe if clock is not found
>=20
> Please add your S-o-b to patches 4+5.
>=20
> As these all are bugfixes please add a reference to the commit it fixes=
:
>=20
>     Fixes: commitish ("description")

Add this to your ~/.gitconfig:

[alias]
        lfixes =3D log --pretty=3Dfixes
[pretty]
        fixes =3D Fixes: %h (\"%s\")

and then use $(git lfixes $commitish).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Bh7iV2cCBX2dzNWNFNsLjKNDADYAoxdLa--

--n406Pf6ucFPRr81ZBCSfLv22f4uepOdOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1RLQgACgkQWsYho5Hk
nSA7iAf/SPKEeZgvTZ73lEBwv0Fw+6St3jUayWb22nfMohsOBtHE07DbuA4uewt8
8VjnSvqK9MH44QayDP5vBVKGCnSYrSFQj51PgL1YOg/ftVQLWXCAkgq1SwWVykKk
QI6HiYTLqV4t/0ebVq61nryUZmt0VYBg2maBaLtkutPWkrbweAX+tSfZHD6rVtwp
RkMkA77gC5rK7iSWQTngUiiIRU0I2wUAtECbI+R/aa7FtkWT3GqlferXW++yJRBJ
AMST2HsiTD9gLRj0t0GjpcO/kRhL25mcpcTlIcsNpMNBJAhBhj93PyOe5qFantC4
JfbfGVETc+P9Wjf3B61ShI0/LlpFiQ==
=lsBO
-----END PGP SIGNATURE-----

--n406Pf6ucFPRr81ZBCSfLv22f4uepOdOB--


--===============3419807536863070388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3419807536863070388==--
