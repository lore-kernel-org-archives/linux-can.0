From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: GS_USB
Date: Mon, 11 Nov 2013 22:49:39 +0100
Message-ID: <528150F3.8090406@hartkopp.net>
References: <1380889887.22484.2.camel@blackbox>  <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>  <5e3f6029b128db63c69664deed10c5d6@grandegger.com>  <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>  <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>  <1384135835.3749.31.camel@blackbox>  <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>  <5280FAB2.3030600@hartkopp.net> <1384199350.3483.20.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:8893 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab3KKVtm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2013 16:49:42 -0500
In-Reply-To: <1384199350.3483.20.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>



On 11.11.2013 20:49, Max S. wrote:
> Hmm. Seems I missed something.
>=20


>>>
>>> http://lxr.free-electrons.com/source/Documentation/networking/can.t=
xt#L891
>>>
>>>
>>
>> Yes.
>>
>> Usually the CAN controller sits in BUS_OFF until it detects correct =
CAN frames
>> _or_ until the controller is re-initialized.
>=20
> From the CAN2.0A spec chapter 7
> 12. An node which is =E2=80=99bus off=E2=80=99 is permitted to become=
 =E2=80=99error active=E2=80=99 (no
> longer =E2=80=99bus off=E2=80=99) with its error counters both set to=
 0 after 128
> occurrence of 11 consecutive =E2=80=99recessive=E2=80=99 bits have be=
en monitored on the
> bus.

Hm - I assume this does not mean 128*11 bits but 128 occurences of 11
consecutive =E2=80=99recessive=E2=80=99 bits with at least one dominant=
 bit in between.
But I'm not sure about that.

>=20
> So: When the controller goes into bus off because of a short on can h=
igh
> to low. It will inevitably observe recessive bits. and consequently c=
ome
> back out of bus off. It will then attempt to resend and hit bus off
> again. rinse & repeat.


>=20
> Why is it necessary to be able to get the controller out of bus off
> manually?

Think about a misconfigured bitrate.
The application should decide if it's better to stay calm (in BUS_OFF) =
or
whether it should try to re-initialize the CAN controller and start aga=
in.

>=20
> I was able to improve the firmware to make status updates faster.
> The following is the current state: @250K bitrate
>  (000.000011)  can0  20000040   [8]  00 00 00 00 00 00 00 01  ERRORFR=
AME
> 	bus-off
> 	error-counter-tx-rx{{0}{1}}
>  (000.005980)  can0  20000100   [8]  00 00 00 00 00 00 00 80  ERRORFR=
AME
> 	restarted-after-bus-off
> 	error-counter-tx-rx{{0}{128}}
>  (000.000013)  can0  20000008   [8]  00 00 40 00 00 00 00 00  ERRORFR=
AME
> 	protocol-violation{{back-to-error-active}{}}
>  (000.000006)  can0  20000004   [8]  00 08 00 00 00 00 60 00  ERRORFR=
AME
> 	controller-problem{tx-error-warning}
> 	error-counter-tx-rx{{96}{0}}
>  (000.000008)  can0  20000004   [8]  00 20 00 00 00 00 80 00  ERRORFR=
AME
> 	controller-problem{tx-error-passive}
> 	error-counter-tx-rx{{128}{0}}
>  (000.002014)  can0  20000040   [8]  00 00 00 00 00 00 00 01  ERRORFR=
AME
> 	bus-off
> 	error-counter-tx-rx{{0}{1}}
>=20
>>
>> The CAN controller should not recover itself as this might be wrong =
depending
>> on the use-case.
>=20
> Is recovery (getting out of bus off) not part of the CAN spec?

As discussed above the controller get's out of the BUS_OFF state when
receiving correct CAN traffic.

Or by kicking the controller by restarting it :-)

>=20
>>
>> Therefore the manual "restart" can be initiated by some user applica=
tion or it
>> can be handled inside the driver e.g. 200ms after a BUS_OFF detectio=
n by the
>> "restart-ms" option.
>>

Regards,
Oliver
