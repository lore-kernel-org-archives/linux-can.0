From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: flexcan napi poll and error frames
Date: Fri, 24 Oct 2014 14:39:29 +0000
Message-ID: <544A64A1.3050104@marel.com>
References: <544A2943.1080808@marel.com>
 <dcfa90aff443fa94ea617a9eabb97898@grandegger.com>
 <544A3034.8070907@marel.com>
 <a4a729ecfb73e4991e84a82136921b7a@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:58832
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751573AbaJXOjf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Oct 2014 10:39:35 -0400
In-Reply-To: <a4a729ecfb73e4991e84a82136921b7a@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>


On f=C3=B6s 24.okt 2014 12:33, Wolfgang Grandegger wrote:
> On Fri, 24 Oct 2014 10:55:48 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
>> On f=C3=B6s 24.okt 2014 10:43, Wolfgang Grandegger wrote:
>>> On Fri, 24 Oct 2014 10:26:11 +0000, Andri Yngvason
>>> <andri.yngvason@marel.com> wrote:
>>>> Hi,
>>>>
>>>> I was running some tests on my patches when I noticed the followin=
g:
>>>> If I have 2 flexcan devices on the bus, each sending to the bus us=
ing
>>>> cangen,and then I disconnect the cable to one of them, that device
>>>> will enter"error-warning" state, but it will not continue on to
>>>> "error-passive" as itshould.
>>>>
>>>> However, when I reconnect the cable, I get the "error-passive" mes=
sage
>>>> followed by an "error-warning" and eventually "back-to-error-activ=
e".
>>> Yes, I think I observed that behaviour as well as you can see here:
>>>
> https://gitorious.org/linux-can/wg-linux-can-next/commit/bd3acb12dbb9=
551541d28ae8766c154d3cf6ed57.patch
>> Good to know.
>>>> Notice the time differences:
>>>> root@(none):~# candump -td -e can0,0~0,#FFFFFFFFFF
>>>>  (000.000000)  can0  20000004   [8]  00 08 00 00 00 00 00 00 =20
>>> ERRORFRAME
>>>>         controller-problem{tx-error-warning}
>>>>  (006.493209)  can0  20000004   [8]  00 40 00 00 00 00 00 00 =20
>>> ERRORFRAME
>>>>         controller-problem{back-to-error-active}
>>>>  (002.701331)  can0  20000004   [8]  00 08 00 00 00 00 00 00 =20
>>> ERRORFRAME
>>>>         controller-problem{tx-error-warning}
>>>>  (006.498567)  can0  20000004   [8]  00 20 00 00 00 00 00 00 =20
>>> ERRORFRAME
>>>>         controller-problem{tx-error-passive}
>>>>  (000.013915)  can0  20000004   [8]  00 08 00 00 00 00 00 00 =20
>>> ERRORFRAME
>>>>         controller-problem{tx-error-warning}
>>>>  (001.990695)  can0  20000004   [8]  00 40 00 00 00 00 00 00 =20
>>> ERRORFRAME
>>>>         controller-problem{back-to-error-active}
>>>>
>>>>
>>>> I suspect that the problem is that the driver doesn't receive any
>>>> interruptsother than the one for "error-passive" and so things
>>>> won't "weigh" enoughfor napi. There seems to be some truth in this
>>>> conjecture, because when Itried setting the napi weight to 1, the
>>>> message got through.
>>> Hm, why should it depend on NAPI. It does not delay messages for
>>> a long time. I think the problem is that the state change is not
>>> signalled my an interrupt but some time later when another event
>>> (message) occurs.
>>> =20
>> Perhaps, but how do you explain that the message got through when I
>> set the weight to 1?
> If it's really true it would be a bug in the NAPI handling. Could you
> please elaborate a bit more by adding some printouts in the interrupt
> handler. I will have a closer look tomorrow.
I wasn't lying about it. Perhaps by changing the weight it got through =
with
something else. I don't know; I'm not an expert on the inner workings o=
f napi.

But let's just forget about the weight thing. I found out by looking in=
 the
i.mx6 reference manual that there is no interrupt for this transition. =
I
found that quite incredible so I searched through it a few times. Anywa=
y,
there are only interrupts for active->tx-warning, active->rx-warning an=
d
active->bus-off.

>
>>>> Another thing that I found peculiar was that I had to be sending o=
n
>>>> both devices for the error states to change to anything other than
>>>> "error-warning".
>>> Well, the error reporting on the SJA1000 is perfect... on all other
>>> CAN controllers it's more or less worse.
>>>
>> Should we just ignore this problem then? I'd rather like to figure
>> out if this is problem with the controller or not. Do you remember
>> if you've had this problem with flexcan?
> We can do little if the CAN controller does not notify the Software
> via interrupt.
Yes, that's why I wanted to figure out if it's a controller problem or =
not.
Turns out it's a controller problem, but perhaps we can work around it?
E.g. if we check esr for state changes every time someone transmits a
frame, both of these problems would go away. Would it be unacceptable
overhead to do so?

Cheers,
Andri
