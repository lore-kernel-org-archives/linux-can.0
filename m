From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 21:13:48 +0200
Message-ID: <5058C7EC.1080206@grandegger.com>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de> <50587987.3070308@grandegger.com> <50587A4F.5060105@pengutronix.de> <5058C28A.5030300@grandegger.com> <5058C505.6020605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46384 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383Ab2IRTOP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 15:14:15 -0400
In-Reply-To: <5058C505.6020605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/18/2012 09:01 PM, Marc Kleine-Budde wrote:
> On 09/18/2012 08:50 PM, Wolfgang Grandegger wrote:
>> On 09/18/2012 03:42 PM, Marc Kleine-Budde wrote:
>>> On 09/18/2012 03:39 PM, Wolfgang Grandegger wrote:
>>>> On 09/18/2012 03:00 PM, Marc Kleine-Budde wrote:
>>>>> On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
>>>>> [...]
>>>>>
>>>>>>> We have several customers who asked how to abort pending TX mes=
sages,
>>>>>>> too. Which involves:
>>>>>>> a) clear the TX-queue in Linux
>>>>>>> b) clear queue in hardware
>>>>>>> c) abort currently transmitting CAN frame
>>>>>>>
>>>>>>> I think c) would be a usecase of its own, too.
>>>>>>
>>>>>> I think you need c) for b), at least for some controllers. These
>>>>>
>>>>> Yes, if it's a hardware limitation so be it. But if we design an
>>>>> interface it should support "clear everything" (a+b+c), but also =
just
>>>>> only c.
>>>>
>>>> Yes, that you be nice. The only portable "clear everything" (a+b+c=
) I
>>>> see is "ifconfig down -> up". This also answers you other related =
mail.
>>>>
>>>> What do people really want/need and why? This is still not clear t=
o me.
>>>> More input would be nice.
>>>
>>> Heinz-J=FCrgen uses abort current TX Message on SJA1000, can you gi=
ve us
>>> more insight? I've talked to customers, e.g. they want to abort the
>>> current frame if it takes "too long" to send it, because the frames=
 CAN
>>> id priority is too low.
>>
>> What we could implement rather easily is a "tx-abort-last" or
>> "tx-abort-all" netlink command. As this command does not make sense =
when
>> more than one message is pending I'm in favor of "tx-abort-last".
>=20
> I like to have both commands.

But then "tx-abort-all" should also clear the tx socket queue. Also be
aware that more than one socket may send messages. Let's wait for more
use-cases.

Wolfgang.


