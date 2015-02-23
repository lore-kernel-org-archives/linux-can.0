From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Standard CAN over IP
Date: Mon, 23 Feb 2015 14:08:37 +0100
Message-ID: <54EB2655.7060303@hartkopp.net>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>	<54E71DDA.9000807@hartkopp.net> <CAKSnaaezqAXG3mNRa8zq7r1bq_YbJMHbLb1odSkaYYYDsqLi+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:42991 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbBWNIl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Feb 2015 08:08:41 -0500
In-Reply-To: <CAKSnaaezqAXG3mNRa8zq7r1bq_YbJMHbLb1odSkaYYYDsqLi+Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TWF4aW1pbGlhbiBHw7xudG5lcg==?= <maximilian.guentner@gmail.com>
Cc: Mike Purvis <mpurvis@clearpathrobotics.com>, linux-can@vger.kernel.org, tom_usenet@optusnet.com.au

On 23.02.2015 13:25, Maximilian G=C3=BCntner wrote:

> 2015-02-20 12:43 GMT+01:00 Oliver Hartkopp <socketcan@hartkopp.net>:
>> I would suggest to implement CAN FD from the beginning.
>>
>> When creating the CAN RAW socket just try to switch it into CAN FD m=
ode:
>>
> thank you for the input. CAN FD is now (1ef0769900b) supported :)

Great!

>
> Each instance determines whether it is possible to write CAN FD frame=
s
> to the socket, a configuration is not necessary.
> In a setup where a host that uses CAN FD is connected to a host that
> uses traditional CAN, frames with a payload of under 9 Bytes can also=
 be
> bridged using cannelloni - only frames that exceed 8 Bytes will be dr=
opped.

Hm. This is not the correct distinction for CAN and CAN FD.

There can be CAN FD frames with <=3D8 bytes too.

You need to make sure that the difference between CAN FD with 8 bytes a=
nd=20
CAN2.0 with 8 bytes does not get lost. So I would suggest to add an add=
itional=20
attribute to each transfered CAN frame which tells you:

- Is a CAN FD frame (or not)
- Has bitrate setting (CANFD_BRS) enabled (for CAN FD)
- Has error state (CANFD_ESI) enabled (for CAN FD)

My suggestion would be to add a single byte for each frame that contain=
s=20
CANFD_BRS and CANFD_ESI as-is and e.g. 0x80 when this is a CAN FD frame=
=2E

> Here is how a cannelloni frame looks like:
>
> [ VERSION | TYPE | SEQ_NO | COUNT | COUNT * [ CANID |
> LEN | LEN * DATA ] ]

You would have COUNT * [ CANID | FLAGS | LEN | LEN * DATA ] ]

then with a single FLAGS byte.

On the sender side 0x80 is OR'ed when the read frame length was CANFD_M=
TU.
And on the receiver a CAN or CAN FD frame is created based on 0x80 in F=
LAGS.

Regards,
Oliver

