From: Guillaume Picquet <guillaume@picquet.fr>
Subject: Re: Setting bitrate from user-space application
Date: Wed, 23 Dec 2015 15:03:23 +0100
Message-ID: <567AA9AB.9010500@picquet.fr>
References: <5655BF6D.3000701@picquet.fr> <5655CC8D.70508@pengutronix.de>
 <5655DC22.4000302@hartkopp.net> <5655DF32.5090505@picquet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtpauth.online.net ([62.210.16.40]:44694 "EHLO
	smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754071AbbLWODk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Dec 2015 09:03:40 -0500
In-Reply-To: <5655DF32.5090505@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi all!

A status update, thanks to libsocketcan I am able to get and set bitrat=
e.
remarks:
Before setting bitrate a stop must be performed.
I use poll() on CAN socket and it returns and set errno to ENETDOWN=20
during the stop but sockets stay valid. (no need to close and reopen).
I Suppose it is normal behaviour, right ?

Thanks for support.

Regards.

Le 25/11/2015 17:17, Guillaume Picquet a =C3=A9crit :
>
>
> Le 25/11/2015 17:04, Oliver Hartkopp a =C3=A9crit :
>> Hi Guillaume,
>>
>> On 11/25/2015 03:58 PM, Marc Kleine-Budde wrote:
>>> On 11/25/2015 03:02 PM, Guillaume Picquet wrote:
>>>> Hi all,
>>>>
>>>> I prefer to ask first to those who know.
>>>>
>>>> What is the 'normal' way of setting CAN bitrate from user-space
>>>> application ?
>>>> Is there a library for that ?
>>> Yes -
>>> http://www.pengutronix.de/software/libsocketcan/download/libsocketc=
an-0.0.10.tar.bz2=20
>>>
>>>
>>>> If no shall I use netlink ?
>>> No - netlink parsing makes your brain hurt :D
>>>
>> Using libsocketcan is the way to control the interfaces by an=20
>> application
>> (which internally uses netlink).
> I've downloaded it, cross-compile it and made a test program.
> I read bitrate successfully.
>
>>
>> The usual way to configure the interfaces system wide is the 'ip'=20
>> tool from
>> the iproute2 package which comes with your preferred Linux distribut=
ion.
> On the platform I'am working it's done in a rc script at start-up
>>
>> The way to configure CAN interfaces with 'ip' is described here:
>>
>> https://www.kernel.org/doc/Documentation/networking/can.txt (see=20
>> chapter 6.5)
>>
>> E.g. you can use this script in Debian/Ubuntu setups then:
>>
>> https://github.com/linux-can/can-misc/blob/master/etc/can_if
>>
>> Regards,
>> Oliver
> Regards,
>
> guillaume
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

