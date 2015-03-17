From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: (optional) software filtering in candump
Date: Tue, 17 Mar 2015 14:33:49 +0100
Message-ID: <55082D3D.3070502@pengutronix.de>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info> <51AA01F0.8020308@hartkopp.net> <5508112A.4000808@pengutronix.de> <55081834.9040509@hartkopp.net> <550825D7.6070802@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AsHgH7IA7gdtmS8uHkDPB3w99Dv3gFR0N"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbbCQNd4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 09:33:56 -0400
In-Reply-To: <550825D7.6070802@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AsHgH7IA7gdtmS8uHkDPB3w99Dv3gFR0N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/17/2015 02:02 PM, Oliver Hartkopp wrote:
> On 17.03.2015 13:04, Oliver Hartkopp wrote:
>> On 17.03.2015 12:34, Marc Kleine-Budde wrote:
>>> On 06/01/2013 04:15 PM, Oliver Hartkopp wrote:
>>>> I hope this fit your needs ?! :-)
>>>
>>> Can I have your S-o-b for this patch?
>>
>> Oh. I've just seen, that I already provided a patch that time.
>>
>> I'll check it once more and will give you feedback soon.
>>
>=20
> I rebased the patch, added a comment, a ktime_set(0,0) initialization a=
nd=20
> wrote a proper commit message.
>=20
> Does it fit your expectations?

Thanks a lot, I hope so :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AsHgH7IA7gdtmS8uHkDPB3w99Dv3gFR0N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVCC1AAAoJECte4hHFiupUYW4QAItnrh9kbiIPwb91nlVu/pwv
v8EOMvMd0uKrPOw3RHiJzsqMgbHA+3j5I9A+3DntG91ulPIf14FXgqLyOZicB53i
0CyH5HsJnx4kb5yCvnuB1stuVfsKE5DyH5DNdy3pJYRbj+gfk2iBkqMCleJZsJaF
dGVtIuAU/ywDS25bXkxXf3qs4Cw5v1hs6cnQocjzzQIN4zuB+I49FwAd1MQXNofp
yHukHReRIIOiMyJikL8+IULudmgZu1BfPn4DCBmMewbWrOQdW6lIciXWZG/oilLZ
VIIM/+4QEgAovHxIycVhvSf+CnaXXu8aowN4kzMnP8XUAMMAc2oTXJj7saKrio6d
+NrOBf7lOM8mghXnyY3g+HiMseWpN5WykhK7hfnZGEfjQyICI1TYwhhtdUaAwJEx
fVel8RZ/MJ1HfzTDyqpT3C5j1yo0RGYbqCU3MKHs/TvRCus6RR3PrUaKfGWis3zd
8M32UNDTVGzbWY0Fl4dCEU9Xcae2sAaQ+nOLNR2OgDd8zJYH+6H8H6ib/xIFl1YY
+2tYpdT4nZ2S6TqRzfNN47N2s0YPpuloYIqc4/EBo9P35qU2KmD234ZVWwBhOOZg
IQkbr37SJo2EzYNGEAzzmzpTY/fxzac9nwW6GV8R3nMCdd6gscA9j41sEcTNw+6V
+Z9NeG4nmLKkkEEHi1dw
=12BU
-----END PGP SIGNATURE-----

--AsHgH7IA7gdtmS8uHkDPB3w99Dv3gFR0N--
