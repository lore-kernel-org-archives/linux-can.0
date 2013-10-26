From: Brennan Ashton <bashton@brennanashton.com>
Subject: Re: MCP251x bit rate calculations wrong
Date: Sat, 26 Oct 2013 10:26:03 -0700
Message-ID: <CANQdSEHbU1PfoLG4oOK+epKOp-pyn3n9E4xCsHJQMh5Y9znTng@mail.gmail.com>
References: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33630 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab3JZR0F (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Oct 2013 13:26:05 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so5093176wgg.20
        for <linux-can@vger.kernel.org>; Sat, 26 Oct 2013 10:26:03 -0700 (PDT)
In-Reply-To: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I did not see this line:
1024 >---priv->can.clock.freq = pdata->oscillator_frequency / 2;$

So the kernel driver should be fine but in can utils this should still
be fixed for the -1

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index ecf5cb6..242e1ef 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -192,7 +192,7 @@ static void printf_btr_mcp251x(struct
can_bittiming *bt, int hd
        if (hdr) {
                printf("CNF1 CNF2 CNF3");
        } else {
-               cnf1 = ((bt->sjw - 1) << 6) | bt->brp;
+               cnf1 = ((bt->sjw - 1) << 6) | (bt->brp-1);
                cnf2 = 0x80 | ((bt->phase_seg1 - 1) << 3) | (bt->prop_seg - 1);
                cnf3 = bt->phase_seg2 - 1;
                printf("0x%02x 0x%02x 0x%02x", cnf1, cnf2, cnf3);


On Sat, Oct 26, 2013 at 10:08 AM, Brennan Ashton
<bashton@brennanashton.com> wrote:
> The bit timing calculations in can-utils are certainly wrong, and
> after a quick look at the ones that make up the kernel is appears that
> they are not quite right as well.
>
> From the datasheet:
> TQ = 2*(BRP-1)/Fosc
>
> Looking at the kernel:
>
> can/dev.c defines best brp as:
> 182 >---v64 = (u64)best_brp * 1000000000UL;
> 183 >---do_div(v64, priv->clock.freq);
> 184 >---bt->tq = (u32)v64;
> ...
> 201 >---bt->brp = best_brp;$
>
> so TQ[ns] = BRP/Fosc
>
> in can/mcp251x.c
>
> 592 >---mcp251x_write_reg(spi, CNF1, ((bt->sjw - 1) << CNF1_SJW_SHIFT) |
> 593 >--->--->---  (bt->brp - 1));
>
> This is missing the key /2 factor but does take into account the -1
>
> Now looking at can-calc-bit-timing.c from can-utils:
>
> 195 >--->---cnf1 = ((bt->sjw - 1) << 6) | bt->brp;$
>
> This is wrong as it is missing both the -1 and the /2
> I have tested this corrected timing  on the MCP2515 at 20MHz Fosc and
> 20k bitrate.  It worked with the corrected calculations but not
> before.
>
> There is a little more work than just adjusting the calculation as the
> limits and the best bpr calc must be adjusted for the /2.  I can write
> some patches up unless someone thinks I am missing something.
>
> --Brennan Ashton
