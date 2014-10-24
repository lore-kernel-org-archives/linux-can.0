From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: flexcan napi poll and error frames
Date: Fri, 24 Oct 2014 16:04:56 +0000
Message-ID: <544A78A8.40909@marel.com>
References: <544A2943.1080808@marel.com>
 <dcfa90aff443fa94ea617a9eabb97898@grandegger.com>
 <544A3034.8070907@marel.com>
 <a4a729ecfb73e4991e84a82136921b7a@grandegger.com>
 <544A64A1.3050104@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0057.outbound.protection.outlook.com ([157.56.111.57]:38286
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756068AbaJXQFB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Oct 2014 12:05:01 -0400
In-Reply-To: <544A64A1.3050104@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>


On f=C3=B6s 24.okt 2014 14:39, Andri Yngvason wrote:
> On f=C3=B6s 24.okt 2014 12:33, Wolfgang Grandegger wrote:
>> On Fri, 24 Oct 2014 10:55:48 +0000, Andri Yngvason
>> <andri.yngvason@marel.com> wrote:
>>> On f=C3=B6s 24.okt 2014 10:43, Wolfgang Grandegger wrote:
>>>> On Fri, 24 Oct 2014 10:26:11 +0000, Andri Yngvason
>>>> <andri.yngvason@marel.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I was running some tests on my patches when I noticed the followi=
ng:
>>>>> If I have 2 flexcan devices on the bus, each sending to the bus u=
sing
>>>>> cangen,and then I disconnect the cable to one of them, that devic=
e
>>>>> will enter"error-warning" state, but it will not continue on to
>>>>> "error-passive" as itshould.
>>>>>
>>>>> However, when I reconnect the cable, I get the "error-passive" me=
ssage
>>>>> followed by an "error-warning" and eventually "back-to-error-acti=
ve".
>>>> Yes, I think I observed that behaviour as well as you can see here=
:
>>>>
>> https://gitorious.org/linux-can/wg-linux-can-next/commit/bd3acb12dbb=
9551541d28ae8766c154d3cf6ed57.patch
>>> Good to know.
>>>>
=2E..
>>>>
>>>> I suspect that the problem is that the driver doesn't receive any
>>>> interruptsother than the one for "error-passive" and so things
>>>> won't "weigh" enoughfor napi. There seems to be some truth in this
>>>> conjecture, because when Itried setting the napi weight to 1, the
>>>> message got through.
>>>> Hm, why should it depend on NAPI. It does not delay messages for
>>>> a long time. I think the problem is that the state change is not
>>>> signalled my an interrupt but some time later when another event
>>>> (message) occurs.
>>>> =20
>>> Perhaps, but how do you explain that the message got through when I
>>> set the weight to 1?
>> If it's really true it would be a bug in the NAPI handling. Could yo=
u
>> please elaborate a bit more by adding some printouts in the interrup=
t
>> handler. I will have a closer look tomorrow.
> I wasn't lying about it. Perhaps by changing the weight it got throug=
h with
> something else. I don't know; I'm not an expert on the inner workings=
 of napi.
>
> But let's just forget about the weight thing. I found out by looking =
in the
> i.mx6 reference manual that there is no interrupt for this transition=
=2E I
> found that quite incredible so I searched through it a few times. Any=
way,
> there are only interrupts for active->tx-warning, active->rx-warning =
and
> active->bus-off.
>
>>>>> Another thing that I found peculiar was that I had to be sending =
on
>>>>> both devices for the error states to change to anything other tha=
n
>>>>> "error-warning".
>>>> Well, the error reporting on the SJA1000 is perfect... on all othe=
r
>>>> CAN controllers it's more or less worse.
>>>>
>>> Should we just ignore this problem then? I'd rather like to figure
>>> out if this is problem with the controller or not. Do you remember
>>> if you've had this problem with flexcan?
>> We can do little if the CAN controller does not notify the Software
>> via interrupt.
> Yes, that's why I wanted to figure out if it's a controller problem o=
r not.
> Turns out it's a controller problem, but perhaps we can work around i=
t?
> E.g. if we check esr for state changes every time someone transmits a
> frame, both of these problems would go away. Would it be unacceptable
> overhead to do so?
>
I've just confirmed that this "fix" works, but only if berr-reporting i=
s
enabled.

Andri.
