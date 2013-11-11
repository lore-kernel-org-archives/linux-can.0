From: Swapnil Patil <patilswa@gmail.com>
Subject: Need support J1939 protocol support to my kernel (v3.8 on BeagleBone Black)
Date: Mon, 11 Nov 2013 10:44:07 -0500
Message-ID: <CAO4rUqzNCpyhZjvdwoMD9a2cy9fTvEOCGcwhYwV3uVJO+2V59Q@mail.gmail.com>
Reply-To: patilswa@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:57808 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab3KKPoJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2013 10:44:09 -0500
Received: by mail-la0-f50.google.com with SMTP id eo20so4109844lab.37
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2013 07:44:07 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,

             Thanks for your reply.
I am using Begalbone Black with Ubuntu 13.04
I am able to transmit the RAW and extended can message over the can
bus using can utility
Now I want to use  J1939 stack.
I downloaded the
Linux-can-can-j1939-modules and Linux-can-iproute2-j1939  and tried to
build them but it failed

Log of iproute2-j1939$ make

make[1]: Entering directory `/home/ubuntu/BBB/iproute2-j1939/misc'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include
-DRESOLVE_HOSTNAM -DLIBDIR=3D\"/usr/lib/\" -I  -o arpdarpd.c
=2E./lib/libnetlink.a ../lib/libutil.-ldb -lpthread
gcc: error: arpd: No such file or directory

Log of can-j1939-modules: make
/home/ubuntu/BBB/can-j1939-modules/net/can/j1939/rtnl.c:232:25: error:
=E2struct netlink_skb_parms=E2 has no member named=E2pid=E2
/

      If someone already build this on Begalbone black with ubuntu
13.04 or angstrom kernel Please add the steps

Thanks
Swapnil
