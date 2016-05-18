From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: AW: c_can driver sometimes sends first two bytes filled with
 zeros
Date: Wed, 18 May 2016 10:35:06 -0500
Message-ID: <573C8BAA.5040200@opensource.altera.com>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <573A0E08.4010008@opensource.altera.com>
 <0120733A154AE74CA608A286CE7FFD2621D9C80F@rg-contact.RG.local>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0055.outbound.protection.outlook.com ([157.56.111.55]:62275
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932525AbcERQED (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 18 May 2016 12:04:03 -0400
In-Reply-To: <0120733A154AE74CA608A286CE7FFD2621D9C80F@rg-contact.RG.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@gomtec.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Richard,

On 05/17/2016 12:18 PM, Richard Andrysek wrote:
> Hi Thor,
>
> I've made two use cases with can0:
>
> a)	RAW socket can with 200us steps
> b)	8 CAN messages with 150us step in a broadcast mode
>
> Both works perfect, only my PCAN USB has from time to time an overrun=
=2E I think I need another logger:)
>
> But if I take case b) and reduce steps to 128us I get two frames with=
 wrong two first bytes per 3min.
> Similar behavior in case a).
>
I'd like to clarify. When you refer to steps, are you talking about use=
c=20
delays between messages using the usleep function as described in your=20
initial post?

And to clarify the setup: a) is a RAW socket (is this a custom user=20
space program?) sending 1 message every 200us and b) uses the older=20
4.0.6 cansend sending 1 message with 150us between each message repeate=
d=20
8 times? Or is b) sending 8 messages back-to-back (no usleep() in=20
between messages) with 150us between the 8 messages?

And the problem is that when you reduce the delay between messages to=20
128us, you start losing the first 2 bytes in 2 frames if you record for=
=20
3 minutes.

> Questions:
>     Q1) What I still don't understand, if there is a failure I do not=
 get any error value. Why that?
>     Q2) Is there somewhere missing some kind of locking mechanism?
>

> -----Urspr=FCngliche Nachricht-----
> Von: Thor Thayer [mailto:tthayer@opensource.altera.com]
> Gesendet: Montag, 16. Mai 2016 20:15
> An: Richard Andrysek <richard.andrysek@gomtec.de>; linux-can@vger.ker=
nel.org
> Betreff: Re: c_can driver sometimes sends first two bytes filled with=
 zeros
>
> Hi Richard,
>
> On 05/12/2016 04:23 AM, Richard Andrysek wrote:
>> We can reproduce an issue with the canutils. We send messages in the=
 loop with non-zero bytes and from time to time we get first two bytes =
of the message with zero values. The test script looks so:
>>
>> #!/bin/sh
>>
>> echo "Press [CTRL+C] to stop.."
>> while true
>> do
>>                  cansend can1 --loop=3D15 -i 933 0xde 0xde 0xde 0xde=
 0xde
>> 0xde done
>>
>> With CAN analyzer we see normally the right message, but in cycles ~=
1min we see first two bytes are zero.
>>
>> If we add some delays between messages, like this:
>>
>> do
>>                  cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde =
0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>>                  usleep 5
>>
>> done
>>
>> It works fine.
>>
>> We use Altera Cyclone V, where the  c_can driver is used. It runs wi=
th Linux kernel 3.16, but I've checked 4.5 version of a driver and it i=
s a same one.
>>
>> Have somebody idea how to find a reason for that?
>>
>> Richard
>>
> How old are your canutils? I had a similar issue on an older version =
of cansend (4.0.6 from the Pengutronix site - with a copyright date of =
2009).
>
> There is an old thread (http://comments.gmane.org/gmane.linux.can/233=
9)
> that suggests adding a delay in the cansend utility to work around a =
poll/select bug.
>
> I added a delay for 4.0.6 but you may want to grab the latest from gi=
thub (https://github.com/linux-can/can-utils).
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
