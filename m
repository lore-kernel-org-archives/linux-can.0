From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2018-01-16
Date: Tue, 16 Jan 2018 15:28:46 +0100
Message-ID: <335207aa-3313-a981-ee39-ce5c861470c8@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UwLDt91OrxwQegS1emt89MMmUd0NcSY0i"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44217 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeAPO3P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jan 2018 09:29:15 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwLDt91OrxwQegS1emt89MMmUd0NcSY0i
Content-Type: multipart/mixed; boundary="6C0ODC1wKsQPPoPP527qk6Lnvn7CbwGoh";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
Message-ID: <335207aa-3313-a981-ee39-ce5c861470c8@pengutronix.de>
Subject: pull-request: can-next 2018-01-16

--6C0ODC1wKsQPPoPP527qk6Lnvn7CbwGoh
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 9 patches.

This is a series of patches, some of them initially by Franklin S Cooper
Jr, which was picked up by Faiz Abbas. Faiz Abbas added some patches
while working on this series, I contributed one as well.

The first two patches add support to CAN device infrastructure to limit
the bitrate of a CAN adapter if the used CAN-transceiver has a certain
maximum bitrate.

The remaining patches improve the m_can driver. They add support for
bitrate limiting to the driver, clean up the driver and add support for
runtime PM.

regards,
Marc

---

The following changes since commit 79d891c1bbb6573cef31dbc2030fba61cfa1df=
6d:

  Merge tag 'linux-can-next-for-4.16-20180105' of ssh://gitolite.kernel.o=
rg/pub/scm/linux/kernel/git/mkl/linux-can-next (2018-01-15 16:13:34 -0500=
)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-ne=
xt.git tags/linux-can-next-for-4.16-20180116

for you to fetch changes up to 31643dc8fc66abdd3f68800483df4a5420f5e69c:

  can: m_can: Add call to of_can_transceiver (2018-01-16 15:11:35 +0100)

----------------------------------------------------------------
linux-can-next-for-4.16-20180116

----------------------------------------------------------------
Faiz Abbas (3):
      can: m_can: Remove check for version when allocating m_can net devi=
ce
      can: m_can: Move allocation of net device to probe
      can: m_can: Add PM Support

Franklin S Cooper Jr (5):
      dt-bindings: can: can-transceiver: Document new binding
      can: dev: Add support for limiting configured bitrate
      dt-bindings: can: m_can: Document new can transceiver binding
      can: m_can: Support higher speed CAN-FD bitrates
      can: m_can: Add call to of_can_transceiver

Marc Kleine-Budde (1):
      can: m_can: get rid of function free_m_can_dev()

 .../bindings/net/can/can-transceiver.txt           |  24 +++
 .../devicetree/bindings/net/can/m_can.txt          |   9 +
 drivers/net/can/dev.c                              |  45 ++++-
 drivers/net/can/m_can/m_can.c                      | 183 +++++++++++++--=
------
 include/linux/can/dev.h                            |   7 +
 include/uapi/linux/can/netlink.h                   |   1 +
 6 files changed, 202 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transce=
iver.txt

--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



--6C0ODC1wKsQPPoPP527qk6Lnvn7CbwGoh--

--UwLDt91OrxwQegS1emt89MMmUd0NcSY0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpeDCAACgkQHv7KIOw4
HPYKDgf9HtQhHs2NNWYf9i9NU1wshhkH4UVNnzztdNf+ae6w0vQdK00gvXFb5Aoe
ZU9s7aS2BsyuOyM+tYXNdMBaUptR0eN+/06+y+ZLaGmBXNM5moXKy83DBvL+UCu4
pdy9tSqE9QsbRNvBnpWPD/eeb7dIUBEtPBb0VHCDJ5HlRaMeNCwyGdS7cvs3LbnO
5lzNM4TPcN37dx5Yq/2UfWdJd1Ks1eGdL6KxqfB5sBKELQ/gLZJfUaI1ReT1vC2F
3tNVGqvn2ywZsX4RA6I8iOISSFl8O9fw54puXL2EVgu+EpVdq2ALPVYCvJhu9ibv
PIc+M0jp0ucWZ/nHU/rrp5QM24QLjw==
=uw0b
-----END PGP SIGNATURE-----

--UwLDt91OrxwQegS1emt89MMmUd0NcSY0i--
