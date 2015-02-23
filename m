From: =?UTF-8?Q?Maximilian_G=C3=BCntner?= <maximilian.guentner@gmail.com>
Subject: Re: Standard CAN over IP
Date: Mon, 23 Feb 2015 15:27:04 +0100
Message-ID: <CAKSnaaddj_UNrzkr=pZ5KM0r8xkHMPeLHqBr2Y_KHr1tZZBN+g@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
	<54E71DDA.9000807@hartkopp.net>
	<CAKSnaaezqAXG3mNRa8zq7r1bq_YbJMHbLb1odSkaYYYDsqLi+Q@mail.gmail.com>
	<54EB2655.7060303@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:39518 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbbBWO1G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Feb 2015 09:27:06 -0500
Received: by lbvn10 with SMTP id n10so18766732lbv.6
        for <linux-can@vger.kernel.org>; Mon, 23 Feb 2015 06:27:05 -0800 (PST)
In-Reply-To: <54EB2655.7060303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Mike Purvis <mpurvis@clearpathrobotics.com>, linux-can@vger.kernel.org, tom_usenet@optusnet.com.au

Hi Oliver,

2015-02-23 14:08 GMT+01:00 Oliver Hartkopp <socketcan@hartkopp.net>:
>> In a setup where a host that uses CAN FD is connected to a host that
>> uses traditional CAN, frames with a payload of under 9 Bytes can also be
>> bridged using cannelloni - only frames that exceed 8 Bytes will be
>> dropped.
>
> Hm. This is not the correct distinction for CAN and CAN FD.
>
> There can be CAN FD frames with <=8 bytes too.

Sure. My intent was not to make a distinction between CAN and CAN FD
based on the frame length but rather to check whether it is possible to send the
data section on that particular bus.
But I think dropping CAN FD frames on non CAN FD interfaces is the right choice
in the long run.

> You need to make sure that the difference between CAN FD with 8 bytes and
> CAN2.0 with 8 bytes does not get lost. So I would suggest to add an
> additional attribute to each transfered CAN frame which tells you:
>
> - Is a CAN FD frame (or not)
> - Has bitrate setting (CANFD_BRS) enabled (for CAN FD)

Both flags make sense to me. Maybe we can use the MSB of LEN (so 0x80)
to encode whether it is a CAN FD frame. The next byte is either
the first DATA byte or FLAGS followed by the first DATA byte.

> - Has error state (CANFD_ESI) enabled (for CAN FD)

Do you think that this flag is necessary for two independent CAN buses?
When sending the frame on a physical bus, the error state of that
interface/node can be different compared to the original sender.
If host A receives a frame on bus A where CANFD_ESI is set and
transmits it to host B which in return writes it to bus B, the CANFD_ESI
bit will represent the state of a different node (host B instead of the
original sender).
Maybe I am wrong, but I think that the CANFD_ESI flag needs to be
masked prior to transmission on bus B.

>
> My suggestion would be to add a single byte for each frame that contains
> CANFD_BRS and CANFD_ESI as-is and e.g. 0x80 when this is a CAN FD frame.
>
> [...]
> On the sender side 0x80 is OR'ed when the read frame length was CANFD_MTU.
> And on the receiver a CAN or CAN FD frame is created based on 0x80 in FLAGS.

Sounds good.

>
> Regards,
> Oliver
>
Thanks,

Maximilian
