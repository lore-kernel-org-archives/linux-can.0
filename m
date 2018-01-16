From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: WARNING in can_rcv
Date: Tue, 16 Jan 2018 19:44:01 +0100
Message-ID: <8396fb44-e8ab-3245-8c7b-dbc7e17cc9d7@pengutronix.de>
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3ic3k5H4SizysDojKtFhJgabCzDPA4K1B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43261 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeAPSoa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jan 2018 13:44:30 -0500
In-Reply-To: <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, syzkaller-bugs@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ic3k5H4SizysDojKtFhJgabCzDPA4K1B
Content-Type: multipart/mixed; boundary="j5QPHMPs15qypTOnpGHtui2JsBaSt6CEs";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>,
 David Miller <davem@davemloft.net>, linux-can@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>, syzkaller-bugs@googlegroups.com
Message-ID: <8396fb44-e8ab-3245-8c7b-dbc7e17cc9d7@pengutronix.de>
Subject: Re: WARNING in can_rcv
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>

--j5QPHMPs15qypTOnpGHtui2JsBaSt6CEs
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:11 PM, Dmitry Vyukov wrote:
>>> Kernel panic - not syncing: panic_on_warn set ...
>>
>> Invalid packages generate a warning (WARN_ONCE()), and you have
>> panic_on_warn active. Should we better silently drop these CAN package=
s?
>=20
> pr_warn_once() will be more appropriate. It prints a single line.

Thanks - just posted the patches, will send a pull request to David
tomorrow.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--j5QPHMPs15qypTOnpGHtui2JsBaSt6CEs--

--3ic3k5H4SizysDojKtFhJgabCzDPA4K1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpeR/EACgkQHv7KIOw4
HPZBDwf/WCDyBFWgKkEZ0iBbPLc0k59pd789wdjWoMw9+2aOOuh0P0FZ25lruPjq
6gVF1Aaag+ZGafZhJRXKu82csGWUTR4hrEHYvzfIkAjsALNg6/SOv86HjBSqmy9M
+etcYss/wVGJ06d3QKXQTZHFmSZceq6RQqTYLH2bXBcT64g0oeoSbuOEOy4Io0DS
cqRhHVAUrb6vnTt6QbNCG/jbD2LIV/ahbKt207CRnSCzA8MIsfaQqFeuTYlKDH5f
Al2P7i7toyvoDnv56ucpLZ1lJUyQSj4E//SiN5ol+zAcX1kYheXCjyDwgB/9pI/D
wH2806YPOZEOYJhhi871S9wuUwe7dA==
=z9HW
-----END PGP SIGNATURE-----

--3ic3k5H4SizysDojKtFhJgabCzDPA4K1B--
