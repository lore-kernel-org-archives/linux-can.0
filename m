From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Need help in interpreting ip status output
Date: Fri, 6 Mar 2020 21:13:00 +0100
Message-ID: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:35731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFUNC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Mar 2020 15:13:02 -0500
Received: from [192.168.2.106] ([84.176.153.207]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1jj5vb3Iot-00aILM for
 <linux-can@vger.kernel.org>; Fri, 06 Mar 2020 21:13:00 +0100
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

can someone help me interpreting the following ip output:

ip -s link show can1
      3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 100
          link/can
          RX: bytes  packets  errors  dropped overrun mcast
          0          9987413  1       74      1       0
          TX: bytes  packets  errors  dropped carrier collsns
          0          0        0       0       0       0

I'm especially interested in the meaning of the

* 1 errors
* 74 dropped
* 1 overrun

fields.

Thanks and best regards,
Andr=C3=A9
