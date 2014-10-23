From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change
 handling.
Date: Thu, 23 Oct 2014 15:55:54 +0000
Message-ID: <5449250A.1040600@marel.com>
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
 <d724319b32e90fdbf258ae93bb35f8ef@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0070.outbound.protection.outlook.com ([65.55.169.70]:10496
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756006AbaJWPz6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Oct 2014 11:55:58 -0400
In-Reply-To: <d724319b32e90fdbf258ae93bb35f8ef@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


On fim 23.okt 2014 13:10, Wolfgang Grandegger wrote:
> On Thu, 23 Oct 2014 12:50:20 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
>> On mi=C3=B0 22.okt 2014 18:42, Wolfgang Grandegger wrote:
>>> On 10/22/2014 06:32 PM, Andri Yngvason wrote:
> ...
>>>> The data sheet says this about EPI:
>>>>     set; this bit is set whenever the CAN controller has
>>>>     reached the error passive status (at least one
>>>>     error counter exceeds the protocol-defined level of
>>>>     127) or if the CAN controller is in the error passive
>>>>     status and enters the error active status again and
>>>>     the EPIE bit is set within the interrupt enable
>>>>     register
>>>>
>>>> I'm a little bit concerned that it actually says that EPI is set o=
n
>>>> "error passive"
>>>> and "error passive to error active". However, the log says that
>>>> txerr=3D127 on
>>>> that second interrupt. It makes more sense for it to be "error
>>>> warning". Might
>>>> this be a error in the datasheet?
>>> IIRC, the CAN standard only knows error active and error passive.
>>> Various vendors added the warning level where the level is sometime=
s
>>> even programmable.
>> Yes, this makes sense. The manual doesn't even say that the "warning
>> level" is a
>> state.
> ...
>>>>  (000.053403)  can0  5B1   [5]  D1 D1 BB 7C DF
>>>>  (000.146664)  can0  506   [8]  2C 6E 9C 77 5E F1 AE 2D
>>>>  (000.053628)  can0  488   [8]  FF C8 AC 26 43 C5 AF 11
>>>>  (000.146428)  can0  5AD   [8]  C1 31 BD 1B 6B 8D 34 13
>>>>  (000.053112)  can0  658   [0]
>>>>  (000.171131)  can0  20000004   [8]  00 08 00 00 00 00 60 00 =20
>>>>  ERRORFRAME
>>>>     controller-problem{tx-error-warning}
>>>>     error-counter-tx-rx{{96}{0}}
>>>>  (000.013841)  can0  20000004   [8]  00 20 00 00 00 00 80 00 =20
>>>>  ERRORFRAME
>>>>     controller-problem{tx-error-passive}
>>>>     error-counter-tx-rx{{128}{0}}
>>>>  (004.433642)  can0  20000002   [8]  04 00 00 00 00 00 00 00 =20
>>>>  ERRORFRAME
>>>>     lost-arbitration{at bit 4}
>>>>  (000.014785)  can0  20000002   [8]  02 00 00 00 00 00 00 00 =20
>>>>  ERRORFRAME
>>>>     lost-arbitration{at bit 2}
>>>>  (000.012565)  can0  20000002   [8]  02 00 00 00 00 00 00 00 =20
>>>>  ERRORFRAME
>>>>     lost-arbitration{at bit 2}
>>>>  (000.000006)  can0  152   [8]  48 94 14 45 C3 60 8A 58
>>>>  (000.000015)  can0  6D7   [4]  3A B8 84 26
>>>>  (000.012537)  can0  20000002   [8]  02 00 00 00 00 00 00 00 =20
>>>>  ERRORFRAME
>>>>     lost-arbitration{at bit 2}
>>> Why do you see these errors? Are there electrical problems on the C=
AN
>>> bus? And if no cable is connected just txerr should increase (and
>>> decrease if it's reconnected!
>> These errors are occurring when I connect the cable again. They migh=
t be
>> due to bad contact while plugging in the cable.
> But you already receive *good* messages!
>
>> Anyway. Like I said before, the controller does not enter error acti=
ve
>> state unless
>> there is some other device sending on the bus. I've looked at "dmesg=
"
> and
>> there
>> isn't even an interrupt. The netlink interface also says error-warni=
ng.
> >From http://www.kvaser.com/about-can/the-can-protocol/can-error-hand=
ling/
>
> "The rules for increasing and decreasing the error counters are somew=
hat
> complex, but the principle is simple: transmit errors give 8 error po=
ints,
> and receive errors give 1 error point. Correctly transmitted and/or
> received messages causes the counter(s) to decrease."
> =20
>> When you were doing your experiments, did you perhaps have some node=
 on
>> the bus that might have answered to some of the cangen messages?
>>
>> In any case, my setup is like this:
>>  * Two sja1000 from the same peak_pci connected to the same bus.
>>  * Both send using cangen
>>  * Resistance: 60 Ohm
> Hm, the cable should be terminated with 120 Ohm on both ends of the c=
able.
> BTW: what bitrate do you use?
The bitrate is 125k.
root@x86-20140911-072109:~# ip -s -d link show can0
15: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP qle=
n 300
    link/can
    can state ERROR-ACTIVE restart-ms 50
    bitrate 125000 sample-point 0.875
    tq 1000 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    1          0          28         11         11         2       =20
    RX: bytes  packets  errors  dropped overrun mcast =20
    2216731    385309   0       0       0       0    =20
    TX: bytes  packets  errors  dropped carrier collsns
    2523021    391003   28      1       0       0    =20


Anyway, I got this working as you as you said it should work!

I moved the terminating resistors so that can0 and can1 are always term=
inated,
even when disconnected from the bus. I'm not sure why this works, but i=
t does.

Maybe the problem had something to do with the fact that can0 was just =
floating
when I disconnected it.

 ...
 (000.200059)  can0  761   [1]  19
 (000.200358)  can0  7C9   [5]  02 D4 FA 22 2F
 (000.200232)  can0  180   [7]  B8 BF 37 5E D0 EB 3C
 (000.224712)  can0  20000004   [8]  00 08 00 00 00 00 60 00   ERRORFRA=
ME
    controller-problem{tx-error-warning}
    error-counter-tx-rx{{96}{0}}
 (000.013858)  can0  20000004   [8]  00 20 00 00 00 00 80 00   ERRORFRA=
ME
    controller-problem{tx-error-passive}
    error-counter-tx-rx{{128}{0}}
 (006.130890)  can0  20F   [8]  4F A3 0A 5E FA F9 E0 58
 (000.000980)  can0  539   [8]  BF 4F 72 7C 82 E6 46 72
 (000.000513)  can0  70A   [1]  87
 ...
 (000.000914)  can0  14F   [7]  43 22 3E 76 B8 8E 2E
 (000.001031)  can0  7B6   [8]  31 EE 34 79 0E FB C0 0B
 (000.000687)  can0  73D   [4]  A0 B3 C1 35
 (000.013928)  can0  20000004   [8]  00 08 00 00 00 00 7F 00   ERRORFRA=
ME
    controller-problem{tx-error-warning}
    error-counter-tx-rx{{127}{0}}
 (000.000618)  can0  0D6   [3]  08 D5 D2
 (000.000689)  can0  14E   [4]  20 A2 A0 3A
 (000.000517)  can0  7C0   [1]  95
=2E..
 (000.199771)  can0  7B5   [3]  24 1D 09
 (000.200256)  can0  632   [6]  D9 29 E9 7A 34 71
 (000.200170)  can0  194   [7]  F8 B4 50 67 2B 9E BB
 (000.013881)  can0  20000004   [8]  00 40 00 00 00 00 5F 00   ERRORFRA=
ME
    controller-problem{back-to-error-active}
    error-counter-tx-rx{{95}{0}}
 (000.185735)  can0  71B   [0]
 (000.200622)  can0  090   [8]  62 29 1E 61 35 E3 FC 09
 (000.200080)  can0  628   [8]  C0 54 25 7B CE 56 02 7D
 (000.200605)  can0  13A   [8]  8F 07 70 3A B2 E5 82 29
 ...


- Andri
