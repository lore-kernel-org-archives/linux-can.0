From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan napi poll and error frames
Date: Fri, 24 Oct 2014 21:08:48 +0200
Message-ID: <544AA3C0.1010906@grandegger.com>
References: <544A2943.1080808@marel.com> <dcfa90aff443fa94ea617a9eabb97898@grandegger.com> <544A3034.8070907@marel.com> <a4a729ecfb73e4991e84a82136921b7a@grandegger.com> <544A64A1.3050104@marel.com> <544A78A8.40909@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54760 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaJXTIv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Oct 2014 15:08:51 -0400
In-Reply-To: <544A78A8.40909@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

On 10/24/2014 06:04 PM, Andri Yngvason wrote:
>=20
> On f=C3=B6s 24.okt 2014 14:39, Andri Yngvason wrote:
>> On f=C3=B6s 24.okt 2014 12:33, Wolfgang Grandegger wrote:
>>> On Fri, 24 Oct 2014 10:55:48 +0000, Andri Yngvason
>>> <andri.yngvason@marel.com> wrote:
>>>> On f=C3=B6s 24.okt 2014 10:43, Wolfgang Grandegger wrote:
>>>>> On Fri, 24 Oct 2014 10:26:11 +0000, Andri Yngvason
>>>>> <andri.yngvason@marel.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I was running some tests on my patches when I noticed the follow=
ing:
>>>>>> If I have 2 flexcan devices on the bus, each sending to the bus =
using
>>>>>> cangen,and then I disconnect the cable to one of them, that devi=
ce
>>>>>> will enter"error-warning" state, but it will not continue on to
>>>>>> "error-passive" as itshould.
>>>>>>
>>>>>> However, when I reconnect the cable, I get the "error-passive" m=
essage
>>>>>> followed by an "error-warning" and eventually "back-to-error-act=
ive".
>>>>> Yes, I think I observed that behaviour as well as you can see her=
e:
>>>>>
>>> https://gitorious.org/linux-can/wg-linux-can-next/commit/bd3acb12db=
b9551541d28ae8766c154d3cf6ed57.patch
>>>> Good to know.
>>>>>
> ...
>>>>>
>>>>> I suspect that the problem is that the driver doesn't receive any
>>>>> interruptsother than the one for "error-passive" and so things
>>>>> won't "weigh" enoughfor napi. There seems to be some truth in thi=
s
>>>>> conjecture, because when Itried setting the napi weight to 1, the
>>>>> message got through.
>>>>> Hm, why should it depend on NAPI. It does not delay messages for
>>>>> a long time. I think the problem is that the state change is not
>>>>> signalled my an interrupt but some time later when another event
>>>>> (message) occurs.
>>>>> =20
>>>> Perhaps, but how do you explain that the message got through when =
I
>>>> set the weight to 1?
>>> If it's really true it would be a bug in the NAPI handling. Could y=
ou
>>> please elaborate a bit more by adding some printouts in the interru=
pt
>>> handler. I will have a closer look tomorrow.
>> I wasn't lying about it. Perhaps by changing the weight it got throu=
gh with
>> something else. I don't know; I'm not an expert on the inner working=
s of napi.
>>
>> But let's just forget about the weight thing. I found out by looking=
 in the
>> i.mx6 reference manual that there is no interrupt for this transitio=
n. I
>> found that quite incredible so I searched through it a few times. An=
yway,
>> there are only interrupts for active->tx-warning, active->rx-warning=
 and
>> active->bus-off.
>>
>>>>>> Another thing that I found peculiar was that I had to be sending=
 on
>>>>>> both devices for the error states to change to anything other th=
an
>>>>>> "error-warning".
>>>>> Well, the error reporting on the SJA1000 is perfect... on all oth=
er
>>>>> CAN controllers it's more or less worse.
>>>>>
>>>> Should we just ignore this problem then? I'd rather like to figure
>>>> out if this is problem with the controller or not. Do you remember
>>>> if you've had this problem with flexcan?
>>> We can do little if the CAN controller does not notify the Software
>>> via interrupt.
>> Yes, that's why I wanted to figure out if it's a controller problem =
or not.
>> Turns out it's a controller problem, but perhaps we can work around =
it?
>> E.g. if we check esr for state changes every time someone transmits =
a
>> frame, both of these problems would go away. Would it be unacceptabl=
e
>> overhead to do so?
>>
> I've just confirmed that this "fix" works, but only if berr-reporting=
 is
> enabled.

Ah, oh, this reminds me that there is a related bug in some versions of
the FLEXCAN core. If you look to "flexcan.c" you will find:

#define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* [TR]WRN INT not connecte=
d */

On these cores bus-error reporting is required to realize these state
changes.

Wolfgang.

