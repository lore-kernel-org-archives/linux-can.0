From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: udev rule for SLCAN devices
Date: Fri, 24 Jan 2014 15:32:56 +0100
Message-ID: <CAGm1_ktxMA0rNRaPLyf3QUXW+-4HiYQ6QtMyNiy+6=h7=H7yHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:55029 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbaAXOdS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2014 09:33:18 -0500
Received: by mail-bk0-f53.google.com with SMTP id my13so1178411bkb.40
        for <linux-can@vger.kernel.org>; Fri, 24 Jan 2014 06:33:17 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I've tried following hack to automatically add slcan0, when I attach
my USB-CAN adapter:
https://libbits.wordpress.com/2014/01/23/automatically-bring-up-slcan-device-via-udev/

It would be great, if we could unify the whole stuff and submit udev
rule and related script to systems or whatever project manages such
rules..

The script should perform following:

1. on add action start slcand, on remove action shutdown slcand
2. if we attach second device it should create slcan1 etc. and
shutdown related slcand for slcan1 etc.
3. as for now the bitrate must be configured in this script, it would
be really great, if SLCAN devices could change their speed via ntelink
interface, because in this case, the script would only care about
bringing interface/slcand up and down.

Let me know, what you think about it.

Regards,
Yegor
