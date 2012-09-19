From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Wed, 19 Sep 2012 08:50:56 +0200
Message-ID: <50596B50.901@grandegger.com>
References: <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de> <50587987.3070308@grandegger.com> <50587A4F.5060105@pengutronix.de> <5058C28A.5030300@grandegger.com> <5058C505.6020605@pengutronix.de> <5058C7EC.1080206@grandegger.com> <20120918202018.GA78585@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40918 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2ISGvG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 02:51:06 -0400
In-Reply-To: <20120918202018.GA78585@macbook.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/18/2012 10:20 PM, Kurt Van Dijck wrote:
> On Tue, Sep 18, 2012 at 09:13:48PM +0200, Wolfgang Grandegger wrote:
>> On 09/18/2012 09:01 PM, Marc Kleine-Budde wrote:
>>> On 09/18/2012 08:50 PM, Wolfgang Grandegger wrote:
>>>> On 09/18/2012 03:42 PM, Marc Kleine-Budde wrote:
>>>>> On 09/18/2012 03:39 PM, Wolfgang Grandegger wrote:
>>>>>> On 09/18/2012 03:00 PM, Marc Kleine-Budde wrote:
>>>>>>> On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>>>> We have several customers who asked how to abort pending TX m=
essages,
>>>>>>>>> too. Which involves:
>>>>>>>>> a) clear the TX-queue in Linux
>>>>>>>>> b) clear queue in hardware
>>>>>>>>> c) abort currently transmitting CAN frame
>>>>>>>>>
>>>>>>>>> I think c) would be a usecase of its own, too.
>>>>>>>>
>>>>>>>> I think you need c) for b), at least for some controllers. The=
se
>>>>>>>
>>>>>>> Yes, if it's a hardware limitation so be it. But if we design a=
n
>>>>>>> interface it should support "clear everything" (a+b+c), but als=
o just
>>>>>>> only c.
>>>>>>
>>>>>> Yes, that you be nice. The only portable "clear everything" (a+b=
+c) I
>>>>>> see is "ifconfig down -> up". This also answers you other relate=
d mail.
>>>>>>
>>>>>> What do people really want/need and why? This is still not clear=
 to me.
>>>>>> More input would be nice.
>>>>>
>>>>> Heinz-J=FCrgen uses abort current TX Message on SJA1000, can you =
give us
>>>>> more insight? I've talked to customers, e.g. they want to abort t=
he
>>>>> current frame if it takes "too long" to send it, because the fram=
es CAN
>>>>> id priority is too low.
>=20
> If "too long" is defined as a period of time where it makes sense to
> take such actions in software (like > 10msec), and your message still
> did not get out, but you wanted it to be,
> then IMO the bus load is too high with regard to the expected time re=
strictions.
>=20
> Or am I missing something?
>=20
>>>>
>>>> What we could implement rather easily is a "tx-abort-last" or
>>>> "tx-abort-all" netlink command. As this command does not make sens=
e when
>>>> more than one message is pending I'm in favor of "tx-abort-last".
>>>
>>> I like to have both commands.
>>
>> But then "tx-abort-all" should also clear the tx socket queue. Also =
be
>> aware that more than one socket may send messages. Let's wait for mo=
re
>> use-cases.
>=20
> I'm afraid tx-abort-all & tx-abort-last cause more damage than good,
> especially, but not only, in multi-user environments.

At least it's incompatible with multi-user (-sender) support and it doe=
s
not fit into the Linux networking principles! And so far I have not
heard strong arguments for implementing message flush and abort. I stil=
l
believe that a device stop->restart is enough to cure such problems. Bu=
t
let's wait and see.

Wolfgang.
