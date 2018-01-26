From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
Date: Fri, 26 Jan 2018 12:45:08 +0100
Message-ID: <c644afe9-a87a-f1c9-712f-50a48912d79b@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
 <bc7051ae-846c-dc73-c177-ef7306e85320@pengutronix.de>
 <20180125093206.GB30696@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2DMey9UUcokpOldWs3lR9DSKQTaxJmvbZ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeAZLpi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Jan 2018 06:45:38 -0500
In-Reply-To: <20180125093206.GB30696@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2DMey9UUcokpOldWs3lR9DSKQTaxJmvbZ
Content-Type: multipart/mixed; boundary="LRl3BEtp9APZRlUCZZ6k4OsNFvC8D0Nb9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Message-ID: <c644afe9-a87a-f1c9-712f-50a48912d79b@pengutronix.de>
Subject: Re: [PATCH 4/4] j1939: remove proc support
References: <20180124110659.438-1-o.rempel@pengutronix.de>
 <20180124110659.438-4-o.rempel@pengutronix.de>
 <20180124201307.GB4214@airbook.vandijck-laurijssen.be>
 <bc7051ae-846c-dc73-c177-ef7306e85320@pengutronix.de>
 <20180125093206.GB30696@airbook.vandijck-laurijssen.be>
In-Reply-To: <20180125093206.GB30696@airbook.vandijck-laurijssen.be>

--LRl3BEtp9APZRlUCZZ6k4OsNFvC8D0Nb9
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 10:32 AM, Kurt Van Dijck wrote:
>> On 01/24/2018 09:13 PM, Kurt Van Dijck wrote:
>>> I'm in favor of stripping all unnecessary, but ...
>>
>> [...]
>>
>>>> -  7 can-j1939 SYSCTL
>>>> -    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
>>>> -    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
>>>> -    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
>>>
>>> Those parameters shape the kernels behaviour on transport sessions.
>>> It makes sense to configure them globally.
>>> Should this be returned to module parameters then?
>> I've split up the patch and removed the procfs for now, but the sysctl=

>> support stays in. I even have taken two more of Oleksij's patches that=

>> update the sysctl related parts of the documentation.
>=20
> Sounds fair.
> Don't thow the procfs away too far :-)

Here it is:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dj1939-proc

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LRl3BEtp9APZRlUCZZ6k4OsNFvC8D0Nb9--

--2DMey9UUcokpOldWs3lR9DSKQTaxJmvbZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlprFMQACgkQHv7KIOw4
HPaXZwgAjM5XdwFlpcLSmA2DMFfMJAlz+K1i3PNtBmi6Wu1MKb+WXZISLW/WROo3
RB8L64oAiTdUCMhhzbP5ScvBYXi+mspsdfuVO5xeA9DUoBUbpfBkvLsdA8LTnhxf
Qlc+6wNXaGVLv71H+1A7lpPwfq1K16e245eDcdhKYm8ZAklqPzXHPBupvyYkM2dH
iDexBZ6xWq6ItRPZIJo2YbUQAYYLEWv4rvuKXClBS9fZnJ8PjJhm+kjD+jy1dqOv
cmttB48N6ZVk9zsD8rrXnWzKhFKDVwgH77fcyGYmYbeh7QuIDpXlrHX5d1opL4px
INLAiC3Mrj34JLaFwX0FpiXSbh+dPg==
=RF50
-----END PGP SIGNATURE-----

--2DMey9UUcokpOldWs3lR9DSKQTaxJmvbZ--
