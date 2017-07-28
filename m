From: aivs <aivs@yandex.ru>
Subject: Re: Researching of Skoda CAN bus
Date: Fri, 28 Jul 2017 23:15:53 +0300
Message-ID: <1626691501272953@web15j.yandex.ru>
References: <586311501104080@web44o.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from forward4o.cmail.yandex.net ([37.9.109.248]:47902 "EHLO
        forward4o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752660AbdG1UXU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2017 16:23:20 -0400
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:167])
        by forward4o.cmail.yandex.net (Yandex) with ESMTP id 430D920BFB
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2017 23:15:54 +0300 (MSK)
In-Reply-To: <586311501104080@web44o.yandex.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Don't worry, combination founded.

#!/bin/bash
cansend can0 381#010CC4802000
cansend can0 381#010CC4802000
cansend can0 381#010CC4800000
cansend can0 381#010CC4800000
cansend can0 381#010CC4800000

-- 
Yurkin Vitaliy
Home automation engineer
~~~~~~~~~~~~~~~~~~~~~~
z-wave.me
email: aivs@z-wave.me


27.07.2017, 00:21, "aivs" <aivs@yandex.ru>:
> Hi, my name is Vitaliy, I'm smart home developer.
> As a hobby I'm researching CAN bus of my Skoda Octavia 2011. I founded commands to control car devices, like this:
> // Front Left Glass Up/Down
> cansend can0 181#0200
> cansend can0 181#0800
>
> // Front Right Glass Up/Down
> cansend can0 181#2000
> cansend can0 181#8000
>
> // Central Lock Open/Close
> cansend can0 291#09AA020000
> cansend can0 291#0955040000
>
> and many others.
>
> Now I tried to add function "Keyless" to open the trunk foot. For that I need CAN a command to open the trunk.
> When I press trunk button candump shows:
> 400#00 02 0B 14 30 04 00 00
> 291#09 00 08 00 00
> 591#30 10 0F 0C 40 9C 00 00
>
> When I press button on key fob candump shows the same.
> When I press button on key fob of additional alarm system candump shows the same.
>
> But, when I try to send those command nothing happens. I don't understand why trunk doesn't open.
> May be you can get me recommendation how to open a trunk with CAN commands!
>
> --
> Yurkin Vitaliy
> Home automation engineer
> ~~~~~~~~~~~~~~~~~~~~~~
> z-wave.me
> email: aivs@z-wave.me
