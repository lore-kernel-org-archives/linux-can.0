From: Markus Uhle <markus.uhle@synergetik.de>
Subject: Re: Hilfe - Wohin Anfragen =?windows-1252?Q?bez=FCgl=2E_Socket?=
 =?windows-1252?Q?CAN/FlexCAN?=
Date: Wed, 15 Apr 2015 14:49:50 +0200
Message-ID: <552E5E6E.408@synergetik.de>
References: <552E55ED.7080904@synergetik.de> <552E5827.6010304@pengutronix.de> <552E59EC.9030408@pengutronix.de> <552E5D58.8030906@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from wp291.webpack.hosteurope.de ([80.237.133.60]:52689 "EHLO
	wp291.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751424AbbDONIk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Apr 2015 09:08:40 -0400
In-Reply-To: <552E5D58.8030906@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Thanks for your suggestions.
I will try to increase txqeuelen first and write the result in the=20
mailing list.

Am 15.04.2015 um 14:45 schrieb Oliver Hartkopp:
> On 15.04.2015 14:30, Marc Kleine-Budde wrote:
>> On 04/15/2015 02:23 PM, Marc Kleine-Budde wrote:
>>> Das ist richtig, diesen R=FCckgabewert gibt es nicht, da der Treibe=
r=20
>>> seine
>>> TX-Queue anh=E4lt, falls er keine Pakete mehr aufnehmen kann. Zur Z=
eit=20
>>> ist
>>> im Flexcan Treiber nur eine Queue mit der Tiefe von einem Paket
>>> implementiert. Die L=E4nge der Queue ist per default 10 Pakete. Das=
=20
>>> k=F6nnte
>>> Ihre Beobachtung erkl=E4ren. Vielleicht ist der BCM nicht darauf
>>> ausgelegt, dass nicht alle Pakete in der Queue laden.
>>>
>>> Ich schlage vor, dass Sie Ihre Problembeschreibung auf die Liste po=
sten
>>> und wir dort weiter diskutieren.
>>
>> Doh! Since I put the mailinglist by accident on Cc I'll recap the
>> problem for the audience.
>
> :-)
>
>>
>> Markus is using the flexcan on a imx53. He encounters a problem with=
 the
>> broadcast manager. When registering more than 12 messages (to be sen=
d
>> every 100ms) at the BCM, the 13th message delayed and only send ever=
y 1
>> to 10 seconds.
>>
>> I suspect the problem may be related with the default queue length o=
f 10
>> CAN frames per interface. The BCM might not handle -ENOBUFS correctl=
y.
>>
>> Markus, try to increase the TX queue length by:
>>
>>      ifconfig can0 txqueuelen 100
>>
>> or 1000.
>
> This would be my suggestion too.
>
> The BCM tries to fulfill the TX cycle as precise as possible.
> When Markus adds 12/13 TX jobs at a time these jobs are very close to=
=20
> each other from CAN frame duration perspective. So the jobs trigger=20
> nearly at the same time, generate a pile-up in the tx queue and the t=
x=20
> frames get dropped.
>
> So you can try to stretch the BCM setup in the way that you don't get=
=20
> pileups:
>
> - at creation time (wait between syscalls)
> - by using the two timer values and switch after one frame to the=20
> wanted cycle
>
> Or increase the txqueuelen - but you would still have a pile-up of=20
> frames which is probably not wanted at the receiver too (processing=20
> time issues).
>
> Regards,
> Oliver
>
>>
>> Marc
>>
>


