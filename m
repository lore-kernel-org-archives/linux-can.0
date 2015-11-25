From: Guillaume Picquet <guillaume@picquet.fr>
Subject: Re: Setting bitrate from user-space application
Date: Wed, 25 Nov 2015 17:17:54 +0100
Message-ID: <5655DF32.5090505@picquet.fr>
References: <5655BF6D.3000701@picquet.fr> <5655CC8D.70508@pengutronix.de>
 <5655DC22.4000302@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtpauth.online.net ([62.210.16.40]:58589 "EHLO
	smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751432AbbKYQSA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 11:18:00 -0500
In-Reply-To: <5655DC22.4000302@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



Le 25/11/2015 17:04, Oliver Hartkopp a =C3=A9crit :
> Hi Guillaume,
>
> On 11/25/2015 03:58 PM, Marc Kleine-Budde wrote:
>> On 11/25/2015 03:02 PM, Guillaume Picquet wrote:
>>> Hi all,
>>>
>>> I prefer to ask first to those who know.
>>>
>>> What is the 'normal' way of setting CAN bitrate from user-space
>>> application ?
>>> Is there a library for that ?
>> Yes -
>> http://www.pengutronix.de/software/libsocketcan/download/libsocketca=
n-0.0.10.tar.bz2
>>
>>> If no shall I use netlink ?
>> No - netlink parsing makes your brain hurt :D
>>
> Using libsocketcan is the way to control the interfaces by an applica=
tion
> (which internally uses netlink).
I've downloaded it, cross-compile it and made a test program.
I read bitrate successfully.

>
> The usual way to configure the interfaces system wide is the 'ip' too=
l from
> the iproute2 package which comes with your preferred Linux distributi=
on.
On the platform I'am working it's done in a rc script at start-up
>
> The way to configure CAN interfaces with 'ip' is described here:
>
> https://www.kernel.org/doc/Documentation/networking/can.txt (see chap=
ter 6.5)
>
> E.g. you can use this script in Debian/Ubuntu setups then:
>
> https://github.com/linux-can/can-misc/blob/master/etc/can_if
>
> Regards,
> Oliver
Regards,

guillaume
