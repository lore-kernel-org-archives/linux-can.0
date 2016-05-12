From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: CAN message timestamping
Date: Wed, 11 May 2016 19:07:11 -0700
Message-ID: <CANGgnMak_Rs9cQD4LYgQOObB1vv6mOzweLDFkTgyMM9bDKp9PA@mail.gmail.com>
References: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
 <56F23F1F.6040101@hartkopp.net> <CANGgnMaOs03rJByb9KVFFG1p45ZuWZ4qt8-F7y6oqtdDveNs2A@mail.gmail.com>
 <CANGgnMbzfVcK+PgAeFMFHjCZMCSosHE2xfctOfkdFb=+ZHrQaw@mail.gmail.com>
 <CANGgnMaK0wXwsKJZB0SssPje9r6qCVYUQzbJsqW+BdSDCQ1iPA@mail.gmail.com>
 <56FBC3C4.80400@hartkopp.net> <CANGgnMa3OJxiK=7bQo3MHmWR3+O0-4LwfgXf9CV2oePUY0gtBg@mail.gmail.com>
 <5702C43C.4000506@hartkopp.net> <CANGgnMbPmrCxCXddj_hOhTc6v3uHrtMtmfDZLOYjs+4TLjSdkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34787 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbcELCHc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2016 22:07:32 -0400
Received: by mail-yw0-f178.google.com with SMTP id j74so60613417ywg.1
        for <linux-can@vger.kernel.org>; Wed, 11 May 2016 19:07:31 -0700 (PDT)
In-Reply-To: <CANGgnMbPmrCxCXddj_hOhTc6v3uHrtMtmfDZLOYjs+4TLjSdkA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>

On Mon, Apr 4, 2016 at 1:32 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> Ok!  I *think* I have enough to put together a first patch for
> comments and test it on my SJA1000 and on vcan.  Thanks!  If you have
> other thoughts, please let me know.

Turns out  the entire infrastructure has been deprecated in newer
kernels, and we didn't notice on our old 3.14 kernel (RT patches and
the validation associated with change have kept us from upgrading).
We had to roll back the 2 patches which removed support for the
timestamps from our 4.1 RT kernel in order to make this work there.

I think that kind of kills the idea, unless you are more clever than us.

Austin
