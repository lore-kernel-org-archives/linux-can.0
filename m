From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem using Linux CAN
Date: Wed, 22 Jul 2015 19:41:46 +0200
Message-ID: <55AFD5DA.7010601@hartkopp.net>
References: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:41651 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119AbbGVRlw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 13:41:52 -0400
In-Reply-To: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Hotfilter <thotfilter@osdr.org>, linux-can@vger.kernel.org

On 22.07.2015 12:49, Tim Hotfilter wrote:

> I am developing a control unit using four CAN Controllers based on th=
e Xilinx Zynq 7000. Two CAN Controllers (based on the sja1000) are impl=
emented in the Zynq=E2=80=99s FPGA and two are already integrated. The =
control unit runs Linux 3.19 with socket can.
> Under higher CAN busload (30% or more) socket CAN returns Error 105: =
No buffer space available.

How did you get this error?
What tools/kernel/distro are you using?

Did you try 'cangen' from https://github.com/linux-can/can-utils ?

Regards,
Oliver

> The problem is independent from the hardware, it occurs on both sja10=
00 and xilinx can. Restarting the network device by bringing it down an=
d up enables to send again. But since there are other ECUs using watchd=
ogs this solution is not suitable.
> After some kernel debugging it exposes that somehow a transmit interr=
upt gets lost. This results in a stopped tx queue and the transmit buff=
er overflows.
>
> Is there a possibility to handle with the lost interrupt, like waking=
 up the queue after a short timeout?
>
> Thank you in advance!
>
> Best regards
> Tim Hotfilter
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
