From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch flexcan driver to use it
Date: Tue, 04 Oct 2016 08:32:15 +0200
Message-ID: <87zimk8w0g.fsf@gmail.com>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de> <878tv48bhm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbcJDGcT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 02:32:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id p138so17975939wmb.0
        for <linux-can@vger.kernel.org>; Mon, 03 Oct 2016 23:32:18 -0700 (PDT)
In-Reply-To: <878tv48bhm.fsf@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Holger Schurig <holgerschurig@gmail.com> writes:

> Then they did same CAN ping-ping test with reboots and wrote: "Out of
> about 16,000 reboots we had one failure. This failed both CAN interfaces
> and the logs show that the PTX-C received all CAN messages and returned
> them, but the test machine for some reason did not receive any CAN
> messages."

It turned out that the error was not in the FlexCAN + rx-fifo patches,
but at the receiving end.

So you can have a "Tested-By: Holger Schurig <holgerschurig@gmail.com>"
for your patch series on top of 4.7.5.
