From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 09:05:02 +0100
Message-ID: <54C746AE.60801@pengutronix.de>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="f5rjgrfdAX0hljWNUaIR8OKGdIAvEc2nQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48371 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbbA0IFT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 03:05:19 -0500
In-Reply-To: <54C74589.9050603@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5rjgrfdAX0hljWNUaIR8OKGdIAvEc2nQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 09:00 AM, Oliver Hartkopp wrote:
>>> I assume it is better to set the ctrlmode directly in the struct can_=
priv
>>> element in  pcan_usb_fd_init() after retrieving the firmware version.=

>>
>> Even better.
>>
>>> IMO it doesn't make sense to transport this info through the mechanic=
 above
>>> which mostly initialized quasi constant settings for the adapter.
>>
>> If we check the firmware version, it doesn't make sende to put the
>> information into that struct (IMHO)

> Just to be sure: We stated to have the same opinion here, right?

Yes, check the firmware version and set ctrlmode directly.

>>> +/* describes the PCAN-USB Pro FD adapter */
>>> +struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>>
>>> be
>>>
>>> +/* describes the PCAN-USB Pro FD adapter */
>>> +const struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>
>> Yes, but it probably needs some more modifications in the driver.
>=20
> I don't know if this struct is "read-only" all the time.
> If so it is easy to change.

I haven't checked but I _think_ it should be possible to make it read
only everywhere.

> I pity you, Stephane - but we will make it :-))

:)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--f5rjgrfdAX0hljWNUaIR8OKGdIAvEc2nQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUx0a3AAoJECte4hHFiupUhxkQAKGgv527Nc+/BPNZoLOMvgXV
qMPL1LBHA4SaB4Bs1YOZBA6Vm0+xCTvrFKTKArnT/B51FTvhuWywy2INHh6qq0K/
IBwOWTY9/lm2QR+kmzFwHSBw5nYgjpBBpbX3Ma4+XGhwUbjZTZy00XPhuhQHOih2
qDo9XKON8iHqqELbowR5IVubWxX5YlBsd676H2BY8htMSEstPiIPX9NLvvU01nRI
AFCZzjV44MaCMPO4QaSjtxxqE0Et/qVgfP56S7VtaspkY510Qmqmk5d+YVFE7rbR
8+ZSk4MjevNdO7aDibL4CCDgzalDxH6n/P2rTPQ7OeyDqr0ARZkxE696GXDgL1wx
Y2b70dzSKUyxZS+eiHnNPrvTDTTXBoqejFJR5dsCCqj0bnOqvKL+7LBmgFamKXPa
eQDeYTSh3cj/55bVpYUsc55zI5eWgwNZr9APsfIKU5yMa6lHUQ2chkYsW1lZFP6M
oTAkLzx6iua9Mz5uywUPj7skQKgC2wSOXg1zKOXHFHyG+EpNmdJX2FwV4GimLjDp
46o2roznLHN1SP8sm3w1owMGWtNXgnGs1B23Qiz0qbyFfciHJHnhPMsOhcB+CfGx
ffNjEu56v89ZwJCyfGkVLWtPAUQHBD7fPL4WyZL0lmxwXwZ9w8XY0OQpAT0Mh+6w
1Amp01gUyt25MQakgatL
=x8Fg
-----END PGP SIGNATURE-----

--f5rjgrfdAX0hljWNUaIR8OKGdIAvEc2nQ--
