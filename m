From: kedari appana <kedare06@gmail.com>
Subject: cancompilation
Date: Wed, 8 May 2013 10:52:06 +0530
Message-ID: <CANdmM3Ph_eAR7p+aD1B9w6JbKVOZyG9SvE24=4o-Q_U+6kyj5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:49855 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3EHFWH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 01:22:07 -0400
Received: by mail-pd0-f180.google.com with SMTP id t10so965819pdi.39
        for <linux-can@vger.kernel.org>; Tue, 07 May 2013 22:22:07 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

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
