From: kedari appana <kedare06@gmail.com>
Subject: (unknown)
Date: Wed, 8 May 2013 11:55:02 +0530
Message-ID: <CANdmM3MFEe-iXinRohUN9rEF-C2CoEg1va=nE7W-=KThogz7sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45408 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3EHGcu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 02:32:50 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so996754pbc.16
        for <linux-can@vger.kernel.org>; Tue, 07 May 2013 23:32:50 -0700 (PDT)
Subject: 
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

Hi,

 if i type the below command i am getting the following errors
# ip link show can0
2: can0: <NOARP40000> mtu 16 qdisc noop qlen 10
    link/[280]
#cat /proc/interrupts
in this i am not getting entry for my can interrupt handler
#./canconfig can0 bitrate 50000 ctrlmode triple-sampling on
this command was successfull but when i debugging it is showing  can0:
bit-timing not yet defined

#If i use ifconfig can0 up
error is can0: bit-timing not yet defined
ifconfig: SIOCSIFFLAGS: Invalid argument
Please help me what is the problem.
regards,
Kedar.
