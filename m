From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 04/14] can: af_can: give variable holding the CAN per
 device receive lists a sensible name
Date: Mon, 28 Aug 2017 15:39:58 +0200
Message-ID: <a7d1757d-1ba0-17dc-e3a2-b32bd94b96cc@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-5-mkl@pengutronix.de>
 <7225d783-b4b6-3d65-1f3b-13138c896718@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HQsuCom7g1fdkvboie1G6UpLrvF1DH2n1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50951 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751170AbdH1NkF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 09:40:05 -0400
In-Reply-To: <7225d783-b4b6-3d65-1f3b-13138c896718@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HQsuCom7g1fdkvboie1G6UpLrvF1DH2n1
Content-Type: multipart/mixed; boundary="Etn2V2vAQfa6iRB6LbiQWiRD4kKEf3rGh";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <a7d1757d-1ba0-17dc-e3a2-b32bd94b96cc@pengutronix.de>
Subject: Re: [PATCH 04/14] can: af_can: give variable holding the CAN per
 device receive lists a sensible name
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-5-mkl@pengutronix.de>
 <7225d783-b4b6-3d65-1f3b-13138c896718@hartkopp.net>
In-Reply-To: <7225d783-b4b6-3d65-1f3b-13138c896718@hartkopp.net>

--Etn2V2vAQfa6iRB6LbiQWiRD4kKEf3rGh
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:03 PM, Oliver Hartkopp wrote:
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> This patch gives the variables holding the CAN receive filter lists a
>> better name by renaming them from "d" to "dev_rcv_lists".
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   net/can/af_can.c | 87 ++++++++++++++++++++++++++++------------------=
----------
>>   1 file changed, 43 insertions(+), 44 deletions(-)
>>
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 2b12f713f4ca..43f4f51d5a73 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -381,7 +381,7 @@ static unsigned int effhash(canid_t can_id)
>>    *  Reduced can_id to have a preprocessed filter compare value.
>>    */
>>   static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *ma=
sk,
>> -					struct can_dev_rcv_lists *d)
>> +					struct can_dev_rcv_lists *dev_rcv_lists)
>=20
> 					struct can_dev_rcv_lists *cdrl)
>=20
> Ok. 'd' might be too short and not be easy to bring into connection wit=
h=20
> can_dev_rcv_lists ... but 'dev_rcv_lists' smells like just another=20
> structure definition an not a handy variable name, like e.g. cdrl ;-)

"d" is short - yes, but "cdrl" doesn't speak to me either.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Etn2V2vAQfa6iRB6LbiQWiRD4kKEf3rGh--

--HQsuCom7g1fdkvboie1G6UpLrvF1DH2n1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmkHS4ACgkQHv7KIOw4
HPZRVQgAjwhTDlEKYvsNv0wG4Xu8RvLbQrmuDiru21aRhcu+P8O0cgTnTboFVeZq
w5OWgF6FvzvG6PBKJ0qS0J4Nhhwl7adhiQ2V0xST3ppA+JZsxL8gUDgGf1aNj8JI
6lpmbrWsl/rK8TuyO+xza5gIUzNA4TPNzZicaaIQ+EQnav6Ii9jqEFphLouXv1rS
DWGiZFzNMCPoekYlrzS5fzNWW6+kFBW2586eZ+CrHwf8UmuhguaJpbOqh2qGUPgI
aVpkHIfBYQIvCgZEuigsdnFBBOI1G9Oe4uq7XY7t5Op/23VYG+0bFdafPBOv3dhK
3XjBv2Eep1nXJmfBbf7jR0AS+29rXg==
=+LJx
-----END PGP SIGNATURE-----

--HQsuCom7g1fdkvboie1G6UpLrvF1DH2n1--
