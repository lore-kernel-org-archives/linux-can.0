From: aivs <aivs@yandex.ru>
Subject: Researching of Skoda CAN bus
Date: Thu, 27 Jul 2017 00:21:20 +0300
Message-ID: <586311501104080@web44o.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from forward100o.mail.yandex.net ([37.140.190.180]:34660 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750996AbdGZV2p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2017 17:28:45 -0400
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 295522A25953
        for <linux-can@vger.kernel.org>; Thu, 27 Jul 2017 00:21:21 +0300 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi, my name is Vitaliy, I'm smart home developer.
As a hobby I'm researching CAN bus of my Skoda Octavia 2011. I founded commands to control car devices, like this:
// Front Left Glass Up/Down
cansend can0 181#0200
cansend can0 181#0800

// Front Right Glass Up/Down
cansend can0 181#2000
cansend can0 181#8000

// Central Lock Open/Close
cansend can0 291#09AA020000
cansend can0 291#0955040000

and many others.

Now I tried to add function "Keyless" to open the trunk foot. For that I need CAN a command to open the trunk. 
When I press trunk button candump shows:
400#00 02 0B 14 30 04 00 00
291#09 00 08 00 00
591#30 10 0F 0C 40 9C 00 00

When I press button on key fob candump shows the same.
When I press button on key fob of additional alarm system candump shows the same.

But, when I try to send those command nothing happens. I don't understand why trunk doesn't open. 
May be you can get me recommendation how to open a trunk with CAN commands!

-- 
Yurkin Vitaliy
Home automation engineer
~~~~~~~~~~~~~~~~~~~~~~
z-wave.me
email: aivs@z-wave.me
