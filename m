From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Wed, 25 Apr 2012 09:41:05 +0200
Message-ID: <4F97AA91.1020007@pengutronix.de>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com> <4F964C45.8010804@grandegger.com> <20120424190226.GA1589@gmail.com> <4F97A735.5080708@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6A59BD5D1B43A06F3E21A31B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40466 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2DYHlM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Apr 2012 03:41:12 -0400
In-Reply-To: <4F97A735.5080708@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A59BD5D1B43A06F3E21A31B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/25/2012 09:26 AM, Wolfgang Grandegger wrote:
> Hi Fabio,
>=20
> On 04/24/2012 09:02 PM, Fabio Baltieri wrote:
>> Hi Wolfgang,
>>
>> On Tue, Apr 24, 2012 at 08:46:29AM +0200, Wolfgang Grandegger wrote:
>>> I still think that the blinking support should go to the timer class =
to
>>> avoid duplicated code. Any good reason against? Apart from that the
>>> patches look good.
>>>
>>> Wolfgang.
>>
>> I can see you point and I considered your note about adding the
>> one-shot-blink function to the led-class framework (sorry for not
>> mentioning it in my first post).  Still, I ended up with this code for=

>> a couple of reasons:
>>
>> - I think that the led_blink_set function is primarily used to configu=
re
>>   leds with hardware blinking (like i2c led drivers).  While it would =
be
>>   possible to extend the function to get one-shot behavior and always
>>   fallback on software blink, I think that that's out of the purpose o=
f
>>   the led-class, which should just translate on-off requests to
>>   underlaying hardware.
>=20
> Why, there is already led_tigger_event() and led_trigger_blink(). Why
> should led_trigger_blink_once() then do not make sense?
>=20
>> - I think that different drivers may want to obtain different on-off
>>   behavior depending on the application.  For example in the ide-disk
>>   case the user expects to see a steady-on LED on constant activity,
>>   and that's how it's implemented, while in this case the on-if-up
>>   keep-blinking-on-activity off-if-down makes much more sense. So I th=
ink
>>   that even if a generic blink function were available, people would
>>   still be using custom functions because they want to fine tune the
>>   behavior for the application.  Also, maybe a function too generic ma=
y
>>   impact on performance in critical paths.
>=20
> The blinking could be specified with led_trigger_blink_once().
>=20
>> - in this case, it looks to me like the implementation is as optimized=

>>   as it can be, in the sense that the hot-path does really only some
>>   essential check and engage the timer and the timer function itself i=
s
>>   really short.  Also the final blinking effect is nice IMO :-)
>=20
> For me it still does make sense to provide a generic
> led_trigger_blink_once support. But well, go ahead if I'm the only one
> with that opinion.

+1
At least start a discussion on the LED list (I don't know which list
that is).

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6A59BD5D1B43A06F3E21A31B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+XqpQACgkQjTAFq1RaXHPDhwCghbFFehO/VlO2fObctSUp7Pzq
YRUAn1J7XQBGujTn+eYlCfHRPZKUhl25
=QmaC
-----END PGP SIGNATURE-----

--------------enig6A59BD5D1B43A06F3E21A31B--
