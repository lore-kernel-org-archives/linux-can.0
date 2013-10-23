From: Nathan Conrad <nconrad.mlock@gmail.com>
Subject: Re: iso-tp: timeout handling for unknown packet size
Date: Wed, 23 Oct 2013 09:40:08 -0500
Message-ID: <CABLFF-=Rxi7Gtpr+OD5q5QsjD5fnrcZQaTJFoeT9a8UzuMbSEA@mail.gmail.com>
References: <CAJA4uhcj+ySw1j64vz4Ao1t62YzYcZfoNLkjsmFg-Pqf+mjy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34458 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3JWOkK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2013 10:40:10 -0400
Received: by mail-wi0-f177.google.com with SMTP id h11so995260wiv.10
        for <linux-can@vger.kernel.org>; Wed, 23 Oct 2013 07:40:09 -0700 (PDT)
In-Reply-To: <CAJA4uhcj+ySw1j64vz4Ao1t62YzYcZfoNLkjsmFg-Pqf+mjy4g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Cc: linux-can <linux-can@vger.kernel.org>, Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>

You could also add a filter for the ISO-TP reception ID to a raw
protocol socket and monitor the reception of packets that way.  Non
ISO-TP packets shouldn't be on that ID.

Nathan Conrad

On Wed, Oct 23, 2013 at 8:32 AM, Josselin Costanzi
<josselin.costanzi@mobile-devices.fr> wrote:
> Hello,
>
> We are working with the current implementation of ISO-TP from Oliver
> Hartkopp available on github. The implementation works well for us
> with a slight limitation that we would like to discuss here.
>
> We use ISO-TP to talk to OBD ECUs. In this context, our userspace
> opens an ISO-TP socket and sends an OBD-CAN request to the ECU and
> waits for a response over ISO-TP. To be able to receive large frames
> over ISO-TP or to account for transmitter having a large inter frame
> delay, we have to use large timeout values so we don't close the
> socket while the packet is still being received.
>
> We would like to know if an ECU is responding or not without having to
> wait several seconds for a hypotetical packet to be received, do you
> have any idea how we could do that?
>
> Thanks,
>
> --
> Josselin Costanzi
>   Embedded Linux System Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
