From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Hilfe - Wohin Anfragen =?windows-1252?Q?bez=FCgl=2E_Socket?=
 =?windows-1252?Q?CAN/FlexCAN?=
Date: Wed, 15 Apr 2015 14:45:12 +0200
Message-ID: <552E5D58.8030906@hartkopp.net>
References: <552E55ED.7080904@synergetik.de> <552E5827.6010304@pengutronix.de> <552E59EC.9030408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:14178 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbDOMpV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Apr 2015 08:45:21 -0400
In-Reply-To: <552E59EC.9030408@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Markus Uhle <markus.uhle@synergetik.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.04.2015 14:30, Marc Kleine-Budde wrote:
> On 04/15/2015 02:23 PM, Marc Kleine-Budde wrote:
>> Das ist richtig, diesen R=FCckgabewert gibt es nicht, da der Treiber=
 seine
>> TX-Queue anh=E4lt, falls er keine Pakete mehr aufnehmen kann. Zur Ze=
it ist
>> im Flexcan Treiber nur eine Queue mit der Tiefe von einem Paket
>> implementiert. Die L=E4nge der Queue ist per default 10 Pakete. Das =
k=F6nnte
>> Ihre Beobachtung erkl=E4ren. Vielleicht ist der BCM nicht darauf
>> ausgelegt, dass nicht alle Pakete in der Queue laden.
>>
>> Ich schlage vor, dass Sie Ihre Problembeschreibung auf die Liste pos=
ten
>> und wir dort weiter diskutieren.
>
> Doh! Since I put the mailinglist by accident on Cc I'll recap the
> problem for the audience.

:-)

>
> Markus is using the flexcan on a imx53. He encounters a problem with =
the
> broadcast manager. When registering more than 12 messages (to be send
> every 100ms) at the BCM, the 13th message delayed and only send every=
 1
> to 10 seconds.
>
> I suspect the problem may be related with the default queue length of=
 10
> CAN frames per interface. The BCM might not handle -ENOBUFS correctly=
=2E
>
> Markus, try to increase the TX queue length by:
>
>      ifconfig can0 txqueuelen 100
>
> or 1000.

This would be my suggestion too.

The BCM tries to fulfill the TX cycle as precise as possible.
When Markus adds 12/13 TX jobs at a time these jobs are very close to e=
ach=20
other from CAN frame duration perspective. So the jobs trigger nearly a=
t the=20
same time, generate a pile-up in the tx queue and the tx frames get dro=
pped.

So you can try to stretch the BCM setup in the way that you don't get p=
ileups:

- at creation time (wait between syscalls)
- by using the two timer values and switch after one frame to the wante=
d cycle

Or increase the txqueuelen - but you would still have a pile-up of fram=
es=20
which is probably not wanted at the receiver too (processing time issue=
s).

Regards,
Oliver

>
> Marc
>
