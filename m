From: "R U Local" <roystonvasey@slingshot.co.nz>
Subject: RE: RFC can-j1939
Date: Wed, 24 Feb 2016 16:05:50 +1300
Message-ID: <004d01d16eb0$445cd8d0$cd168a70$@slingshot.co.nz>
References: <006b01d16db9$1b9e94d0$52dbbe70$@slingshot.co.nz> <20160223100643.GA17694@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mta5.flip.co.nz ([103.9.40.8]:60574 "EHLO mta5.flip.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbcBXDGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2016 22:06:10 -0500
In-Reply-To: <20160223100643.GA17694@airbook.eia.lan>
Content-Language: en-nz
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Kurt Van Dijck' <dev.kurt@vandijck-laurijssen.be>
Cc: 'linux-can' <linux-can@vger.kernel.org>

>>=20
>> Dear Kurt,
>> Thanks for your great work.
>> I'm just bringing up the J1939 stack on a TI OMAP4 based system.
>> I'm locked to a custom kernel 3.19 due to media drivers and codecs.
>> I followed your guide and pulled code from 4.1 and 3.15 branches.

> I guessed you just merge the j1939d-3.15 branch, noth the 4.1.
Modified files in my kernel are now the same as your j1939d-v3.15 branc=
h but using memcpy_{from,to}_msg API.

>> I also patched and built can-utils and iproute2.

> iproute2 must not be patched anymore.
Back to standard iproute2

>> I can't get the Transport Protocol to work send only sends the first=
 packet and receive hangs on reception of the first packet.

> I walked through my quick starter guide and i realised I had not upda=
ted it for dealing with the j1939 socket closing before the transport p=
rotocol is ready.

> I just now updated my quick start guide. Can you try that, and tell w=
here exactly it goes wrong in your opinion.
Thanks for the update/information.
My test unit has two interfaces (can0 & can1) which I have connected to=
 the same bus. I have two terminals in separate sessions one for sendin=
g and one for receiving.
testj1939  -w1.0 -s20 can0:0x80 :,0x12300 now emits all frames when usi=
ng as seen with 'candump can1'.
testj1939 can1 -r shows no response from the above command.
testj1939 -w1.0 -s can0:0x80 :0x90,0x12300 only emits the first frame a=
s seen with 'candump can1'.
testj1939  can1:0x90 -r outputs the first frame (80 12300: 01 23 45 67 =
89 ab cd ef) when the above is issued

I've rebuilt the kernel with CAN_J1939_DEBUG configured but don=E2=80=99=
t have any additional messages.
I'll look a bit deeper tomorrow, any suggestions or hints would be welc=
omed.

>> As far as your RFC your implementation looks to be ideal for our app=
lications.
>> For user space applications where should the headers (<linux/can/can=
=2Eh> & <linux/can/j1939/j1939.h>) be taken from or provided by?

> Ideally, this becomes mainline and then you will sooner or later find=
 the header in linux/can/j1939.h. Up to then, you will need to fix your=
 toolchain manually by copying j1939.h there yourself.
That=E2=80=99s what I was thinking, I've updated my toolchain in the me=
antime.
> Do not forget that linux/can.h needs patching too.
That=E2=80=99s done.

> Kurt
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in=
 the body of a message to majordomo@vger.kernel.org More majordomo info=
 at  http://vger.kernel.org/majordomo-info.html

