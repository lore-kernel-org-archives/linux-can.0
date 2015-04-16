From: Maxime Vinci <maxime.vinci@gmail.com>
Subject: BCM cyclic transmission tasks : cpu load
Date: Thu, 16 Apr 2015 19:28:33 +0200
Message-ID: <CAA_20DA1UmnyrMSOy8vS1HRyhMm7xbjta1BZdK9Gfe1x2MAXBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35695 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbbDPR3O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Apr 2015 13:29:14 -0400
Received: by igbyr2 with SMTP id yr2so83979118igb.0
        for <linux-can@vger.kernel.org>; Thu, 16 Apr 2015 10:29:13 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hello all,

This is my first message on a mailing list like this one, please be gentle ;)

Currently, I am using the SocketCAN BCM feature to setup cyclic frame
transmissions.

Setting up everything appears to work fine : I can create multiple
tasks with different periods, with one or more frames in each one.

I would like to use it inside a Qt application (with qml based user
interface), but it seems that right when I set up the first cyclic
task, the cpu load increase from ~5% to 100%.

Even when all tasks are deleted (by using the opcode TX_DELETE), the
cpu load stays at the same level.

To see if the UI was messing it up, I wrote a simple test program
where I call the BCM functions to set up some cyclic tasks before
entering a Qt application event loop (a simple "Hello world" app).

It showed me that the cpu load goes crazy when the event loop starts.

Correct me if I am wrong, but according to these 2 behaviors, it could
be assumed that the issue happens every time the BCM and a Qt-based UI
are being used together.

Does anyone have any hints about this particular issue ?

Thank you !


PS: I did not try to put the object that wraps the BCM features in a
new thread, but I think this will not solve the problem. (this is kind
of done inside SocketCan, right ?)


Best regards,

Maxime
