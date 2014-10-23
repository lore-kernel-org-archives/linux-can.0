From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change  handling.
Date: Thu, 23 Oct 2014 15:10:14 +0200
Message-ID: <d724319b32e90fdbf258ae93bb35f8ef@grandegger.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
 <54463893.3090906@marel.com>
 <14598c49d530f22df994073aff17d729@grandegger.com>
 <5446742F.1010709@marel.com>
 <e539ac222118cfa107f96444d2415750@grandegger.com>
 <5447998A.5080601@marel.com>
 <bf2a11ad672de92b98dfcd31405d2c88@grandegger.com>
 <5447A78B.8090501@marel.com>
 <2acb44ee148c76e61617e7d9090c7180@grandegger.com>
 <5447DC34.7070602@marel.com> <5447FA7D.7060806@grandegger.com>
 <5448F98C.7000808@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:52223 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738AbaJWNKQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Oct 2014 09:10:16 -0400
In-Reply-To: <5448F98C.7000808@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org

On Thu, 23 Oct 2014 12:50:20 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> On mi=C3=B0 22.okt 2014 18:42, Wolfgang Grandegger wrote:
>> On 10/22/2014 06:32 PM, Andri Yngvason wrote:
=2E..
>>> The data sheet says this about EPI:
>>>     set; this bit is set whenever the CAN controller has
>>>     reached the error passive status (at least one
>>>     error counter exceeds the protocol-defined level of
>>>     127) or if the CAN controller is in the error passive
>>>     status and enters the error active status again and
>>>     the EPIE bit is set within the interrupt enable
>>>     register
>>>
>>> I'm a little bit concerned that it actually says that EPI is set on
>>> "error passive"
>>> and "error passive to error active". However, the log says that
>>> txerr=3D127 on
>>> that second interrupt. It makes more sense for it to be "error
>>> warning". Might
>>> this be a error in the datasheet?
>> IIRC, the CAN standard only knows error active and error passive.
>> Various vendors added the warning level where the level is sometimes
>> even programmable.
> Yes, this makes sense. The manual doesn't even say that the "warning
> level" is a
> state.
=2E..
>>>  (000.053403)  can0  5B1   [5]  D1 D1 BB 7C DF
>>>  (000.146664)  can0  506   [8]  2C 6E 9C 77 5E F1 AE 2D
>>>  (000.053628)  can0  488   [8]  FF C8 AC 26 43 C5 AF 11
>>>  (000.146428)  can0  5AD   [8]  C1 31 BD 1B 6B 8D 34 13
>>>  (000.053112)  can0  658   [0]
>>>  (000.171131)  can0  20000004   [8]  00 08 00 00 00 00 60 00 =20
>>>  ERRORFRAME
>>>     controller-problem{tx-error-warning}
>>>     error-counter-tx-rx{{96}{0}}
>>>  (000.013841)  can0  20000004   [8]  00 20 00 00 00 00 80 00 =20
>>>  ERRORFRAME
>>>     controller-problem{tx-error-passive}
>>>     error-counter-tx-rx{{128}{0}}
>>>  (004.433642)  can0  20000002   [8]  04 00 00 00 00 00 00 00 =20
>>>  ERRORFRAME
>>>     lost-arbitration{at bit 4}
>>>  (000.014785)  can0  20000002   [8]  02 00 00 00 00 00 00 00 =20
>>>  ERRORFRAME
>>>     lost-arbitration{at bit 2}
>>>  (000.012565)  can0  20000002   [8]  02 00 00 00 00 00 00 00 =20
>>>  ERRORFRAME
>>>     lost-arbitration{at bit 2}
>>>  (000.000006)  can0  152   [8]  48 94 14 45 C3 60 8A 58
>>>  (000.000015)  can0  6D7   [4]  3A B8 84 26
>>>  (000.012537)  can0  20000002   [8]  02 00 00 00 00 00 00 00 =20
>>>  ERRORFRAME
>>>     lost-arbitration{at bit 2}
>> Why do you see these errors? Are there electrical problems on the CA=
N
>> bus? And if no cable is connected just txerr should increase (and
>> decrease if it's reconnected!
> These errors are occurring when I connect the cable again. They might=
 be
> due to bad contact while plugging in the cable.

But you already receive *good* messages!

> Anyway. Like I said before, the controller does not enter error activ=
e
> state unless
> there is some other device sending on the bus. I've looked at "dmesg"
and
> there
> isn't even an interrupt. The netlink interface also says error-warnin=
g.

=46rom http://www.kvaser.com/about-can/the-can-protocol/can-error-handl=
ing/

"The rules for increasing and decreasing the error counters are somewha=
t
complex, but the principle is simple: transmit errors give 8 error poin=
ts,
and receive errors give 1 error point. Correctly transmitted and/or
received messages causes the counter(s) to decrease."
=20
> When you were doing your experiments, did you perhaps have some node =
on
> the bus that might have answered to some of the cangen messages?
>=20
> In any case, my setup is like this:
>  * Two sja1000 from the same peak_pci connected to the same bus.
>  * Both send using cangen
>  * Resistance: 60 Ohm

Hm, the cable should be terminated with 120 Ohm on both ends of the cab=
le.
BTW: what bitrate do you use?

Wolfgang.
