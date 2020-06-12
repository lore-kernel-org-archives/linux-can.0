From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: isotp in mainline?
Date: Fri, 12 Jun 2020 15:47:45 +0200
Message-ID: <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
References: <20200611154337.GA3166627@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:33173 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLNr4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 12 Jun 2020 09:47:56 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 16FA3240100
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 15:47:53 +0200 (CEST)
In-Reply-To: <20200611154337.GA3166627@x1>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Drew Fustini <drew@beagleboard.org>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk
Content-Type: multipart/mixed; boundary="A8bmtt9iFbuk79r6vFXIPuZXuMp2lQsdP";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Drew Fustini <drew@beagleboard.org>
Cc: linux-can@vger.kernel.org
Message-ID: <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
Subject: Re: isotp in mainline?
References: <20200611154337.GA3166627@x1>
In-Reply-To: <20200611154337.GA3166627@x1>

--A8bmtt9iFbuk79r6vFXIPuZXuMp2lQsdP
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi Drew,

> Is there a current effort to get the isotp driver accepted into mainlin=
e?

I believe ISOTP has been mainline for quite a while.

I remember writing a test script when Python 3.7 came out in Aug 2018
and added the isotp socket type to socket class [1].

I tested on a X86_64 machine with Ubuntu 18.04 LTS, so it must have been
mainline at that time.

Regards,
Patrick

[1]
https://docs.python.org/3.7/library/socket.html?highlight=3Dsocket#socket=
=2ECAN_ISOTP


--A8bmtt9iFbuk79r6vFXIPuZXuMp2lQsdP--

--EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAl7jh4YACgkQMeZuMM+v
uE4jsBAAnMEu5vaGa9zauO22UgCZ8+/snYhXiP5ERNb3h6isNfmmtyUBhufF5JU/
JuX7206o4ysAIoFvgvplwVq7s+nUBMR0X9xmlBY/ubhUwq757jT4apmWHdN2deVJ
qRy0pdU3SFUmyTAplGmyRdYPSDo5Cd6xPhMhw7QeMIZtaDq669Vrcf/hLkd5qEr7
+oAz3W4LpH9SdnNGR2rr0gT6kR2qOOiqa0FEK51zU0aYgb591ZKDO8GROaq93beL
+QABJ4lec5sm9rhwq8210++9tErkBkBtBtscBrVC30vo3JhKQOQMMT+t/5i0fkoa
aGkRnNLgraUU4/5e15OZX9OrMe5LpiV9UdRiv71WLV5eMsaidgFOlaiuecz4ewbv
kkbpq9WM/R0y/H9EF/Xr/pebgjzCSMeZo8TavlvK+F3HJkltKzMWOp04TcJLpLje
wtc7BRr6T49U8gCMGAUY80tAd0knWBlZcg6mq126UnMeXAirq/KKDISfWI/zVkmg
yx8CCi9Z2RLC/OkCwmUg7eDED2w+iLFvbAHmGKgjQuIVdRPfTUbKh2QZ2mYxecMY
pknpWjXliPi+nOccO+o6GtLlzgxA/XhdcynlhffdwSv5jv7mN3hYUXpqlOnuLDiB
2IEWG5nMNiZqKCoZZZ4jkwVWFva50To337n07Jrhxfh8epuRph4=
=x42e
-----END PGP SIGNATURE-----

--EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk--
