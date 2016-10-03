From: Constantine Vetoshev <gepardcv@gmail.com>
Subject: CAN transmit queue, revisited
Date: Mon, 3 Oct 2016 15:39:12 -0700
Message-ID: <CA+CaSqoBaSJtXprRiQiF-xAo2geuU8qf_yXJAWQaXMwdtMAuQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36092 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcJCWjd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Oct 2016 18:39:33 -0400
Received: by mail-vk0-f66.google.com with SMTP id b186so1612560vkb.3
        for <linux-can@vger.kernel.org>; Mon, 03 Oct 2016 15:39:33 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm using SocketCAN on a project, and have run into trouble with error
recovery. Apologies if this topic has been covered recently, but with
gmane out of commission for newer content, I have found no other
archives of this mailing list to search through.

From everything I read and understand, once the transmit queue fills
up, there is no user-space way to clean it out other than restarting
the CAN network interface. This leaves me scratching my head about how
to recover from bus failures.

Suppose I have a (Linux) process which uses a CAN interface (CANtact
in my case) to talk to a bunch of peripheral devices, and the bus goes
off-line (say, power failure to the peripherals). The peripherals stop
acking all the packets my process has sent. The tx queue fills up
almost immediately with messages I'd been sending. Let's say I detect
this condition (it's pretty obvious, with write() calls setting errno
to ENOBUFS), stop sending, do some internal cleanup... and now what?
My application code can figure out if it needs to retransmit anything,
but even when the CAN peripherals go back online, it doesn't matter:
the tx queue is full, write() calls to it will fail, and I have to
kill the network interface to recover.

I found this post:
http://thread.gmane.org/gmane.linux.can/4167 =E2=80=94 which suggests using
loopback and CAN_RAW_RECV_OWN_MSGS on the socket to send acks to
self-sent frames and thereby drain the tx queue. I tried it, and it
doesn't work. At least with non-blocking sockets. Is there
confirmation that this technique works at all? Before I go down the
road of hacking CAN's kernel modules to stop using the tx queue and
just using fire-and-forget to send every frame, is there a better way
around this?
