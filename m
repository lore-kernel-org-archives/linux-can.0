From: Tim Hotfilter <thotfilter@osdr.org>
Subject: Re: Problem using Linux CAN
Date: Wed, 22 Jul 2015 19:52:09 +0200
Message-ID: <A0E5883A-3FBB-4060-8A38-A32DA743B16B@osdr.org>
References: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org> <55AFD5DA.7010601@hartkopp.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dd20724.kasserver.com ([85.13.140.203]:42394 "EHLO
	dd20724.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbbGVRwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 13:52:19 -0400
In-Reply-To: <55AFD5DA.7010601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Thank you for you quick answer.=20
I am using a kernel image from Xilinx git hub and cangen to generate st=
atic load. I get this error as result in cangen after a while.=20

Thank you

Regards,
Tim Hotfilter=20

>> On 22 Jul 2015, at 19:41, Oliver Hartkopp <socketcan@hartkopp.net> w=
rote:
>>=20
>> On 22.07.2015 12:49, Tim Hotfilter wrote:
>>=20
>> I am developing a control unit using four CAN Controllers based on t=
he Xilinx Zynq 7000. Two CAN Controllers (based on the sja1000) are imp=
lemented in the Zynq=E2=80=99s FPGA and two are already integrated. The=
 control unit runs Linux 3.19 with socket can.
>> Under higher CAN busload (30% or more) socket CAN returns Error 105:=
 No buffer space available.
>=20
> How did you get this error?
> What tools/kernel/distro are you using?
>=20
> Did you try 'cangen' from https://github.com/linux-can/can-utils ?
>=20
> Regards,
> Oliver
>=20
>> The problem is independent from the hardware, it occurs on both sja1=
000 and xilinx can. Restarting the network device by bringing it down a=
nd up enables to send again. But since there are other ECUs using watch=
dogs this solution is not suitable.
>> After some kernel debugging it exposes that somehow a transmit inter=
rupt gets lost. This results in a stopped tx queue and the transmit buf=
fer overflows.
>>=20
>> Is there a possibility to handle with the lost interrupt, like wakin=
g up the queue after a short timeout?
>>=20
>> Thank you in advance!
>>=20
>> Best regards
>> Tim Hotfilter
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
