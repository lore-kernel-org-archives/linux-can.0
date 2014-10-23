From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change handling.
Date: Thu, 23 Oct 2014 12:50:20 +0000
Message-ID: <5448F98C.7000808@marel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0066.outbound.protection.outlook.com ([65.55.169.66]:25632
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755510AbaJWMua (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Oct 2014 08:50:30 -0400
In-Reply-To: <5447FA7D.7060806@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


On mi=C3=B0 22.okt 2014 18:42, Wolfgang Grandegger wrote:
> On 10/22/2014 06:32 PM, Andri Yngvason wrote:
>> On mi=C3=B0 22.okt 2014 12:56, Wolfgang Grandegger wrote:
>>>>>>         restarted-after-bus-off
>>>>> And the restart does come when the short-circuit is gone?
>>>>>
>>>> No, in fact the bus keeps restarting until the short-circuit is go=
ne.
>>>>
>>>> Note that I'm using peak_pci. It's sja1000 but maybe there is some=
thing
>>>> different?
>>> No, because it's a memory mapped SJA1000 chip. What do you see with
>>> "dmesg"
>>> assuming that CONFIG_CAN_DEV_DEBUG is enabled.
>>>
>> dmesg wasn't very informative so I added some debug output of my own=
=2E This is
>> the output after I've fixed everything:
>> [ 3903.594640] peak_pci 0000:02:00.0: can1 at reg_base=3D0xf892a400
>> cfg_base=3D0xf8928000 irq=3D18
>> [ 3903.684937] peak_pci 0000:02:00.0 can1: setting BTR0=3D0x07 BTR1=3D=
0x05
>> [ 3922.009853] peak_pci 0000:02:00.0 can1: error warning interrupt; =
bs=3Dfalse,
>> es=3Dtrue
> According to the manual: error active -> warning
>
>> [ 3922.017428] peak_pci 0000:02:00.0 can1: state=3D1, txerr=3D96, rx=
err=3D1
>> [ 3922.023615] peak_pci 0000:02:00.0 can1: error passive interrupt; =
bs=3Dfalse,
>> es=3Dtrue
> warning -> error passive
>
>> [ 3922.031197] peak_pci 0000:02:00.0 can1: state=3D2, txerr=3D128, r=
xerr=3D1
>> [ 3928.401643] peak_pci 0000:02:00.0 can1: error passive interrupt; =
bs=3Dfalse,
>> es=3Dtrue
> error passive -> warning
>
>> [ 3928.409243] peak_pci 0000:02:00.0 can1: state=3D1, txerr=3D127, r=
xerr=3D0
>> [ 3934.804395] peak_pci 0000:02:00.0 can1: error warning interrupt; =
bs=3Dfalse,
>> es=3Dfalse
> warning -> error active
>
>> [ 3934.812075] peak_pci 0000:02:00.0 can1: state=3D0, txerr=3D95, rx=
err=3D0
>>
>> Note that, between the two passive interrupts, es does not change. T=
his is
>> correct according to
>> http://www.nxp.com/documents/data_sheet/SJA1000.pdf because ES only =
signifies
>> warning state.
>> Thus, "if (status & SR_ES)" is redundant.
>>
>> @@ -440,11 +446,14 @@ static int sja1000_err(struct net_device *dev,=
 uint8_t
>> isrc, uint8_t status)
>>      }
>>      if (isrc & IRQ_EPI) {
>>          /* error passive interrupt */
>> -        netdev_dbg(dev, "error passive interrupt\n");
>> -        if (status & SR_ES)
>> -            state =3D CAN_STATE_ERROR_PASSIVE;
>> +        netdev_dbg(dev, "error passive interrupt; bs=3D%s, es=3D%s\=
n",
>> +               status & SR_BS ? "true" : "false",
>> +               status & SR_ES ? "true" : "false");
>> +
>> +        if (state =3D=3D CAN_STATE_ERROR_PASSIVE)
>> +            state =3D CAN_STATE_ERROR_WARNING;
>>          else
>> -            state =3D CAN_STATE_ERROR_ACTIVE;
>> +            state =3D CAN_STATE_ERROR_PASSIVE;
>>      }
>>      if (isrc & IRQ_ALI) {
>>          /* arbitration lost interrupt */
>>
>> The data sheet says this about EPI:
>>     set; this bit is set whenever the CAN controller has
>>     reached the error passive status (at least one
>>     error counter exceeds the protocol-defined level of
>>     127) or if the CAN controller is in the error passive
>>     status and enters the error active status again and
>>     the EPIE bit is set within the interrupt enable
>>     register
>>
>> I'm a little bit concerned that it actually says that EPI is set on =
"error passive"
>> and "error passive to error active". However, the log says that txer=
r=3D127 on
>> that second interrupt. It makes more sense for it to be "error warni=
ng". Might
>> this be a error in the datasheet?
> IIRC, the CAN standard only knows error active and error passive.
> Various vendors added the warning level where the level is sometimes
> even programmable.
Yes, this makes sense. The manual doesn't even say that the "warning le=
vel" is a
state.
>
>> Another thing that worries me is that when I enabled debug, txerr wo=
uld advance
>> while the interrupt was being handled. This yielded mismatches betwe=
en
>> the new state and the actual current state of the error counters. I =
moved the
>> reading of the RXERR/TXERR registers to the top of the error handler=
 function
>> and that fixed the problem for me. Might this still be an issue on s=
lower
>> platforms?
> Yes, strictly speaking we cannot be sure that we read the correct err=
or
> counter when the state change is triggered via interrupt.
Ok, we'll just have to compare rxerr and txerr like before instead of u=
sing
errcnt_to_state.
>> candump looks like this:
>> ...
>>  (000.053403)  can0  5B1   [5]  D1 D1 BB 7C DF
>>  (000.146664)  can0  506   [8]  2C 6E 9C 77 5E F1 AE 2D
>>  (000.053628)  can0  488   [8]  FF C8 AC 26 43 C5 AF 11
>>  (000.146428)  can0  5AD   [8]  C1 31 BD 1B 6B 8D 34 13
>>  (000.053112)  can0  658   [0]
>>  (000.171131)  can0  20000004   [8]  00 08 00 00 00 00 60 00   ERROR=
=46RAME
>>     controller-problem{tx-error-warning}
>>     error-counter-tx-rx{{96}{0}}
>>  (000.013841)  can0  20000004   [8]  00 20 00 00 00 00 80 00   ERROR=
=46RAME
>>     controller-problem{tx-error-passive}
>>     error-counter-tx-rx{{128}{0}}
>>  (004.433642)  can0  20000002   [8]  04 00 00 00 00 00 00 00   ERROR=
=46RAME
>>     lost-arbitration{at bit 4}
>>  (000.014785)  can0  20000002   [8]  02 00 00 00 00 00 00 00   ERROR=
=46RAME
>>     lost-arbitration{at bit 2}
>>  (000.012565)  can0  20000002   [8]  02 00 00 00 00 00 00 00   ERROR=
=46RAME
>>     lost-arbitration{at bit 2}
>>  (000.000006)  can0  152   [8]  48 94 14 45 C3 60 8A 58
>>  (000.000015)  can0  6D7   [4]  3A B8 84 26
>>  (000.012537)  can0  20000002   [8]  02 00 00 00 00 00 00 00   ERROR=
=46RAME
>>     lost-arbitration{at bit 2}
> Why do you see these errors? Are there electrical problems on the CAN
> bus? And if no cable is connected just txerr should increase (and
> decrease if it's reconnected!
These errors are occurring when I connect the cable again. They might b=
e
due to bad contact while plugging in the cable.

Anyway. Like I said before, the controller does not enter error active =
state unless
there is some other device sending on the bus. I've looked at "dmesg" a=
nd there
isn't even an interrupt. The netlink interface also says error-warning.

When you were doing your experiments, did you perhaps have some node on
the bus that might have answered to some of the cangen messages?

In any case, my setup is like this:
 * Two sja1000 from the same peak_pci connected to the same bus.
 * Both send using cangen
 * Resistance: 60 Ohm
 * Cables are quite short.

I'll try to place the resistances differently, make cables shorter and =
see if that
does anything.
>>  (000.014083)  can0  2E7   [7]  A2 6F F8 5F DF DD 3B
>>  (000.000904)  can0  757   [8]  4F 0E AB 57 C3 58 DB 75
>>  (000.000680)  can0  459   [5]  52 52 58 29 8C
>> ...
>>  (000.000546)  can0  3C7   [2]  18 AC
>>  (000.000875)  can0  130   [8]  B3 57 0A 52 CC CA D3 08
>>  (000.015962)  can0  5DF   [8]  64 14 6C 61 F9 FD E9 55
>>  (000.000023)  can0  5D2   [8]  C5 B2 39 6B 65 45 4C 05
>>  (000.014554)  can0  20000002   [8]  03 00 00 00 00 00 00 00   ERROR=
=46RAME
>>     lost-arbitration{at bit 3}
>>  (000.000008)  can0  2FC   [8]  19 73 77 6C 86 91 D5 58
>> ...
>>  (000.053183)  can0  7A1   [6]  F8 EE 7B 12 A3 43
>>  (000.146734)  can0  089   [5]  36 B8 A0 4F DD
>>  (000.014032)  can0  20000004   [8]  00 0C 00 00 00 00 7F 74   ERROR=
=46RAME
>>     controller-problem{rx-error-warning,tx-error-warning}
>>     error-counter-tx-rx{{127}{116}}
>>  (000.039316)  can0  684   [6]  ED D1 1E 32 00 1D
>>  (000.146892)  can0  0D1   [8]  CD 99 DE 18 62 B0 45 27
>>  (000.053317)  can0  687   [8]  43 37 CF 5E 6B A4 CA 3D
>> ...
>>  (000.053561)  can0  42A   [4]  65 20 3B 5C
>>  (000.146834)  can0  3C2   [8]  32 50 A4 56 31 EC DD 55
>>  (000.013948)  can0  20000004   [8]  00 40 00 00 00 00 5F 54   ERROR=
=46RAME
>>     controller-problem{back-to-error-active}
>>     error-counter-tx-rx{{95}{84}}
>>  (000.039372)  can0  455   [5]  58 38 31 62 B6
>> ...
>>
- Andri
