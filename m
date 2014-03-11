From: Austin Schuh <austin@peloton-tech.com>
Subject: Stuck vcan
Date: Mon, 10 Mar 2014 17:22:53 -0700
Message-ID: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52727 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbaCKAWx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Mar 2014 20:22:53 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so8132116iec.18
        for <linux-can@vger.kernel.org>; Mon, 10 Mar 2014 17:22:53 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am seeing the following

uname -a
$ Linux vpc3 3.10-3-rt-amd64 #1 SMP PREEMPT RT Debian 3.10.11-1
(2013-09-10) x86_64 GNU/Linux

syslog:
Mar 10 16:29:56 vpc3 kernel: [355322.806011] Dead loop on virtual device
vcan2, fix it urgently!
Mar 10 16:49:12 vpc3 kernel: [356480.638351] Dead loop on virtual device
vcan2, fix it urgently!

austin[4262] vpc3 ~
$ ifconfig vcan2
vcan2     Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:76160257 errors:0 dropped:0 overruns:0 frame:0
          TX packets:76160257 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:609282056 (581.0 MiB)  TX bytes:609282056 (581.0 MiB)

Any thoughts?  I don't see this happen very often.  The write call on the
socket fails when this happens.  It is generally when I'm sending a large
number of messages on multiple vcans from multiple processes at once.

Austin
