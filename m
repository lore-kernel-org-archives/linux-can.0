From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: at91 driver lost CAN messages
Date: Sun, 12 Mar 2017 00:06:02 +0100
Message-ID: <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:12307 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbdCKXGG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Mar 2017 18:06:06 -0500
In-Reply-To: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Efim,

On 03/10/2017 02:48 PM, Efim Monjak wrote:

> If napi polling is deactivated by follow change no more receive overflow
> error occurs.

thanks for the patch!

In fact I always thought NAPI is too heavy for CAN controllers. NAPI was 
intended for a very high interrupt load on some ethernet controllers 
with some considerable RX FIFO.

I have a 20 CAN interfaces (SJA1000 driver) Core i7 system receiving 
~22.000 frames/s without any problems, with an one-element FIFO and 
without NAPI.

@Marc: What was the reason to implement NAPI that days? Has it ever been 
proved that NAPI had a remarkable positive effect in opposite to a 
direct CAN frame processing in the interrupt context?

Regards,
Oliver
