From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: AM335x CAN WakeUp (CTL-Reg bit WUBA), BeagleBone Black/Green
Date: Sun, 15 Jan 2017 23:40:24 +0100
Message-ID: <zarafa.587bfa58.6c0f.7496a8dc35275a84@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:38325 "EHLO
        euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdAOWk0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Jan 2017 17:40:26 -0500
Received: from euve35974.vserver.de (localhost.localdomain [127.0.0.1])
        by euve35974.vserver.de (Postfix) with ESMTP id 506A57580384
        for <linux-can@vger.kernel.org>; Sun, 15 Jan 2017 23:40:24 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>

Hello,

oops, did I miss something or is it really the truth that noone reading this mailinglist has experience with Linux (socketcan) CAN WakeUp (especially AM335x SOC like BBB/BBG)?

Any feedback/hint how to start with this specific topic is very appreciated!

Thanks and Regards
Michael

-----Ursprüngliche Nachricht-----
Von:	Michael Luxen <mluxen@gmx.net>
Gesendet:	Mi 11.01.2017 17:01
Betreff:	AM335x CAN WakeUp (CTL-Reg bit WUBA), BeagleBone Black/Green
An:	linux-can@vger.kernel.org; 
> Hello,
> 
> did anyone of you already have some experience with CAN WakeUp functionality 
> and the current Linux kernel implementation/situation for AM335x SOCs?
> 
> I like to use such "Wakeup From Local Power Down state" on a BeagleBone 
> Black/Green but for me it's currently unclear how to configure the WUBA bit of 
> CTL-register to activate this functionality with Debian Linux Kernel 4.4 I'm 
> using on my BBG wireless.
> I don't find a good source on the internet explaining it for me so I'm asking!
> 
> The only source I've seen which is directly mentioning the WUBA bit is located 
> here:
> 
> https://android.googlesource.com/kernel/lk/+/upstream-master/platform/am335x/ti/
> drivers/dcan.c
> 
> But I can't find this reference in the Linux kernel up to 4.10.xx
> 
> Hopefully someone of you can point me to the right direction (URL, 
> documentation, HowTo) or give me some hints!
> 
> Thanks & Regards
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
