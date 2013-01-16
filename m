From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 16 Jan 2013 07:13:08 +0100
Message-ID: <50F644F4.1080607@hartkopp.net>
References: <1355641315-15739-1-git-send-email-krumboeck@universalnet.at>    <50F471AC.50902@hartkopp.net> <ae58b62ae76e6261e66774c458012a87.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ae58b62ae76e6261e66774c458012a87.squirrel-2RFepEojUI0eLjVtqu/qlogRFKwBiOYo@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Cc: Bernd Krumboeck <b.krumboeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

On 15.01.2013 23:05, "Bernd Krumb=F6ck" wrote:

>> [  960.047130] usb_8dev 2-1.4:1.0 can2: Unknown status/error message=
 (0)
>> [  976.544343] usb_8dev 2-1.4:1.0 can2: Unknown status/error message=
 (0)
>>
>> Did you check these kind of 'unfriendly user' tests?
>=20
> Not really. At least I don't know what the driver should do. Let me k=
now
> if you have some suggestions.
>=20


Pulling/reconnecting CAN and/or USB under heavy CAN load ;-)

>> E.g. pulling the USB under receive load brings this output:
>>
>> [ 1343.786427] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
>> [ 1343.786640] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
>>
>> (..) another 344 of these URB aborted messages
>=20
> a bit much...
>=20
> Maybe we should suppress this messages?
>=20


I did not had the time for tests yesterday.
But i will attach my full-load CAN generator today.

Regarding the USB abort messages, i'll try the same with my other USB a=
dapters
and how they behave under these conditions.

I remember some tests for the PEAK USB mainlining ... let's see.

Regards,
Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
