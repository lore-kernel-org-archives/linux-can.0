From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Standard CAN over IP
Date: Mon, 23 Feb 2015 17:22:23 +0100
Message-ID: <54EB53BF.2010902@hartkopp.net>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>	<54E71DDA.9000807@hartkopp.net>	<CAKSnaaezqAXG3mNRa8zq7r1bq_YbJMHbLb1odSkaYYYDsqLi+Q@mail.gmail.com>	<54EB2655.7060303@hartkopp.net> <CAKSnaaddj_UNrzkr=pZ5KM0r8xkHMPeLHqBr2Y_KHr1tZZBN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:36653 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbbBWQW1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Feb 2015 11:22:27 -0500
In-Reply-To: <CAKSnaaddj_UNrzkr=pZ5KM0r8xkHMPeLHqBr2Y_KHr1tZZBN+g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TWF4aW1pbGlhbiBHw7xudG5lcg==?= <maximilian.guentner@gmail.com>
Cc: Mike Purvis <mpurvis@clearpathrobotics.com>, linux-can@vger.kernel.org, tom_usenet@optusnet.com.au

On 23.02.2015 15:27, Maximilian G=C3=BCntner wrote:

>> There can be CAN FD frames with <=3D8 bytes too.
>
> Sure. My intent was not to make a distinction between CAN and CAN FD
> based on the frame length but rather to check whether it is possible =
to send the
> data section on that particular bus.
> But I think dropping CAN FD frames on non CAN FD interfaces is the ri=
ght choice
> in the long run.
>

Yep :-)

>> You need to make sure that the difference between CAN FD with 8 byte=
s and
>> CAN2.0 with 8 bytes does not get lost. So I would suggest to add an
>> additional attribute to each transfered CAN frame which tells you:
>>
>> - Is a CAN FD frame (or not)
>> - Has bitrate setting (CANFD_BRS) enabled (for CAN FD)
>
> Both flags make sense to me. Maybe we can use the MSB of LEN (so 0x80=
)
> to encode whether it is a CAN FD frame. The next byte is either
> the first DATA byte or FLAGS followed by the first DATA byte.

Yes. That was my intention too.

>> - Has error state (CANFD_ESI) enabled (for CAN FD)
>
> Do you think that this flag is necessary for two independent CAN buse=
s?
> When sending the frame on a physical bus, the error state of that
> interface/node can be different compared to the original sender.
> If host A receives a frame on bus A where CANFD_ESI is set and
> transmits it to host B which in return writes it to bus B, the CANFD_=
ESI
> bit will represent the state of a different node (host B instead of t=
he
> original sender).
> Maybe I am wrong, but I think that the CANFD_ESI flag needs to be
> masked prior to transmission on bus B.

Good catch. Indeed this was discussed at CAN in Automation too.
When you think of a gateway (in automotive) the original ESI bit can be=
=20
interesting for the receiver placed behind the gateway.

Therefore the ability to set the ESI bit explicitly in an outgoing CAN =
=46D=20
frame is specified for CAN controllers.

So the ESI bit on the wire is an OR'ed value of the value set into the=20
controllers registers and the internal state of the controller.
=46or your implementation this turns out to forward the ESI bit value t=
ransparently.

>
>>
>> My suggestion would be to add a single byte for each frame that cont=
ains
>> CANFD_BRS and CANFD_ESI as-is and e.g. 0x80 when this is a CAN FD fr=
ame.
>>
>> [...]
>> On the sender side 0x80 is OR'ed when the read frame length was CANF=
D_MTU.
>> And on the receiver a CAN or CAN FD frame is created based on 0x80 i=
n FLAGS.
>
> Sounds good.
>

:-)

Regards,
Oliver
