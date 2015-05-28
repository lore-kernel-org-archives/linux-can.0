From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: ip -details link fails
Date: Thu, 28 May 2015 15:18:31 +0530
Message-ID: <BAY176-W52B59690F5605C23AA3A3D3CA0@phx.gbl>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net>,<BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl>
 <5565FDE5.1040908@hartkopp.net>,<55661810.3050407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc4s26.hotmail.com ([65.54.190.231]:49855 "EHLO
	BAY004-OMC4S26.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753419AbbE1Jsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 May 2015 05:48:31 -0400
In-Reply-To: <55661810.3050407@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

>
> On 05/27/2015 07:24 PM, Oliver Hartkopp wrote:
>>> # ip -details link show wlan0
>>> RTNETLINK answers: Invalid argument
>>> Cannot send link get request: Invalid argument
>>
>> The fact that your 'ip' tool doesn't work with wlan0 too your proble=
m is
>> probably not CAN related.
>
> BTW: the busybox version of ip doesn't talk can.
>
I am not using the ip from the busybox,=20
I am using the release version from [1] (# ip -V
ip utility, iproute2-ss150413)


# ip -details link show can0
RTNETLINK answers: Invalid argument
Cannot send link get request: Invalid argument
#=20

#=A0 dmesg | grep -C 5 can0
[=A0=A0=A0 6.510000] <30>systemd[1]: Found device /dev/ttyO0.
[=A0=A0=A0 6.530000] <30>systemd[1]: Started Recreate Volatile Files an=
d Directories.
[=A0=A0=A0 6.530000] <30>systemd[1]: Starting System Initialization.
[=A0=A0=A0 6.540000] <30>systemd[1]: Reached target System Initializati=
on.
[=A0=A0=A0 6.540000] <30>systemd[1]: Starting OpenSSH Socket.
[=A0=A0=A0 6.560000] PM: Adding info for No Bus:can0
[=A0=A0=A0 6.560000] c_can_platform d_can.0: c_can_platform device regi=
stered (regs=3Dfa1cc000, irq=3D52)
[=A0=A0=A0 6.560000] PM: Adding info for No Bus:can1
[=A0=A0=A0 6.560000] c_can_platform d_can.1: c_can_platform device regi=
stered (regs=3Dfa1d0000, irq=3D55)
[=A0=A0=A0 6.720000] PM: Adding info for platform:wl18xx
[=A0=A0=A0 6.840000] <30>systemd[1]: Listening on OpenSSH Socket.
--
[=A0=A0=A0 8.750000] (stk) : debugfs entries created kim_probe Exit
[=A0=A0=A0 8.780000] can: controller area network core (rev 20120528 ab=
i 9)
[=A0=A0=A0 8.780000] NET: Registered protocol family 29
[=A0=A0=A0 8.810000] can: broadcast manager protocol (rev 20120528 t)
[=A0=A0=A0 8.840000] can: raw protocol (rev 20120528)
[=A0=A0=A0 8.900000] c_can_platform d_can.0: can0: setting BTR=3D0504 B=
RPE=3D0000
[=A0=A0=A0 8.910000] c_can_platform d_can.1: can1: setting BTR=3D0504 B=
RPE=3D0000
[=A0=A0=A0 9.600000] SysLink version : 2.21.03.11
[=A0=A0=A0 9.600000] SysLink module created on Date:May=A0 6 2015 Time:=
12:25:37
[=A0=A0=A0 9.610000] PM: Adding info for No Bus:syslinkipc_Osal
[=A0=A0=A0 9.610000] PM: Adding info for No Bus:syslinkipc_Ipc
#=20

[1] https://www.kernel.org/pub/linux/utils/net/iproute2/

Or is that I am missing something in the kernel defconfig do I need to =
enable some via
doing menuconfig to get it working

Thanks,
Sagar
 		 	   		  