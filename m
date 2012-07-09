From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 13:57:11 +0200
Message-ID: <CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
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
	<4FFAC346.7060201@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49888 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab2GIL5M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 07:57:12 -0400
Received: by yenl2 with SMTP id l2so9939771yen.19
        for <linux-can@vger.kernel.org>; Mon, 09 Jul 2012 04:57:11 -0700 (PDT)
In-Reply-To: <4FFAC346.7060201@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

If i have understood you correctly, I think it must change the period
if the write function is a synchronous call !
if my function is like this :

while(1)
{
    nannosleep(1000000);
    write (myFrame in opened CAN socket);
}

then the result is 1ms + timeOf (write) for every iteration.
but if the write call is asynchronous we return to case you mentioned !

Is this correct ?

On Mon, Jul 9, 2012 at 1:40 PM, Wolfgang Grandegger <wg@grandegger.com>=
 wrote:
> Please do not drop the CC to the Linux-CAN mailing list...
>
> On 07/09/2012 01:25 PM, Mohamed HAMZAOUI wrote:
>> I think that is caused by Socketcan. Maybe, the nannosecond sleep is
>> correct but when the system call write on a CAN socket it takes 0.3 =
ms
>> to inject the data on the bus
>>
>> |_______________________________|_____________|
>> nannosleep        1000=E7=9B=9C                  call        300=E7=9B=
=9C    real sending time
>>
>> It's this possible and if this is true can i assume a fix 0.3 ms in
>> all my period ?
>
> Even if it takes 0.3ms to get the message out to the bus, it should n=
ot
> change the period if you program clock_nanosleep() properly (waiting =
on
> the next 1ms period).
>
> Wolfgang.
