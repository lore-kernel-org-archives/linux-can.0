From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: Count dropped frames on CAN socket
Date: Tue, 15 Nov 2016 19:08:05 -0500
Message-ID: <CAGt3f4kH7K98K6Xda+2t0VXSQR20o0MDRp6cJMpoL+U_cTUeEg@mail.gmail.com>
References: <519e768b-887e-0aad-9043-7b6b44a61122@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34823 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932822AbcKPAIg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Nov 2016 19:08:36 -0500
Received: by mail-qk0-f169.google.com with SMTP id n204so156009376qke.2
        for <linux-can@vger.kernel.org>; Tue, 15 Nov 2016 16:08:35 -0800 (PST)
In-Reply-To: <519e768b-887e-0aad-9043-7b6b44a61122@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Hendrix <namniart@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Austin,

If you enable the (SOL_SOCKET, SO_RX_OVFL) option with setsockopt on a
CAN socket, you'll get a corresponding (cmsg_level == SOL_SOCKET,
cmsg_type == SO_RXQ_OVFL) piece of ancillary data from recvmsg. The
value is a uint32_t containing that exact sk_drops value. The
semantics for this value documented in socket(7) are wrong, but the
commit message adding it (3b885787ea41) gives a reasonable
description. In particular, the message doesn't show up at all until
at least one frame is dropped, and it's a total counter not a delta.

Brian

On Tue, Nov 15, 2016 at 6:32 PM, Austin Hendrix <namniart@gmail.com> wrote:
> Hi linux-can,
>
> I'm writing a program which receives CAN frames over SocketCAN. I've found
> on a couple of occasions that my program has had bugs that cause it not to
> empty the CAN socket receive buffer, and the kernel has dropped incoming CAN
> frames.
>
> I had a look through the kernel source code, and found that the kernel's
> socket framework keeps track of dropped frames in the sk_drops field of the
> sock struct. Is there a way to retrieve that dropped frame counter from my
> program, so that it's easier for me to detect problems like this in the
> future? (I've looked in the docs and in /proc and haven't been able to find
> a way to retrieve the sk_drops counter, but it's quite possible that I
> missed something)
>
>
> Thanks,
>
> -Austin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
