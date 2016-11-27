From: Cosmo King <cosmo@iocurrents.com>
Subject: bind() Host is down listening on j1939 interfaces
Date: Sun, 27 Nov 2016 05:33:25 +0000
Message-ID: <69365F77-AAD1-4AE6-AA4A-6BD6819C5B9E@iocurrents.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:40450
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751671AbcK0HHJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 27 Nov 2016 02:07:09 -0500
Content-Language: en-US
Content-ID: <C8B76EA502A2584991BC112BBF033B76@namprd10.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,=20

I'm having a bit of trouble getting the j1939 CAN support working on a Free=
scale i.MX6 UL.=20

We are running Debian 3.14.52 kernel on armv7l patched with j1939 support a=
s per http://elinux.org/J1939 and also compiled the latest can-utils from g=
it://github.com/kurt-vd/can-utils and test-can-j1939.

We have a real working can interface on can0 that we start like this:
root@dart3:~# ip link set can0 up type can bitrate 250000

And also added a vcan interface for testing just in case:
root@dart3:~# ip link add can2 type vcan
root@dart3:~# ip link set can2 up

root@dart3:~# ifconfig
can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-=
00-00-00 =20
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:142=20

can2      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-=
00-00-00 =20
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

testj1939 cannot listen on either can0 or can2.  The error is: testj1939: b=
ind(): Host is down

root@dart3:~# testj1939 -r can0:
- socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
- bind(, can0:,,, 24);
testj1939: bind(): Host is down

root@dart3:~# testj1939 -r can2:
- socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
- bind(, can2:,,, 24);
testj1939: bind(): Host is down

I tested this same scenario on a Debian VM with 3.18 kernel and vcan and it=
 worked fine.  Any suggestions?

Thank you!
Cosmo



