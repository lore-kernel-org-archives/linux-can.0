From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: ip -details link fails
Date: Wed, 27 May 2015 22:41:39 +0530
Message-ID: <BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc3s15.hotmail.com ([65.54.190.153]:59706 "EHLO
	BAY004-OMC3S15.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbbE0RLk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 27 May 2015 13:11:40 -0400
In-Reply-To: <5565F98E.5010101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Thanks for the response.

> On 05/27/2015 06:38 PM, Ssagarr Patil wrote:
>> I am currently using the following version of can driver
>> # cat /proc/net/can/version
>> rev 20120528 abi 9
>>
>
> This is network layer stuff.
> It does not tell you anything about CAN network interfaces.
>
OK
>> But when I do the following it fails,
>>
>> # ip -details link show can0
>> RTNETLINK answers: Invalid argument
>> Cannot send link get request: Invalid argument
>>
>> Transmitting and reciving of can frames works.
>
> Oh.
>
> I assume you use a CAN driver with is not in Linux mainline, e.g. the=
 PEAK
> driver. The PEAK driver is configured differently (see its documentat=
ion).
>
> Can you send the output of
>
> cat /proc/net/dev
>
> uname -a
>
> dmesg | grep -C 5 can0
>
=46ollowing is the log:

# ip -details link show wlan0
RTNETLINK answers: Invalid argument
Cannot send link get request: Invalid argument
# cat /proc/net/dev
Inter-|=A0=A0 Receive=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |=A0 Transmit
=A0face |bytes=A0=A0=A0 packets errs drop fifo frame compressed multica=
st|bytes=A0=A0=A0 packets errs drop fifo colls carrier compressed
=A0=A0=A0 lo:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=
=A0 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0
=A0teql0:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0=
=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
=A0 eth0:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0=
=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
=A0 can0:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0=
=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
=A0 can1:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0=
=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
=A0wlan0:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0=
=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
=A0 sit0:=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0=
=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0=
 0=A0=A0=A0 0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
#=A0 uname -a
Linux evm 2.6.37 #1 Wed May 6 10:43:07 BST 2015 armv7l ARMv7 Processor =
rev 2 (v7l) ti8148evm GNU/Linux
# dmesg | grep -C 5 can0
[=A0=A0=A0 8.320000] CAN device driver interface
[=A0=A0=A0 8.380000] <30>systemd[1]: Started Trigger Flushing of Journa=
l to Persistent Storage.
[=A0=A0=A0 8.410000] <30>systemd[1]: Found device /dev/ttyO0.
[=A0=A0=A0 8.420000] <30>systemd[1]: Started Recreate Volatile Files an=
d Directories.
[=A0=A0=A0 8.420000] <30>systemd[1]: Starting System Initialization.
[=A0=A0=A0 8.440000] PM: Adding info for No Bus:can0
[=A0=A0=A0 8.440000] c_can_platform d_can.0: c_can_platform device regi=
stered (regs=3Dfa1cc000, irq=3D52)
[=A0=A0=A0 8.440000] PM: Adding info for No Bus:can1
[=A0=A0=A0 8.440000] c_can_platform d_can.1: c_can_platform device regi=
stered (regs=3Dfa1d0000, irq=3D55)
[=A0=A0=A0 8.440000] <30>systemd[1]: Reached target System Initializati=
on.
[=A0=A0=A0 8.440000] <30>systemd[1]: Starting OpenSSH Socket.
--
[=A0=A0 38.570000] can: raw protocol (rev 20120528)
[=A0=A0 38.570000] hci0: type 1 len 36
[=A0=A0 38.580000] hci0: type 1 len 245
[=A0=A0 38.590000] hci0: type 1 len 7
[=A0=A0 38.600000] hci0: type 1 len 5
[=A0=A0 38.620000] c_can_platform d_can.0: can0: setting BTR=3D0504 BRP=
E=3D0000
[=A0=A0 38.630000] c_can_platform d_can.1: can1: setting BTR=3D0504 BRP=
E=3D0000
[ 1953.040000] sit: Unknown symbol xfrm4_tunnel_register (err 0)
[ 1953.050000] sit: Unknown symbol xfrm4_tunnel_deregister (err 0)
[ 1980.800000] ipcomp: Unknown symbol ipcomp_input (err 0)

Note: The Linux version is 2.6.37 but the network stack & CAN drivers a=
re from 3.14 kernel backports.

Thanks,
-Sagar

 		 	   		  