From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can 2018-07-30
Date: Mon, 30 Jul 2018 21:06:27 +0200
Message-ID: <d629f545-e2d6-c2dd-91f5-45a3dde73831@pengutronix.de>
References: <20180730090822.16919-1-mkl@pengutronix.de>
 <20180730.091628.2180063281807636490.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="K7NgPhIPATG8XI81PEH5nFFoEEmpuUAnk"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180730.091628.2180063281807636490.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K7NgPhIPATG8XI81PEH5nFFoEEmpuUAnk
Content-Type: multipart/mixed; boundary="iCWt78mhwvKDttlzyEWo8LQKAuuCFGpVC";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
Message-ID: <d629f545-e2d6-c2dd-91f5-45a3dde73831@pengutronix.de>
Subject: Re: pull-request: can 2018-07-30
References: <20180730090822.16919-1-mkl@pengutronix.de>
 <20180730.091628.2180063281807636490.davem@davemloft.net>
In-Reply-To: <20180730.091628.2180063281807636490.davem@davemloft.net>

--iCWt78mhwvKDttlzyEWo8LQKAuuCFGpVC
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 07/30/2018 06:16 PM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Mon, 30 Jul 2018 11:08:21 +0200
>=20
>> Hello David,
>>
>> this is a pull request of one patch for net/master.
>>
>> The patch by Anton Vasilyev and the Linux Driver Verification project
>> fixes a memory leak in the ems_usb driver's disconnect function.
>=20
> Where is the GIT URL you want me to pull from? :)

Oops, it's definitely too hot in the office at the moment. here it it:

---

The following changes since commit 25432eba9cd8f2ef5afef55be811b010a004b5=
fa:

  openvswitch: meter: Fix setting meter id for new entries (2018-07-29 13=
:20:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.gi=
t tags/linux-can-fixes-for-4.18-20180730

for you to fetch changes up to 72c05f32f4a5055c9c8fe889bb6903ec959c0aad:

  can: ems_usb: Fix memory leak on ems_usb_disconnect() (2018-07-30 11:04=
:27 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.18-20180730

----------------------------------------------------------------
Anton Vasilyev (1):
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

 drivers/net/can/usb/ems_usb.c | 1 +
 1 file changed, 1 insertion(+)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iCWt78mhwvKDttlzyEWo8LQKAuuCFGpVC--

--K7NgPhIPATG8XI81PEH5nFFoEEmpuUAnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltfYbMACgkQk9IU1zQo
ZfHQbwf/X3ZOVzxXRolnUy/L66JOBQxngCUrWCFZmzFGn7pnZjvZV2amrXvkAaXq
qkNLJcCHIiSvoecdfYeLCHHPrcx2TIz5Z2M1XA15YaQie68VCXkBlX04krecvJNg
V0nladHpmp384eyEhEr77yBThas8GsLbtmcXdb5XxSocXPFGh4DQlBEifEIZkqzD
zUUYRz8p46XJNbCVINQ0ZyhbDRT+23dihY+jYrNNoc1subXrppUIAufoT536Z3Gv
cRQQy3QYSD0Zu7S/38vtJuVsA01pQ9PvN+XHw1+ODtnTX+Ye/J2vcpaO9xlc+mxY
xmNi/OeVafCCl58Jub1NKLVtnmBX8Q==
=4fwZ
-----END PGP SIGNATURE-----

--K7NgPhIPATG8XI81PEH5nFFoEEmpuUAnk--
