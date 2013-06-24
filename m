From: Luka Rahne <luka.rahne@gmail.com>
Subject: Receiving messages issue
Date: Mon, 24 Jun 2013 14:26:06 +0200
Message-ID: <CAOHwv57B+vq6aTc-Yep9jZvxbnQ0Bpe2149KMSe1On93OACDjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:41774 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3FXM0H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Jun 2013 08:26:07 -0400
Received: by mail-qa0-f48.google.com with SMTP id cm16so2144526qab.0
        for <linux-can@vger.kernel.org>; Mon, 24 Jun 2013 05:26:06 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am using MCP2515 with  i.MX27

Now my problem is that candump (and my application) doesn't receive
all messages.

I have multiple devices (low end Freescale mcf51JM) on Can that each
send  message at boot-up. If I turn-on all nodes at same time, they
send all messages at same time.

For some reason that makes problem for i.MX27 system

Beside single i.MX27 on bus and 5 mcf51JM nodes there is also PEAK-CAN
usb device for sniffing.

luka@pcan-usb:~$ candump any
  can0      2002  [8] 48 61 69 46 6F 6C 6B 7A
  can0      2012  [8] 48 61 69 46 6F 6C 6B 7A
  can0      2022  [8] 48 61 69 46 6F 6C 6B 7A
  can0      2032  [8] 48 61 69 46 6F 6C 6B 7A
  can0      2042  [8] 48 61 69 46 6F 6C 6B 7A
//this if fine


luka@iMX27:~$ candump
interface = can0, family = 29, type = 3, proto = 1
<0x00002002> [8] 48 61 69 46 6f 6c 6b 7a
<0x00002012> [8] 48 61 69 46 6f 6c 6b 7a
<0x00002032> [8] 48 61 69 46 6f 6c 6b 7a
<0x00002042> [8] 48 61 69 46 6f 6c 6b 7a


As You can see iMX27 lost message (  can0      2022  [8] 48 61 69 46
6F 6C 6B 7A <- is lost )
and this happens each restart on all mcf51JM nodes so it is predictable.

There were some freezing kernel/stalling issue @ kernel 3.0.4 but they
are gone since i compiled on 3.0.81.
Kernel is 3.0.81

I am  new with all this, so any pointers will be appreciated.
