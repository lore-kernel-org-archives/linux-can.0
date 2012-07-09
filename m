From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Fwd: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 13:26:02 +0200
Message-ID: <CABMxt4iE14uST__yPbYLsADsL3LvpG1p2i_tTK9Lhpcj4UP+ow@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<4FF55274.3030006@volkswagen.de>
	<CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
	<4FF8102C.8030609@grandegger.com>
	<CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com>
	<4FF9E9E4.4090602@grandegger.com>
	<CABMxt4jXZMcnRRSrrV8tXnAQFUndFLdysw2r4R2PrzqE=jUMkA@mail.gmail.com>
	<4FFA85B3.5080800@grandegger.com>
	<CABMxt4jXUqtEyyhbnm80CW2CVQ7CD2He3ectdivn+aTodu+Y5w@mail.gmail.com>
	<4FFA9466.3040600@grandegger.com>
	<CABMxt4jkBNzjWtpRn5YJHyEOGu-XN7ehTZOXCt3pxLr81aH_Bg@mail.gmail.com>
	<4FFAA2D7.4010905@grandegger.com>
	<CABMxt4jnztXqAmLFcBnqp3001QXds1nX3xA2y_ka=xCNr0cjjA@mail.gmail.com>
	<4FFAB09F.6090800@grandegger.com>
	<CABMxt4jLRKz8xKNbH3Qa=P0k1aEjMsqmo2vArGDo2O1Wf0=wGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61935 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab2GIL0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 07:26:03 -0400
Received: by yhmm54 with SMTP id m54so10723787yhm.19
        for <linux-can@vger.kernel.org>; Mon, 09 Jul 2012 04:26:02 -0700 (PDT)
In-Reply-To: <CABMxt4jLRKz8xKNbH3Qa=P0k1aEjMsqmo2vArGDo2O1Wf0=wGQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

I think that is caused by Socketcan. Maybe, the nannosecond sleep is
correct but when the system call write on a CAN socket it takes 0.3 ms
to inject the data on the bus

|_______________________________|_____________|
nannosleep        1000=C2=B5s                  call        300=C2=B5s  =
  real sending time

It's this possible and if this is true can i assume a fix 0.3 ms in
all my period ?

Regards
Mohamed

On Mon, Jul 9, 2012 at 12:21 PM, Wolfgang Grandegger <wg@grandegger.com=
> wrote:
> On 07/09/2012 11:54 AM, Mohamed HAMZAOUI wrote:
>> Jitter : +- 10=E7=9B=9C (1% of the period)
>
> That's *not* achievable with the hardware you us! Neither with
> preempt-rt nor with Xenomai.
>
>> I test with 700000 ns 0.7ms and i have 1ms of period but I think it'=
s
>> not usually true because it's probably depend of the CPU load !
>
> Wired, don't know where the 300us get lost systematically.
>
> Wolfgang
